// ignore_for_file: no_logic_in_create_state

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/auth/image_picker.dart';
import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/routing_screen.dart';
import 'package:ecommerce_app/widgets/loading_index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class sign extends StatefulWidget {
  const sign({super.key});

  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  XFile? _pickedimage;
  final ImagePicker picker = ImagePicker();
  late TextEditingController _emailcontroller;
  late TextEditingController _passwordcontroller;
  late TextEditingController _namecontroller;
  @override
  void initState() {
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    _namecontroller = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  bool _abscure = false;

  _changescure() {
    _abscure = !_abscure;
  }

  String? imageurl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _validate() async {
    if (_formKey.currentState!.validate()) {
      if (_pickedimage != null) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailcontroller.text.trim(),
              password: _passwordcontroller.text.trim());
          var ref = await FirebaseStorage.instance
              .ref()
              .child('userimage')
              .child('${_emailcontroller.text.trim()}.jpg');
          await ref.putFile(File(_pickedimage!.path));
          imageurl = await ref.getDownloadURL();
          var user = FirebaseAuth.instance.currentUser;
          var userid = user!.uid;
          await FirebaseFirestore.instance
              .collection('userinfo')
              .doc(userid)
              .set({
            'username': _namecontroller.text,
            'email': _emailcontroller.text,
            'password': _passwordcontroller.text,
            'image': imageurl,
            'userwish': [],
            'usercard': []
          });

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RoutingScreen(),
          ));
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: texts(text: '$e')));
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red[600],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/others/warning.png',
                  width: 70,
                  height: 70,
                ),
                SizedBox(
                  height: 10,
                ),
                texts(
                  text: 'add an image',
                  middle: true,
                ),
              ],
            ),
          ),
        );
      }
      // Form is valid, you can process the data here.
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 90, left: 8, right: 8),
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
                    const texts(
                      text: 'welcom back',
                      big: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: size.width * 0.3,
                          height: size.width * 0.3,
                          child: Imagepick(
                            picked: _pickedimage,
                            function: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    backgroundColor: Colors.cyan,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        texts(
                                          text: 'Choose option',
                                          big: true,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              _pickedimage =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                            child: texts(text: 'camera')),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              _pickedimage =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                            child: texts(text: 'upload')),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              _pickedimage = null;
                                              Navigator.pop(context);
                                            },
                                            child: texts(
                                              text: 'delete',
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'fill this field';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: 'your full name',
                          filled: true,
                          fillColor: Colors.grey,
                          prefixIcon: Icon(
                            Icons.person_2_outlined,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'fill this field';
                        }
                        return null;
                      },
                      obscureText: _abscure,
                      controller: _passwordcontroller,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: 'enter your password',
                          filled: true,
                          fillColor: Colors.grey,
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _changescure();
                              });
                            },
                            icon: const Icon(Icons.remove_red_eye_outlined),
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return 'fill this field';
                        }
                        return null;
                      },
                      obscureText: _abscure,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: 'confirme your password',
                          filled: true,
                          fillColor: Colors.grey,
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _changescure();
                              });
                            },
                            icon: const Icon(Icons.remove_red_eye_outlined),
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: _validate,
                          child: const texts(text: 'sign up')),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
