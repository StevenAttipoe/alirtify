import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({ Key? key }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchString = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search,size: 37),
            )
           ),
          ),
        ),
      ]
    );
  }
}
