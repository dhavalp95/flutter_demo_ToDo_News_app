import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiManager {
  static Future<List<Map<String, dynamic>>> getNewsData() async {
    print('--------ApI Caling Start');

    // Create base URL
    final url = Uri.parse(
      'https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=1lhSXwmGkeU46dJzQzULYT2ZDTpMPDKD',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      final newsData = responseData['results'] as List;
      final listNewsDict = newsData
          .map((abc) => abc as Map<String, dynamic>)
          .toList();

      return listNewsDict;
    } else {
      throw Exception('ERROR!!\nData not fetched!');
    }
  }
}
