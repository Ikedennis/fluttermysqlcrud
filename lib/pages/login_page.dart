import 'dart:convert';
import 'package:flutter_application_1/auth/main_page.dart';
import 'package:flutter_application_1/pages/users.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/landing_page.dart';
import 'package:flutter_application_1/pages/admin_users_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  // final VoidCallback showRegisterPage;
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class Login {
  final String email;

  final String password;

  const Login({
    this.email = '',
    this.password = '',
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      email: json['email'],
      password: json['password'],
    );
  }
}
class User {
  final String? email;
  final String? name;
  final String? phone;
  final String? roletype;
  final String? accounttype;
  final String? dateofbirth;
  final int? id;

  

  const User({
    this.email = '',
    this.name = '',
    this.phone = '',
    this.roletype = '',
    this.accounttype = '',
    this.dateofbirth = '',
    this.id = 0
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['full_name'],
      phone: json['phone'],
      email: json['email'],
      roletype: json['user_role'],
      accounttype: json['account_type'],
      dateofbirth: json['dob'],
      id: json['id']
    );
  }
}



class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String myEmail = '';
  String myUsername = '';
  String myPhone = '';
  String userRole = 'User';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future<User> createLogin(
  String email,
  String password,
) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2/server/api/users/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'form_type': 'login'
    }),
  );
  print(response.statusCode);
  print(response.body);
  print('response');
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    Map<String, dynamic> jsonMap= jsonDecode(response.body);
      User user = User.fromJson(jsonMap);
      return user;
    // return User.fromJson(jsonDecode(response.body));
    
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create user.');
  }
}

  Future signIn() async {
    //loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ),
        );
      },
    );
    try {
      final LoginDetails = await  createLogin(
            emailController.text,
            passwordController.text,
      );
      // User login = User.fromJson(LoginDetails as Map<String, dynamic>);
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'id', value: LoginDetails.id.toString());
      await storage.write(key: 'user_role', value: LoginDetails.roletype);

      print(LoginDetails.roletype);
      print('login role');
      
      
      // pop the loading circle
      Navigator.of(context).pop();
      print(LoginDetails.name);
      print('Name');
      redirectToNext(LandingPage());
      // if(LoginDetails.roletype == 'Admin'){
      //   redirectToNext(HomePage());
      // } else if(LoginDetails.roletype == 'User'){
      //   redirectToNext(AUsersPage());
      // }
   
      // return LoginDetails;
    } catch (error) {
      print(error);
    }
  }
void redirectToNext(Widget route){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> route));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 238, 240),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "QUARTZ",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: 2),
                ),
                const SizedBox(height: 60),
                Image.asset(
                  "assets/images/access.png",
                  height: 250,
                  width: 250,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 179, 154, 222)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Email',
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 179, 154, 222)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Password',
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ForgotPasswordPage();
                        }));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                GestureDetector(
                  onTap: (){
                    signIn();
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //                   builder: (context) => MainPage(data : userData)));
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 191, 169, 200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 30),
                //  Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Don't have an account?"),
                //     GestureDetector(
                //       onTap: widget.showRegisterPage,
                //       child: const Text(
                //         " Signup here",
                //         style: TextStyle(
                //             color: Colors.deepPurple, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
