import 'package:ecommerce_app/consts/texts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({super.key});

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  late TextEditingController _emailcontroller;
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailcontroller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 8, right: 8),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Shimmer.fromColors(
                          baseColor: Colors.purple,
                          highlightColor: Colors.red,
                          child: const texts(
                            text: 'shoppy go',
                            big: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Image.asset(
                          'images/others/forgot_password.jpg',
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.width * 0.6,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const texts(
                        text: 'forget password',
                        big: true,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const texts(
                          text:
                              'Please enter your email so you can rest the password'),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'fill this field';
                          } else if (value.length < 5) {
                            return 'it\'s to short';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'enter your email',
                            filled: true,
                            fillColor: Colors.grey,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.send),
                                texts(
                                  text: 'send request',
                                  color: Colors.white,
                                  middle: true,
                                ),
                              ],
                            )),
                      )
                    ]),
              ),
            )));
  }
}
