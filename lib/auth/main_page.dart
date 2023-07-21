
import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/landing_page.dart';
import '../pages/login_page.dart';


class MainPage extends StatelessWidget {
  final data;
  const MainPage({super.key, this.data = ""});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: LoginPage()
    );

  
  
  }
  }