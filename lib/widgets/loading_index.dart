import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.isloading, required this.child});
  final bool isloading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return isloading == true
        ? Stack(
            children: [
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              CircularProgressIndicator()
            ],
          )
        : child;
  }
}
