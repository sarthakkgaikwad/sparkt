import 'dart:convert';
import 'package:assignment/repository/country.dart';
import 'package:assignment/repository/user.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<dynamic> getUsers() async {
    String url = 'https://reqres.in/api/users?per_page=12';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final userJson = json['data'];

      final users = (userJson as List)
          .map(
            (e) => User(
                id: e['id'],
                email: e['email'],
                firstName: e['first_name'],
                lastName: e['last_name'],
                avatar: e['avatar']),
          )
          .toList();
      return users;
    }
    throw "Something went wrong";
  }

  Future<dynamic> getCountries() async {
    String url = 'https://restcountries.com/v3.1/all';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final countries = (json as List)
          .map(
            (e) => Country(name: e['name']['common']),
          )
          .toList();
      return countries;
    }
    throw "Something went wrong";
  }
}
