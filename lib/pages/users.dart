
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';

class AUsersPage extends StatefulWidget {
  // final String name;
  // final String phone;
  // final String email;
  // final String dateofbirth;
  // final String accounttype;
  // final String roletype;
  // final String? id;
  const AUsersPage(
      {super.key});

  @override
  State<AUsersPage> createState() => _AUsersPageState();
}

class _AUsersPageState extends State<AUsersPage> {
  // final user = FirebaseAuth.instance.currentUser!;
  
  Future<Map<String, dynamic>> fetchUser() async {
    const storage = FlutterSecureStorage();
    String? userId = await storage.read(key: 'id');
    
    if (userId == null) {
    throw Exception('User ID is null.');
  }
    final url = Uri.parse('http://10.0.2.2/server/api/users/$userId');

    final response = await http.get(url);
    print(response.statusCode);
          print('status code');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to fetch user.');
    }
  }
  void _signOut() async {
    try {
      Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
      // print(user);
      // setState(() {});
    } catch (e) {
     print(e);
     print('error signout');
    }
  
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 191, 169, 200),
          title: Text(
            'Dashboard',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                 Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
                setState(() {});
                
                },
                child: const Icon(Icons.logout)),
            const Padding(
              padding: EdgeInsets.all(10),
            )
          ],
          centerTitle: true,
        ),
        body: Column(children: [
          FutureBuilder<Map<String, dynamic>>(
            future: fetchUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No user data available.'),
                );
              } else {
               
                final userData = snapshot.data!;
                print(userData);
                print('user data');

                return Column(
                  children: <Widget>[
                    // ... Put UI for displaying the user data here using userData ...
                                  const SizedBox(
                        height: 50,
                      ),
                      const Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromARGB(255, 191, 169, 200),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        userData['name'],
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 99, 99, 99),
                        thickness: 0.5,
                        height: 100,
                      ),
                      Wrap(
                        spacing: 10.0,
                        children: [
                          const Icon(Icons.email_rounded),
                          Text(
                            userData['email'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 99, 99, 99),
                        thickness: 0.5,
                        height: 100,
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          const Icon(Icons.person_4_rounded),
                          Text(
                            userData['user_role'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 99, 99, 99),
                        thickness: 0.5,
                        height: 100,
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          Icon(Icons.phone),
                          Text(
                          userData['phone'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 99, 99, 99),
                        thickness: 0.5,
                        height: 100,
                      ),
                  ],
                );
              }
            },
          ),
        ]));
  }
}
