import 'package:flutter/material.dart';

class UsersSelector extends StatefulWidget {
  @override
  _UsersSelectorState createState() => _UsersSelectorState();
}

class _UsersSelectorState extends State<UsersSelector> {
  int _selectedIndex = 0;
  final List<String> categories = ['Users', 'Repositories', 'Events', 'Etc.'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                _selectedIndex = index;
                print(_selectedIndex);
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Text(
                categories[index],
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: index==_selectedIndex?Colors.white:Colors.white60,
                    fontSize: 18.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
