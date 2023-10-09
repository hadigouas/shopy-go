import 'package:ecommerce_app/consts/texts.dart';
import 'package:flutter/material.dart';

class Ddialog extends StatelessWidget {
  const Ddialog({super.key, required this.image, this.errore = false});
  final String image;
  final bool errore;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          image,
          width: 80,
          height: 80,
        ),
        const SizedBox(
          height: 10,
        ),
        const texts(
          text: 'confirme log out',
          middle: true,
        ),
        const SizedBox(
          height: 10,
        ),
        errore
            ? TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const texts(
                  text: 'ok',
                  color: Colors.red,
                ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const texts(
                        text: 'cancel',
                        color: Colors.blue,
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const texts(
                        text: 'ok',
                        color: Colors.red,
                      ))
                ],
              )
      ]),
    );
  }
}
