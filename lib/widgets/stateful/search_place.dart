import 'package:config/models/place.dart';
import 'package:flutter/material.dart';

import 'package:config/widgets/stateless/translator_profile_dialog.dart';

import '../../models/user.dart';

class SearchPlace extends StatefulWidget {
  final Users users;
  final List<Place> places;

  const SearchPlace({super.key, required this.places, required this.users});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  List<Place> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.places;
  }

  void filterSearch(String query) {
    setState(() {
      filteredList = widget.places
          .where(
              (place) => place.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void onItemClicked(Place place) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TranslatorProfileDialog(
          users: widget.users,
          onConnect: () {},
          onFinish: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              onChanged: filterSearch,
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(15),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green,
                  child: Icon(
                    index == 0 ? Icons.my_location : Icons.location_on,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                title: Text(
                  filteredList[index].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  filteredList[index].displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.pop(context);
                  onItemClicked(filteredList[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
