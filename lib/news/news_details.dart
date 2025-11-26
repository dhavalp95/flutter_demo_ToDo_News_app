import 'package:flutter/material.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
            tag: imageUrl,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              //color: Colors.green,
              height: 400,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 30),
          Hero(
            tag: title,
            child: Text(
              title,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
          ),

          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
