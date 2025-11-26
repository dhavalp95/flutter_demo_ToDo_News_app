import 'package:flutter/material.dart';
import 'package:my_auth_app/todo/add_todo.dart';
import 'package:my_auth_app/helper/db_manager.dart';
import 'package:my_auth_app/login.dart';
import 'package:my_auth_app/models/todo_model.dart';
import 'package:my_auth_app/news/news.dart';
import 'package:my_auth_app/one.dart';
import 'package:my_auth_app/two.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMenu extends StatefulWidget {
  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  List<ToDoData> todoList = [];

  @override
  initState() {
    super.initState();
    fetchToDoList();
  }

  fetchToDoList() async {
    todoList = await DBManager.shared.fetchToDos();
    setState(() {});
  }

  // Create single item of list View
  Widget createView(BuildContext context, int index) {
    final data = todoList[index];
    var bgColor = Colors.teal.shade100;
    if (data.isDone) {
      bgColor = Colors.grey.shade300;
    } else if (data.priority == 1) {
      bgColor = Colors.red.shade200;
    } else if (data.priority == 2) {
      bgColor = Colors.blue.shade200;
    }

    return Card(
      color: bgColor,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListTile(
        onLongPress: () async {
          // update todo
          Map<String, dynamic> dataDic = {'isDone': data.isDone ? 0 : 1};

          await DBManager.shared.updateToDo(
            id: data.id,
            map: dataDic,
          );

          //fetch updated data
          fetchToDoList();
        },
        leading: data.isDone ? Icon(Icons.done_outline) : null,
        title: Text(data.title),
        subtitle: Text(data.descriptoin),
        trailing: InkWell(
          onTap: () async {
            await DBManager.shared.deleteToDo(data.id);
            fetchToDoList();
          },
          child: Icon(Icons.delete),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //floating button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Open add todo screen

          await Navigator.of(
            context,
          ).push(
            MaterialPageRoute(
              builder: (ctx) => AddTodoScreen(),
            ),
          );

          fetchToDoList();

          // Add data into list
          // todoList.add(result);

          // Refresh screen
          setState(() {});
        },
        child: Icon(Icons.add),
      ),

      // App Bar
      appBar: AppBar(
        title: Text('HOME'),
        actions: [
          //OutlinedButton(onPressed: () {}, child: Text('data')),
          IconButton(
            onPressed: () async {
              // set login as flase
              final obj = await SharedPreferences.getInstance();
              obj.setBool('is_login', false);
              //obj.remove('is_loging');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (ctx) => LoginScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      // Side Menu Drawer
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.horizontal(
            right: Radius.circular(50),
          ),
        ),

        backgroundColor: const Color.fromARGB(255, 237, 215, 241),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // User Account Details Header View
            UserAccountsDrawerHeader(
              accountName: Text('John Cartyer'),
              accountEmail: Text('john.carter@yahoo.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.account_circle_rounded),
              ),
              otherAccountsPictures: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 213, 238, 203),
                  child: Icon(Icons.account_circle_rounded),
                ),
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 165, 213, 214),
                  child: Icon(Icons.account_circle_rounded),
                ),
              ],
            ),

            // Simple Drawer Header View
            /*
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigoAccent),
              child: Text('User Details'),
            ),*/
            ListTile(
              leading: Icon(Icons.newspaper),
              title: Text('NEWS'),
              onTap: () {
                //Close menu before open new screen
                Navigator.pop(context);

                // Open ONE screeen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => NewsScreen(),
                  ),
                );
              },
            ),

            // Home Optoin
            ListTile(
              leading: Icon(Icons.home),
              title: Text('ONE'),
              onTap: () {
                //Close menu before open new screen
                Navigator.pop(context);

                // Open ONE screeen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => OneScreen(),
                  ),
                );
              },
            ),

            // Setting Option
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('TWO'),
              onTap: () {
                //Close menu before open new screen
                //Navigator.pop(context);

                // Open ONE screeen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => TwoScreen(),
                  ),
                );
              },
            ),

            // Exit option
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text('Exit'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // Body portion
      body: (todoList.isEmpty)
          ? Center(child: Image.asset('images/noData.jpeg'))
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: createView,
            ),
    );
  }
}
