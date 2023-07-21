import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailController.text.trim()
      );

        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              content: Text("Password reset link sent! Check your email"),
            );
          });

      } on FirebaseAuthException catch (e) {
        print(e);
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }
          );
      }
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 191, 169, 200),
        elevation: 0,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 80),
              Image.asset(
                "assets/images/passwordforgot.png",
                height: 250,
                width: 250,
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("Enter Your Email and we will send you a password reset link", 
            style: TextStyle(fontSize: 18), 
            textAlign: TextAlign.center,   
            ),
          ),
            const SizedBox(height: 20),
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(
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
                  const SizedBox(height: 20),
                MaterialButton(onPressed: passwordReset,
                color:const Color.fromARGB(255, 191, 169, 200),
                child: const Text("Reset Password", style: TextStyle(color: Colors.white),),
                )
        ],
      ),
    );
  }
}