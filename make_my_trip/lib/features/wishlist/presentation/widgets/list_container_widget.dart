import 'package:flutter/material.dart';

class ListContainer extends StatelessWidget {
   ListContainer({Key? key,required this.width,required this.hight}) : super(key: key);
  double width;
  double hight;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey,
          borderRadius:
          BorderRadius.all(Radius.circular(5))),
      width: width,
      height: hight,
    );
  }
}
