import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:draggable_fab/draggable_fab.dart';


import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_user_page.dart';
import 'package:flutter_application_1/pages/send_or_update_data_screen.dart';
import 'package:flutter_application_1/pages/admin_users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController controller;
  bool isFabVisible = true;
  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> fetchUsers() async {
      final url = Uri.parse('http://10.0.2.2/server/api/users/');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final String usersString = jsonResponse['users'];
        final List<dynamic> usersJson = jsonDecode(usersString);
        final List<Map<String, dynamic>> users =
            usersJson.cast<Map<String, dynamic>>();
        return users;
      } else {
        throw Exception('Failed to fetch users.');
      }
    }
    
    Future<String> deleteUsers(id) async {
      const String uri = 'http://10.0.2.2/server/api/users/';
      final url = Uri.parse(uri + id.toString());

      final response = await http.delete(url);
      if (response.statusCode == 200) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("User deleted Successfully", textAlign: TextAlign.center),
              );
            });
        const String message = 'success';
        return message;
      } else {
        throw Exception('Failed to delete user.');
      }
    }

    return Scaffold(
      floatingActionButton: DraggableFab(
        securityBottom: 10.0,
        
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SendOrUpdateData();
            }));
          },
          backgroundColor: const Color.fromARGB(255, 191, 169, 200),
          icon: const Icon(Icons.add),
          label: const Text("Create New Account"),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "All Customers",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: FutureBuilder(
            future: fetchUsers(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<Map<String, dynamic>> users = snapshot.data!;
                
                return snapshot.hasData ? NotificationListener<UserScrollNotification>(
                  // onNotification: (notification) {
                  //       if (notification.direction == ScrollDirection.forward){
                  //         if (!isFabVisible) setState(() => isFabVisible = true);
                  //       } else if (notification.direction == ScrollDirection.reverse){
                  //         if (isFabVisible) setState(() => isFabVisible = false);
                  //       }
                  //       return true;
                  //     },
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            child: ListTile(
                              leading: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return UsersPage(id: users[index]['id'].toString());
                          }));
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Color.fromARGB(255, 191, 169, 200),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(
                                users[index]['name'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                users[index]['email'],
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              trailing: Wrap(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => EditUserPage(
                                                    name: users[index]['name'],
                                                    phone: users[index]['phone'],
                                                    email: users[index]['email'],
                                                    dateofbirth: users[index]
                                                        ['dob'],
                                                    accounttype: users[index]
                                                        ['account_type'],
                                                    roletype: users[index]
                                                        ['user_role'],
                                                    id: users[index]['id']
                                                        .toString(),
                                                  )));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.grey[600],
                                      size: 21,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      deleteUsers(users[index]['id']);
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.grey[600],
                                      size: 21,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  
                )
                : Center(
                      );
              }
            },
          )),
        ],
      ),
    );
  }
}
