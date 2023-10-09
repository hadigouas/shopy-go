import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Imagepick extends StatelessWidget {
  Imagepick({super.key, this.function, this.picked});
  final XFile? picked;
  final function;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        picked == null
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black)),
              )
            : Image.file(File(picked!.path)),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue,
            child: IconButton(
                onPressed: () {
                  function();
                },
                icon: FaIcon(FontAwesomeIcons.image)),
          ),
        )
      ],
    );
  }
}
