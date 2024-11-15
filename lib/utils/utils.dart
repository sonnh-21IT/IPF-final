import 'dart:convert';
import 'dart:math';

import 'package:config/models/place.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class Utils {
  static bool isCustomer = true;

  static List<double> calculateViewBox(double lat, double lon, double radius) {
    var r = 6378137;

    var dLat = radius / r;
    var dLon = radius / (r * cos(pi * lat / 180));

    double southWestLat = lat - dLat * 180 / pi;
    double northEastLat = lat + dLat * 180 / pi;
    double southWestLon = lon - dLon * 180 / pi;
    double northEastLon = lon + dLon * 180 / pi;

    return [southWestLon, northEastLat, northEastLon, southWestLat];
  }

  static Future<Place> getPlaceByLocation(LocationData location) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${location.latitude}&lon=${location.longitude}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      print("data: $data");

      final displayName = data['display_name'];
      final addressParts = displayName.split(',');
      final address =
          '${addressParts[1]}, ${addressParts[2]}, ${addressParts[3]}, ${addressParts[4]}';

      return Place(
          placeId: DateTime.now().millisecondsSinceEpoch,
          lat: location.latitude!,
          lon: location.longitude!,
          name: 'Vị trý hiện tại',
          displayName: data['display_name'],
          address: address);
    } else {
      throw Exception('Failed to load places: ${response.statusCode}');
    }
  }


}
