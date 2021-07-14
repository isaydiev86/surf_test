import 'package:surf_test/domain/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<List<User>> getAllUsers() async {
  var url = Uri.https('jsonplaceholder.typicode.com', 'users');
  var response = await http.get(url);
  return allUsersFromJson(response.body);
}