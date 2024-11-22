import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/models/book_item.dart';
import 'package:config/models/field.dart';
import 'package:config/models/language.dart';
import 'package:config/models/position.dart';
import 'package:config/services/account_service.dart';
import 'package:config/services/book_service.dart';
import 'package:config/services/field_service.dart';
import 'package:config/services/language_service.dart';
import 'package:config/services/position_service.dart';
import 'package:config/services/role_service.dart';
import 'package:config/utils/handle_item_change.dart';
import 'package:config/widgets/stateless/connected_dialog.dart';
import 'package:config/widgets/stateless/form_dialog.dart';
import 'package:config/widgets/stateless/project_dialog.dart';
import 'package:config/widgets/stateless/searching_dialog.dart';
import 'package:config/widgets/stateless/translator_profile_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:config/widgets/stateless/verification_dialog.dart';
import 'package:config/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:config/models/role.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with WidgetsBindingObserver {
  GoogleMapController? _mapController;
  LocationData? _currentLocation;
  late Location _location;
  String _mapStyle = '';
  String _documentId = '';
  StreamSubscription<LocationData>? _subscription;
  bool _isSearching = false;
  bool _isInterpreterSearch = true;
  String uId = FirebaseAuth.instance.currentUser!.uid;
  StreamSubscription<QuerySnapshot>? _bookSubscription;
  final Set<Marker> _markers = {};
  Users? _translator;
  Users? _userConnect;
  List<LatLng> _routePoints = [];
  List<Users> _activeUsers = [];
  List<Users> _breakUsers = [];

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _initialize();
  }

  void _subscribeItemChanges(String idCustomer, String idTranslator) {
    _bookSubscription = BookService.getConnect(idCustomer, idTranslator)
        .listen((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        Users user = await AccountService.fetchUserByAccountId(uId);
        var changes = snapshot.docChanges
            .where((change) => change.type == DocumentChangeType.modified)
            .toList();
        if (changes.isNotEmpty) {
          var doc = changes.first.doc;
          var data = doc.data() as Map<String, dynamic>?;
          if (data != null) {
            if (data['idCustomer'] == user.userId) {
              if (data['status'] == -1) {
                Navigator.of(context).pop();
                HandleItemChange.showDialogOnChange(
                    "Phiên dịch viên đã từ chối kết nối",
                    Color(0xFF4CAF50),
                    context);
                setState(() {
                  _isSearching = false;
                });
              }
            }
            if (data['idTranslator'] == user.userId) {
              if (data['status'] == 2) {
                HandleItemChange.showDialogOnChange(
                    "Dự án đã hoàn thành", Color(0xFF4CAF50), context);
                setState(() {
                  _isSearching = false;
                });
              }
            }
          }
        }
      }
    });
  }

  void _monitorBookingItems(String idTranslator) {
    BookService.trackBookings().listen((QuerySnapshot bookingSnapshot) {
      for (var bookingDoc in bookingSnapshot.docs) {
        bookingDoc.reference
            .collection("item")
            .snapshots()
            .listen((QuerySnapshot itemSnapshot) async {
          for (var itemDoc in itemSnapshot.docChanges) {
            if (itemDoc.type == DocumentChangeType.added) {
              var data = itemDoc.doc.data() as Map<String, dynamic>;
              if (data['idTranslator'] == idTranslator) {
                BookItem item = BookItem(
                  itemId: itemDoc.doc.id,
                  fieldId: data['fieldId'],
                  languageId: data['languageId'],
                  salary: data['salary'],
                  status: data['status'],
                  isPrepay: data['isPrepay'],
                  idTranslator: data['idTranslator'],
                  idCustomer: data['idCustomer'],
                  timestamp: data['timestamp'],
                );
                Language? lang =
                    await LanguageService.readLanguage(item.languageId);
                Field? field = await FieldService.readField(item.fieldId);
                _subscribeItemChanges(item.idCustomer!, item.idTranslator!);
                if (data['status'] == 0) {
                  showDialog(
                      context: context,
                      builder: (context) => ProjectDialog(
                          bookItem: item,
                          onConfirm: onConfirm,
                          lang: lang!,
                          field: field!,
                          onCancel: (item) async {
                            await updateBookItem(item, -1);
                          }));
                }
              }
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _stopTracking();
    _bookSubscription?.cancel();
    updateStatus(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_currentLocation != null)
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  _currentLocation!.latitude!, _currentLocation!.longitude!),
              zoom: 14,
            ),
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            markers: _markers,
            polylines: {
              if (_routePoints.isNotEmpty)
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: _routePoints,
                  color: Colors.blue,
                  width: 4,
                ),
            },
          ),
        Positioned(
          right: 16,
          top: (MediaQuery.of(context).size.height / 2) - 28,
          child: _isSearching
              ? GestureDetector(
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_translator != null) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: false,
                          builder: (context) => ConnectedDialog(
                            name: _translator!.fullName,
                            onFinishJob: () {
                              onFinish();
                            },
                          ),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => SearchingDialog(onCancel: () {
                                  updateStatus(false);
                                  setState(() {
                                    _isSearching = false;
                                  });
                                }));
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    child: const CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                )
              : FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: _showDialog,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.search_rounded),
                ),
        )
      ],
    );
  }

  Future<void> _initialize() async {
    _location = Location();
    await _getLocation();
    if (_currentLocation != null) {
      await _setupFireStoreDocument();
      _startTracking();
    }
  }

  Future<void> _setupFireStoreDocument() async {
    var collection = FirebaseFirestore.instance.collection('positions');
    Users user = await AccountService.fetchUserByAccountId(uId);
    var querySnapshot =
        await collection.where('userId', isEqualTo: user.userId).get();
    if (querySnapshot.docs.isNotEmpty) {
      var docRef = querySnapshot.docs.first.reference;
      _documentId = docRef.id;
      await PositionService.updateFireStoreLocation(
          _currentLocation!, docRef.id);
    } else {
      var docRefId =
          await PositionService.createLocationInFireStore(_currentLocation!);
      _documentId = docRefId;
    }
  }

  void _startTracking() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _subscription =
        _location.onLocationChanged.listen((LocationData currentLocation) {
      PositionService.updateFireStoreLocation(currentLocation, _documentId);
    });
  }

  void _stopTracking() {
    _subscription?.cancel();
    PositionService.deleteLocation(_documentId);
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString('assets/map.json');
    setState(() {
      _mapStyle = style;
    });
  }

  Future<void> _getLocation() async {
    try {
      var currentLocation = await _location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController!.setMapStyle(_mapStyle);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return VerificationDialog(
          onTranslatorSelected: () {
            setState(() {
              _isInterpreterSearch = true;
              _isSearching = true;
            });
            updateStatus(true);
            onTranslatorSearch();
          },
          onCustomerSelected: () {
            setState(() {
              _isInterpreterSearch = false;
            });
            showDialog(
                context: context,
                builder: (context) => FormDialog(
                      onDone: (item) {
                        Navigator.of(context).pop();
                        setState(() {
                          _isInterpreterSearch = false;
                          _isSearching = true;
                        });
                        updateStatus(true);
                        onCustomerSearch(item);
                      },
                    ));
          },
        );
      },
    );
  }

  Future<void> onCustomerSearch(BookItem item) async {
    Role? role = await RoleService.getRoleByValue("Phiên dịch viên");
    print('role: ${role!.roleId}');
    List<Users> users =
        await AccountService.fetchActiveUsers(true, role.roleId);
    Users currentUser = await AccountService.fetchUserByAccountId(uId);
    setState(() {
      _activeUsers = users;
      _breakUsers.add(currentUser);
    });
    List<Users> filteredUsers =
        _activeUsers.where((user) => !_breakUsers.contains(user)).toList();
    _userConnect = filteredUsers[0];
    print('interpreter: ${_userConnect!.userId}');
    if (_activeUsers.isNotEmpty) {
      showMyDialog(_userConnect!, currentUser.userId!, item);
    } else {
      print('No interpreters available');
    }
  }

  Future<void> onTranslatorSearch() async {
    Users user = await AccountService.fetchUserByAccountId(uId);
    _monitorBookingItems(user.userId!);
  }

  void showMyDialog(Users translator, String customerId, BookItem item) {
    showDialog(
        context: context,
        builder: (context) => TranslatorProfileDialog(
              users: translator,
              onConnect: () async {
                await startConnection(customerId, translator.userId!, item);
                setState(() {
                  getTranslator(translator.userId!);
                });
              },
              onFinish: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  onFinish();
                });
              },
              onBreak: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                  setState(() {
                    _breakUsers.add(_userConnect!);
                  });
                  onCustomerSearch(item);
                });
              },
            ));
  }

  Future<void> startConnection(
      String customerId, String translatorId, BookItem item) async {
    await BookService.connect(customerId, translatorId, item);
    _subscribeItemChanges(customerId, translatorId);
  }

  Future<void> updateStatus(bool isActive) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Users user = await AccountService.fetchUserByAccountId(uId);
      await AccountService.updateUserStatus(user.userId!, isActive);
      setState(() {
        _isSearching = isActive;
      });
    });
  }

  Future<void> onConfirm(BookItem item) async {
    await updateBookItem(item, 1);
    setState(() {
      _isSearching = false;
    });
    if (_isInterpreterSearch) {
      direction(item.idCustomer!);
    } else {
      direction(item.idTranslator!);
    }
  }

  Future<void> updateBookItem(BookItem item, int status) async {
    await BookService.updateStatus(item, status);
  }

  Future<void> direction(String otherId) async {
    Position otherPosition = await PositionService.getPositionByUserId(otherId);

    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('target'),
        position: LatLng(otherPosition.latitude, otherPosition.longitude),
      ));
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(otherPosition.latitude, otherPosition.longitude),
            zoom: 14,
          ),
        ),
      );
      _getDirections(otherPosition);
    });
  }

  Future<void> _getDirections(Position position) async {
    // if (_currentLocation == null) return;
    // final response = await http
    //     .get(Uri.parse('http://router.project-osrm.org/route/v1/driving/'
    //         '${_currentLocation!.longitude},${_currentLocation!.latitude};'
    //         '${position.longitude},${position.latitude}'
    //         '?overview=full&geometries=geojson&steps=true'));
    //
    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body);
    //   print(response.body);
    //   final List<dynamic> coordinates =
    //       json['routes'][0]['geometry']['coordinates'];
    //   _routePoints = coordinates
    //       .map((coordinate) => LatLng((coordinate[1]).toDouble(), (coordinate[0]).toDouble()))
    //       .toList();
    // } else {
    //   throw Exception('Failed to load directions');
    // }
  }

  Future<void> getTranslator(String translatorId) async {
    _translator = await AccountService.fetchUserById(translatorId);
  }

  Future<void> onFinish() async {
    Navigator.of(context).pop();
    Users user = await AccountService.fetchUserByAccountId(uId);
    print(user.userId);
    BookItem? item =
        await BookService.fetchLatestBookingByUserIdWithStatus(user.userId!, 1);
    await updateBookItem(item!, 2);
    setState(() {
      _isSearching = false;
      _routePoints = [];
      _markers.clear();
    });
  }
}
