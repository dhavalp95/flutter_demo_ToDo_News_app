import 'package:flutter/material.dart';
import 'package:my_auth_app/helper/api_manager.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  fetchNews() async {
    final result = await ApiManager.getNewsData();
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS'),
      ),
      body: FutureBuilder(
        future: ApiManager.getNewsData(),
        builder: (ctx, responseData) {
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

              return Card(
                margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
                child: ListTile(
                  leading: Image.network(
                    mediaUrl['url'] as String,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(data['title']),
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