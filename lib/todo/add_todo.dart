import 'package:flutter/material.dart';
//import 'package:my_auth_app/helper/db_manager.dart';
import 'package:my_auth_app/helper/db_manager_web.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  int priorityValue = 2;
  bool isComplted = false;
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD ToDo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            /// Title Textfield
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                //hintText: 'Enter title',
                labelText: 'Title',
              ),
            ),

            SizedBox(height: 30),
            // Description Textfield
            TextField(
              controller: descController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter description',
                //labelText: 'Description',
              ),
            ),

            SizedBox(height: 30),

            // Priority
            Row(
              children: [
                Text('Priority'),
                Spacer(),
                DropdownButton(
                  value: priorityValue,
                  items: [
                    DropdownMenuItem(value: 1, child: Text('High')),
                    DropdownMenuItem(value: 2, child: Text('Medium')),
                    DropdownMenuItem(value: 3, child: Text('Low')),
                  ],
                  onChanged: (prorityData) {
                    print('Priority Value: $prorityData');
                    priorityValue = prorityData!;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Is Complted
            SizedBox(height: 30),

            // Priority
            Row(
              children: [
                Text('Complted'),
                Spacer(),
                Switch(
                  value: isComplted,
                  onChanged: (newValue) {
                    isComplted = newValue;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: 50),
            OutlinedButton(
              onPressed: () async {
                //validation

                final title = titleController.text;
                final desc = descController.text;

                // Insert into databas
                final Map<String, dynamic> dataDict = {
                  'title': title,
                  'description': desc,
                  'priority': priorityValue,
                  'isDone': isComplted ? 1 : 0,
                };

                final insertRows = await DBManagerWeb.shared.insertToDo(
                  dataDict,
                );

                if (insertRows > 0) {
                  //show message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data Insert Successfully.'),
                    ),
                  );

                  // Backworkd Data passing
                  Navigator.pop(context, true);
                }

                // ToDo object
                // final obj = ToDoData(
                //   title: title,
                //   descriptoin: desc,
                //   priority: prorityValue,
                //   isDone: isComplted,
                // );

                // snacbar
              },
              child: Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
