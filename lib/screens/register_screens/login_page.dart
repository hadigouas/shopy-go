import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/logic/product_cubit/cubit/product_cubit.dart';
import 'package:ecommerce_app/routing_screen.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shimmer/main.dart';
import 'package:shimmer/shimmer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailcontroller;
  late TextEditingController _passwordcontroller;
  @override
  void initState() {
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _validate() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, you can process the data here.
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailcontroller.text.trim(),
            password: _passwordcontroller.text.trim());
        BlocProvider.of<ProductCubit>(context).fetchProduct('1245');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RoutingScreen(),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Push to the new page (Myhomepage) after successful sign-in
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Myhomepage(),
      ));
    } catch (error) {
      // Handle any errors that occur during the authentication process
      print("Error during Google Sign-In: $error");
      // You can display an error message or handle the error in any way you prefer.
    }
  }

  bool _abscure = false;

  _changescure() {
    _abscure = !_abscure;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 8, right: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButton(),
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
                      height: 5,
                    ),
                    const texts(
                        text: 'lets got you loged in so you can explore'),
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
                    Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/forget');
                          },
                          child: const texts(
                            text: 'forget the password',
                            color: Colors.purple,
                          ),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey),
                            onPressed: _validate,
                            child: const texts(
                              text: 'sign in',
                              middle: true,
                            ))),
                    const SizedBox(
                      height: 5,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: texts(
                        text: 'or conect using:',
                        big: true,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey),
                                onPressed: () {
                                  signInWithGoogle();
                                },
                                child: const texts(
                                  text: ' google',
                                  middle: true,
                                ))),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/route');
                                },
                                child: const texts(
                                  text: 'Guest',
                                  middle: true,
                                ))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const texts(
                          text: 'don\'t have an account ?',
                          color: Colors.grey,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const texts(
                              text: 'sign up',
                              color: Colors.purple,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
