import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/admin_users_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

import 'users.dart';
import 'home_page.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  
  String myEmail = '';
  String myUsername = '';
  String myPhone = '';
  String userRole = 'User';
  @override
  void initState() {
    super.initState();
    _obj();
  }
  void _obj() async {
const storage = FlutterSecureStorage();
    // String? userId = await storage.read(key: 'id');
    String? user_role = await storage.read(key: 'user_role');
    Future.delayed(const Duration(milliseconds: 1500), () {
     if (user_role == 'User') {
      redirectToNext(AUsersPage());
     }
     else{
      redirectToNext(const HomePage());
     }
    });
  }
  void redirectToNext(Widget route){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> route));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "QUARTZ",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    letterSpacing: 2),
              ),
              const SizedBox(height: 80),
              const Text(
                "One app,",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    letterSpacing: 0),
              ),
              const Text(
                "all things money",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    letterSpacing: 0),
              ),
              const SizedBox(height: 10),
              Image.asset(
                "assets/images/access.png",
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
