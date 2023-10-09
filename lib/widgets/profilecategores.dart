import 'package:flutter/material.dart';

import '../consts/texts.dart';

class profilecatigories extends StatelessWidget {
  const profilecatigories(
      {super.key,
      required this.lable,
      required this.picpath,
      required this.function});
  final String picpath;
  final String lable;
  final function;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            function();
          },
          leading: Image.asset(
            picpath,
            width: 30,
          ),
          title: texts(
            text: lable,
            middle: true,
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
