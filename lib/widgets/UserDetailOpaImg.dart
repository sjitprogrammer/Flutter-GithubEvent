import 'package:flutter/material.dart';

class UserDetailOpaImg extends StatelessWidget {
  final imageUrl;

  const UserDetailOpaImg({Key key,@required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          imageUrl,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.fill,
        ),
        Container(color: Theme.of(context).primaryColor.withOpacity(0.85),)
      ],
    );
  }
}
