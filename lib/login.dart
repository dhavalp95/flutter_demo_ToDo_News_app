import 'package:flutter/material.dart';
import 'package:my_auth_app/todo/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Text - Styling property
        title: Text(
          'LOGIN',
          style: TextStyle(
            color: const Color.fromARGB(255, 14, 67, 123),
            fontSize: 60,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700,
            //decoration: TextDecoration.lineThrough,
            letterSpacing: 8,
            //wordSpacing: 20,
            shadows: [
              Shadow(
                color: const Color.fromARGB(103, 68, 118, 255),
                blurRadius: 10,
                offset: Offset(6, 8),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(
          top: 50,
          left: 26,
          right: 26,
          bottom: 50,
        ),
        child: Column(
          children: [
            //SizedBox(height: 50),

            /// Container - With Styling
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                //color: Colors.blueAccent,
                //shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/flutterLogo.png'),
                ),
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.pink.shade100,
                    Colors.blue.shade200,
                    Colors.green.shade100,
                  ],
                ),
                // border: Border.all(
                //   color: Colors.red,
                //   width: 8,
                // ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.blueAccent,
                //     blurRadius: 10,
                //     offset: Offset(-10, 50),
                //   ),
                // ],
              ),
            ),

            SizedBox(height: 30),

            /// Username Textfield - With Styling
            TextField(
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 22,
              ),
              decoration: InputDecoration(
                hintText: 'Enter name',
                labelText: 'Name',
                prefixIcon: Icon(Icons.account_circle),
                filled: true,
                fillColor: Colors.deepPurple.shade100,
                //default enable border
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade700,
                    width: 2,
                  ),
                ),
                //Focused border
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 15, 95, 105),
                    width: 4,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            ///  Password Textfield
            TextField(
              obscureText: true,
              obscuringCharacter: '*',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 22,
              ),
              decoration: InputDecoration(
                hintText: 'Enter password',
                labelText: 'Password',
                prefixIcon: Icon(Icons.account_circle),
                filled: true,
                fillColor: Colors.deepPurple.shade100,
                //default enable border
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade700,
                    width: 2,
                  ),
                ),
                //Focused border
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 15, 95, 105),
                    width: 4,
                  ),
                ),
              ),
            ),

            SizedBox(height: 80),

            /// Login Button
            SizedBox(
              width: 300,
              height: 60,

              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 53, 82, 153),
                  foregroundColor: Colors.white,
                  //padding: EdgeInsets.only(left: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                onPressed: () async {
                  // validation

                  // Set isLogin true
                  final prefObj = await SharedPreferences.getInstance();
                  await prefObj.setBool('is_login', true);

                  // Open Main/Home screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyMenu()),
                  );
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            //Spacer(),
            SizedBox(height: 16),

            // OR Text
            Text(
              'OR',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
            ),

            SizedBox(height: 16),

            /// Signup Button
            SizedBox(
              width: 300,
              height: 60,

              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 15, 92, 83),
                  foregroundColor: Colors.white,
                  //padding: EdgeInsets.only(left: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'SIGNUP',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            //SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
