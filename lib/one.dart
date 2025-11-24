import 'package:flutter/material.dart';

class OneScreen extends StatelessWidget {
  const OneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: OutlinedButton(
          onPressed: () {
            Navigator.pop(context, 'Backworkd data passing from B to A');
          },
          child: Text('BACK'),
        ),
      ),
    );
  }
}
