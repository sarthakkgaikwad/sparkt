import 'package:assignment/api/api.dart';
import 'package:flutter/cupertino.dart';

import '../repository/user.dart';

class UserProvider extends ChangeNotifier {
  final _service = APIService();
  bool isLoading = false;
  List<User> _users = [];
  List<User> get users => _users;
  String newUrl = 'https://reqres.in/img/faces/3-image.jpg';

  Future<void> refresh() async {
    isLoading = true;
    notifyListeners();

    _users = [];
    newUrl = 'https://reqres.in/img/faces/3-image.jpg';

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllUsers() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getUsers();

    _users = response;
    isLoading = false;
    notifyListeners();
  }

  changeAvatar (String url) {
    newUrl = url;
    notifyListeners();
  }

}