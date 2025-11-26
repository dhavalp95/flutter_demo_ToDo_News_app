import 'package:flutter/material.dart';
import 'package:my_auth_app/helper/api_manager.dart';
import 'package:my_auth_app/news/news_details.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS'),
      ),
      body: FutureBuilder(
        future: ApiManager.getNewsData(),
        builder: (ctx, responseData) {
          print('Build mentod call');
          // Waiting
          if (responseData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Error
          if (responseData.hasError) {
            return Center(child: Text(responseData.error.toString()));
          }

          // Sucess UI Part
          return ListView.builder(
            itemCount: responseData.data!.length,
            itemBuilder: (ctx, index) {
              final data = responseData.data![index];
              final mediaList = data['multimedia'] as List;
              final mediaUrl = mediaList.first as Map<String, dynamic>;
              final imageUrl = mediaUrl['url'] as String;
              return Card(
                margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
                child: ListTile(
                  onTap: () {
                    // Open details sacree

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => NewsDetailsScreen(
                          title: data['title'],
                          description: data['abstract'],
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  },

                  leading: Hero(
                    tag: imageUrl,
                    child: Image.network(
                      imageUrl,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Hero(
                    tag: data['title'],
                    child: Text(data['title']),
                  ),
                  subtitle: Text(data['abstract']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



/*
ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
            child: ListTile(
              title: Text('Title'),
              subtitle: Text('Description'),
            ),
          );
        },
      )
*/