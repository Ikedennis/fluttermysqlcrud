import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
final accounttypeController = DropdownEditingController<String>();

  MyDropdown({super.key});

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

                          controller: accounttypeController,
                          options: const [
                            "Personal Account",
                            "Government Account",
                            "Business Account",
                            "Basic Account",
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
                              hintText: 'Account Type',
                              labelText: 'Account Type',
                              labelStyle:
                                  const TextStyle(color: Colors.deepPurple),
                              fillColor: Colors.grey[200],
                              filled: true),
                          dropdownHeight: 180,
                        ),
                      ),
                    ),
                    // ),
                  ),
                );
  }
}