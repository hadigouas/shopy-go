import 'package:ecommerce_app/consts/texts.dart';
import 'package:flutter/material.dart';

class Catigories extends StatelessWidget {
  Catigories(
      {super.key,
      required this.color,
      required this.image,
      required this.title,
      required this.Function});
  final Function;
  Color color;
  String image;
  String title;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Function();
            },
            child: Container(
              width: size.width * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: color),
              child: ClipRRect(
                  child: Image.asset(
                image,
                height: 50,
                width: 50,
              )),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          texts(
            text: title,
            middle: true,
          ),
        ],
      ),
    );
  }
}
