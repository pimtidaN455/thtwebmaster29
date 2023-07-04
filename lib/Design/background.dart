import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/3b.png",
              width: size.width
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/4b.png",
              width: size.width
            ),
          ),
         /* Positioned(
            top: 50,
            right: 10,
            child: Image.asset(
              "assets/images/THTWEB2.png",
              width: size.width * 0.3
            ),
          ),*/
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/2b.png",
              width: size.width
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/1b.png",
              width: size.width
            ),
          ),
          child
        ],
      ),
    );
  }
}