import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/logic/userdataCubit/cubit/user_cubit.dart';
import 'package:ecommerce_app/widgets/dynamic_dialoge.dart';
import 'package:ecommerce_app/widgets/profilecategores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../logic/themebloc/cubit/themechange_cubit.dart';
import '../widgets/theme_switcher.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    ThemechangeCubit theme =
        BlocProvider.of<ThemechangeCubit>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
          baseColor: Colors.purple,
          highlightColor: Colors.red,
          child: const texts(
            text: 'shoppy go',
            middle: true,
          ),
        ),
        leading: Image.asset("images/profile/shopping-cart.png"),
        backgroundColor:
            theme.isdark == false ? Colors.grey[800] : Colors.white,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //to remaind the user to login
                const Visibility(
                    visible: false,
                    child: texts(
                      text: 'please login to have unlimmited access',
                      big: true,
                    )),
                //when he loged in
                const whenloged(),
                const SizedBox(
                  height: 10,
                ),

                const texts(
                  text: 'general',
                  middle: true,
                ),
                //profile catigores

                profilecatigories(
                    function: () {
                      Navigator.pushNamed(context, '/allorders');
                    },
                    lable: 'all oreders',
                    picpath: 'images/profile/shopping-bag.png'),
                profilecatigories(
                    function: () {
                      Navigator.pushNamed(context, '/wishlist');
                    },
                    lable: 'wishlist',
                    picpath: 'images/profile/heart.png'),
                profilecatigories(
                    function: () {
                      Navigator.pushNamed(context, '/latestview');
                    },
                    lable: 'latestview',
                    picpath: 'images/profile/clock.png'),
                profilecatigories(
                    function: () {},
                    lable: 'adress',
                    picpath: 'images/profile/placeholder.png'),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                const texts(
                  text: 'settings',
                  middle: true,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: theme_switcher(),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                const texts(
                  text: 'others',
                  middle: true,
                ),
                profilecatigories(
                    function: () {},
                    lable: 'privacy and policy',
                    picpath: 'images/profile/plus.png'),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 120,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.red),
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return const Ddialog(
                                image: 'images/others/warning.png',
                              );
                            },
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.login),
                            texts(
                              text: 'logout',
                              color: Colors.white,
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class whenloged extends StatefulWidget {
  const whenloged({super.key});

  @override
  State<whenloged> createState() => _whenlogedState();
}

class _whenlogedState extends State<whenloged> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<UserCubit>(context).fetchuserinfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is fetcheddata) {
          return Row(
            children: [
              CircleAvatar(
                  child: Image.network(
                      fit: BoxFit.fill, state.usermodule.userimage)),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  texts(
                    text: state.usermodule.username,
                    big: true,
                  ),
                  texts(
                    text: state.usermodule.useremail,
                  )
                ],
              )
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
