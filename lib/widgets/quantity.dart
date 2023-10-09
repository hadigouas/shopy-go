import 'package:ecommerce_app/consts/texts.dart';
import 'package:flutter/material.dart';

class quantity extends StatelessWidget {
  const quantity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              width: 100,
              height: 3,
              decoration: const BoxDecoration(color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 25,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: texts(text: '${index + 1}')),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
