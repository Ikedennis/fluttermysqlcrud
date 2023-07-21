import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';

class MyDroprole extends StatelessWidget {
final roletypeController = DropdownEditingController<String>();

  MyDroprole({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                                    color: Color.fromARGB(255, 179, 154, 222)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: const OutlineInputBorder(),

                              suffixIcon: const Icon(Icons.arrow_drop_down,color: Color.fromARGB(255, 145, 136, 136),),
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
                );
  }
}