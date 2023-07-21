import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {

final dateofbirthController = TextEditingController();
final format = DateFormat('yyyy-MM-dd');

  DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child:
                          DateTimeField(
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
                      
                    );

  }
}