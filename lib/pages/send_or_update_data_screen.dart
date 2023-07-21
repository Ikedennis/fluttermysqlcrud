import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class SendOrUpdateData extends StatefulWidget {
  final String name;
  final String phone;
  final String email;
  final String dateofbirth;
  final String accounttype;
  final String roletype;
  final String id;
  const SendOrUpdateData(
      {this.name = '',
      this.phone = '',
      this.email = '',
      this.dateofbirth = '',
      this.accounttype = '',
      this.roletype = '',
      this.id = ''});
  @override
  State<SendOrUpdateData> createState() => _SendOrUpdateDataState();
}

class Register {
  final String? name;
  final String? phone;
  final String? email;
  final String? dateofbirth;
  final String? accounttype;
  final String? roletype;
  final String? password;
  final String? confirmpassword;

  const Register({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.dateofbirth = '',
    this.accounttype = '',
    this.roletype = '',
    this.password = '',
    this.confirmpassword = '',
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      name: json['full_name'],
      phone: json['phone'],
      email: json['email'],
      roletype: json['user_role'],
      accounttype: json['account_type'],
      password: json['password'],
      confirmpassword: json['confirm_password'],
      dateofbirth: json['dob'],
    );
  }
}

Future<Register> createRegister(
    String name,
    String phone,
    String roletype,
    String accounttype,
    String email,
    String password,
    String confirmpassword,
    String dateofbirth) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2/server/api/users/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'full_name': name,
      'email': email,
      'phone': phone,
      'account_type': accounttype,
      'user_role': roletype,
      'dob': dateofbirth,
      'password': password,
      'confirm_password': confirmpassword,
      'form_type': 'register'
    }),
  );
  // print(response.statusCode);
  // print(response.body);
  // // print(name);
  // // print(phone);
  // // print(email);
  // // print(dateofbirth);
  // // print(accounttype);
  // // print(roletype);
  // // print(password);
  // // print(confirmpassword);
  // print('response');
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Register.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create user.');
  }
}

class _SendOrUpdateDataState extends State<SendOrUpdateData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController dateofbirthController = TextEditingController();
  DropdownEditingController<String> accounttypeController =
      DropdownEditingController();
  DropdownEditingController<String> roletypeController =
      DropdownEditingController();
  bool showProgressIndicator = false;

  @override
  void initState() {
    nameController.text = widget.name;
    phoneController.text = widget.phone;
    emailController.text = widget.email;
    dateofbirthController.text = widget.dateofbirth;
    accounttypeController.value = widget.accounttype.toString().trim();
    roletypeController.value = widget.roletype.toString().trim();

    super.initState();
  }

  final format = DateFormat('yyyy-MM-dd');

  // @override
  // void initState() {
  //   nameController.text = widget.name;
  //   emailController.text = widget.email;
  //   accounttypeController.value = widget.accountType;
  //   dateofbirthController.text = widget.dateofBirth;
  //   phoneController.text = widget.phone;
  //   roletypeController.value = widget.roleType;
  //   super.initState();
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    dateofbirthController.dispose();
    phoneController.dispose();
    nameController.dispose();
    accounttypeController.dispose();
    roletypeController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        await createRegister(
            nameController.text,
            phoneController.text,
            roletypeController.value.toString(),
            accounttypeController.value.toString(),
            emailController.text,
            passwordController.text,
            confirmpasswordController.text,
            dateofbirthController.text);
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("User Created Successfully", textAlign: TextAlign.center),
              );
            });
        setState(() {});
      } catch (e) {
        print(e);
        print('error message');

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Something went wrong'),
              );
            });
      }
    }
  }

  // Future addUserDetails(String uid, String accounttype, String name, String email,
  //     String dateofBirth, String phone, String roletype) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'id' : uid,
  //     'account_type': accounttype,
  //     'full_name': name,
  //     'email': email,
  //     'date_of_birth': dateofBirth,
  //     'phone_number': phone,
  //     'user_role': roletype,
  //   });
  // }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 191, 169, 200),
        centerTitle: true,
        title: const Text(
          ("Create Account"),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                // child: SizedBox(
                //   width: 360,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Center(
                    child: TextDropdownFormField(
                      controller: accounttypeController,
                      options: const [
                        "Personal Account",
                        "Government Account",
                        "Business Account",
                        "Basic Account",
                      ],
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
                          border: const OutlineInputBorder(),
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 145, 136, 136),
                          ),
                          hintText: 'Account Type',
                          labelText: 'Account Type',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          fillColor: Colors.grey[200],
                          filled: true),
                      dropdownHeight: 180,
                    ),
                  ),
                ),
                // ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                cursorColor: Colors.deepPurple,
                controller: nameController,
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
                  hintText: 'Full Name',
                  labelText: 'Full Name',
                  labelStyle: const TextStyle(color: Colors.deepPurple),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                cursorColor: Colors.deepPurple,
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
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DateTimeField(
                      controller: dateofbirthController,
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
                          hintText: 'Date of birth',
                          labelText: 'Date of birth',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          fillColor: Colors.grey[200],
                          filled: true),
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = showDatePicker(
                          context: context,
                          initialDate: currentValue ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Color.fromARGB(255, 179, 154,
                                      222), // header background color
                                  onPrimary:
                                      Colors.deepPurple, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Colors.deepPurple, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        return date;
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // child: SizedBox(
                      //   width: 360,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Center(
                          child: TextDropdownFormField(
                            controller: roletypeController,
                            options: const [
                              "Admin",
                              "User",
                            ],
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 179, 154, 222)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: const OutlineInputBorder(),
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color.fromARGB(255, 145, 136, 136),
                                ),
                                hintText: 'Role',
                                labelText: 'Role Type',
                                labelStyle:
                                    const TextStyle(color: Colors.deepPurple),
                                fillColor: Colors.grey[200],
                                filled: true),
                            dropdownHeight: 100,
                          ),
                        ),
                      ),
                      // ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                cursorColor: Colors.deepPurple,
                controller: phoneController,
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
                    hintText: 'Phone Number',
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                cursorColor: Colors.deepPurple,
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                cursorColor: Colors.deepPurple,
                obscureText: true,
                controller: confirmpasswordController,
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
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MaterialButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fill in all fields')));
                  } else {
                     signUp();
                    setState(() {});
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                minWidth: double.infinity,
                height: 50,
                color: const Color.fromARGB(255, 191, 169, 200),
                child: showProgressIndicator
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Create',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
