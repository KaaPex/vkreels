import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.radius, this.backgroundImage}) : super(key: key);

  final double? radius;
  final ImageProvider? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: backgroundImage,
      child: backgroundImage == null
          ? Container(
              width: radius! * 2,
              height: radius! * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius!)),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1.0,
                ),
              ),
              child: Icon(
                Icons.person,
                size: radius,
              ),
            )
          : null,
    );
  }
}
