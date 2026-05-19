import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';
import '../config/secrets.dart';

// Fetches profile data from JSONBin REST API.
class ApiService {
  Future<ProfileModel> fetchProfile() async {
    final response = await http.get(
      Uri.parse(Secrets.url),
      headers: {'X-Access-Key': Secrets.jsonBinApiKey, 'X-Bin-Meta': 'false'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ProfileModel.fromJson(json);
    }
    throw Exception('Failed to load profile: ${response.statusCode}');
  }
}
