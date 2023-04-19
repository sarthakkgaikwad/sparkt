import 'package:assignment/repository/country.dart';
import 'package:flutter/cupertino.dart';

import '../api/api.dart';

class CountryProvider extends ChangeNotifier {
  final _service = APIService();
  bool isLoading = false;
  List<Country> _countries = [];
  List<String> _names = [];
  List<String> countryListOnSearch = [];

  List<Country> get countries => _countries;

  List<String> get names => _names;

  int get length => _countries.length;

  Future<void> refresh() async {
    isLoading = true;
    notifyListeners();

     _countries = [];
     _names = [];
     countryListOnSearch = [];

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllCountries() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getCountries();

    _countries = response;
    for (var element in _countries) {
      _names.add(element.name);
    }
    _names.sort();

    isLoading = false;
    notifyListeners();
  }

  searchResults(String searchValue) {
    isLoading = true;
    notifyListeners();

    countryListOnSearch = _names
        .where((element) =>
            element.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();

    isLoading = false;
    notifyListeners();
  }
}
