import 'package:ecommerce_app/consts/themes.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/logic/card_cubit/cubit/card_cubit.dart';
import 'package:ecommerce_app/logic/product_cubit/cubit/product_cubit.dart';
import 'package:ecommerce_app/logic/themebloc/cubit/themechange_cubit.dart';
import 'package:ecommerce_app/logic/userdataCubit/cubit/user_cubit.dart';
import 'package:ecommerce_app/routing_screen.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/inner_screens/all_orders_screen.dart';
import 'package:ecommerce_app/screens/inner_screens/discription.dart';
import 'package:ecommerce_app/screens/inner_screens/latest_view.dart';
import 'package:ecommerce_app/screens/inner_screens/wishlist.dart';
import 'package:ecommerce_app/screens/register_screens/login_page.dart';
import 'package:ecommerce_app/screens/register_screens/signup_page.dart';
import 'package:ecommerce_app/screens/search_screen.dart';
import 'package:ecommerce_app/utils/sharedpref.dart';
import 'package:ecommerce_app/widgets/forget_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheData.initializeShared();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ThemechangeCubit(),
      ),
      BlocProvider(
        create: (context) => ProductCubit(),
        child: Container(),
      ),
      BlocProvider(
        create: (context) => CardCubit(),
        child: Container(),
      ),
      BlocProvider(
        create: (context) => UserCubit(),
        child: Container(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemechangeCubit theme =
        BlocProvider.of<ThemechangeCubit>(context, listen: true);

    // Call the init() method to initialize isdark value from SharedPreferences
    theme.init();

    return MaterialApp(
      routes: {
        '/discription': (context) => const discription(),
        '/home': (context) => const Myhomepage(),
        '/wishlist': (context) => const wishlist(),
        '/latestview': (context) => const latestview(),
        '/login': (context) => const Login(),
        '/signup': (context) => const sign(),
        '/route': (context) => RoutingScreen(),
        '/allorders': (context) => allorders(),
        '/forget': (context) => forgetpassword(),
        '/search': (context) => Search()
      },
      title: 'Flutter Demo',
      theme: theme.isdark ? Themes.lighttheme : Themes.darktheme,
      home: const Login(),
    );
  }
}
