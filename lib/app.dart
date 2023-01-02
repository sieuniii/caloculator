
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'startPage.dart';
import 'package:provider/provider.dart';
import 'package:caloculator/provider/naviProvider.dart';
import 'package:caloculator/provider/googleSignInProvider.dart';
import 'package:caloculator/homePage.dart';
import 'profilePage.dart';
import 'package:caloculator/foodPage.dart';
import 'package:caloculator/provider/foodProvider.dart';
import 'package:caloculator/provider/userProvider.dart';
import 'package:caloculator/provider/eatProvider.dart';
import 'editPage.dart';
import 'searchPage.dart';
import 'foodPage.dart';
import 'newFoodPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<FoodProvider>(create: (_) => FoodProvider()),
        ChangeNotifierProvider<EatProvider>(create: (_) => EatProvider())
      ],
      child: MaterialApp(
        title: 'Caloculator',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => StartPage(),
          '/home': (BuildContext context) => HomePage(),
          '/profile': (BuildContext context) => ProfilePage(),
          '/edit': (BuildContext context) => EditPage(),
          '/search':(BuildContext context) => SearchPage(),
          '/food': (BuildContext context) => FoodPage(),
          '/newFood': (BuildContext context) => NewFoodPage(),


        },
      ),
    );
  }
}
