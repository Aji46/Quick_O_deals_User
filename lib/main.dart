// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/Provider/profile_image_check.dart';
import 'package:quick_o_deals/Controller/auth/provider/email_auth.dart';
import 'package:quick_o_deals/Controller/auth/provider/google_auth.dart';
import 'package:quick_o_deals/Controller/auth/provider/loding_provider.dart';
import 'package:quick_o_deals/Controller/auth/provider/login_.dart';
import 'package:quick_o_deals/Controller/auth/provider/register.dart';
import 'package:quick_o_deals/Controller/auth/provider/user_provider.dart';
import 'package:quick_o_deals/Model/auth/auth.dart';
import 'package:quick_o_deals/View/widget/bottom_nav_bar/bottom%20_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('isLoggedIn');
  runApp( ChangeNotifierProvider(
      create: (context) => logProvider(),
      child: MyApp(isLoggedIn: isLoggedIn ?? false)
  ),
      );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();
  final bool isLoggedIn;

  MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return 
       MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(authRepository: AuthRepository()),
        ),
           ChangeNotifierProvider(create: (_) => TermsProvider()),

 ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => LoadingProvider()), 
  ChangeNotifierProvider(create: (_) => logProvider()),
  ChangeNotifierProvider(create: (_) => ImageEditProvider()),
  
    
//  ChangeNotifierProvider(
//   create: (Bcontext) => ProfileEditProvider(context),
// ),

      ], 
      child: MaterialApp(
        title: 'Quick O Deals',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
       );
  }
}