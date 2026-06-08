import 'dart:convert';
import 'package:http/http.dart' as http;
import 'person_model.dart';

class PersonService {
  final String baseUrl = 'https://api.themoviedb.org/3/';
  final String apiKey = '2dfe23358236069710a379edd4c65a6b';

  Future<List<PersonModel>> getPopularPersons({required int page}) async {
    final url = Uri.parse(
      '${baseUrl}person/popular?api_key=$apiKey&page=$page',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List results = data['results'];

      return results.map((e) => PersonModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load persons');
    }
  }
}
