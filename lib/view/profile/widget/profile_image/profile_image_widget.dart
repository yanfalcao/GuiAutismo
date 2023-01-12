import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  String urlImage;

  ProfileImageWidget({@required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: CircleAvatar(
        backgroundImage: NetworkImage(this.urlImage),
      ),
    );
  }
}
