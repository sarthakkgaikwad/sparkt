import 'package:assignment/state/user_provider.dart';
import 'package:assignment/ui/task_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/country_provider.dart';

class Task2 extends StatefulWidget {
  const Task2({Key? key}) : super(key: key);

  @override
  State<Task2> createState() => _Task2State();
}

class _Task2State extends State<Task2> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CountryProvider>(context, listen: false).getAllCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.orange),
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).refresh();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Task1()));
              },
              child: const Text('Go to Task 1'))
        ],
      ),
      body: Consumer<CountryProvider>(
        builder: (context, value, child) {
          List<String> countryNames = value.names;
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  onChanged: (searchValue) {
                    value.searchResults(searchValue);
                  },
                  cursorColor: Colors.orange,
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Search',
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    setState(() {
                      _textEditingController.text = '';
                    });
                    return Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: ListView.builder(
                    itemCount: _textEditingController.text.isNotEmpty
                        ? value.countryListOnSearch.length
                        : countryNames.length,
                    itemBuilder: (context, index) {
                      final country = _textEditingController.text.isNotEmpty
                          ? value.countryListOnSearch[index]
                          : countryNames[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(title: Text(country)),
                          countryNames[index][0] != countryNames[index + 1][0]
                              ? Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                    countryNames[index + 1][0],
                                    style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                              )
                              : const Text(''),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
