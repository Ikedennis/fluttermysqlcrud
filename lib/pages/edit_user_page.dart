import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EditUserPage extends StatefulWidget {
  final String name;
  final String phone;
  final String email;
  final String dateofbirth;
  final String accounttype;
  final String roletype;
  final String id;
  const EditUserPage(
      {this.name = '',
      this.phone = '',
      this.email = '',
      this.dateofbirth = '',
      this.accounttype = '',
      this.roletype = '',
      this.id = ''});
  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
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

  Future<void> updateUsers(id) async {
    final url = Uri.parse('http://10.0.2.2/server/api/users/${id}');
    final body = {
      "name": nameController.text,
      "email": emailController.text,
      "dob": dateofbirthController.text,
      "phone": phoneController.text,
      "account_type": accounttypeController.value,
      "user_role": roletypeController.value,
    };
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body));
setState(() {});
    print(response);
    print(body);
    print(url);
    print(response.statusCode);
    print(response.body);
    print('response');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 191, 169, 200),
        centerTitle: true,
        title: const Text(
          ("Edit Account"),
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
                    
                      updateUsers(widget.id);
            
                    setState(() {});
                    
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                                  showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("User Edited Successfully", textAlign: TextAlign.center),
              );
            });
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
                        'Edit',
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
