import 'package:assignment/main.dart';
import 'package:assignment/state/country_provider.dart';
import 'package:assignment/ui/task_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/user_provider.dart';

class Task1 extends StatefulWidget {
  const Task1({super.key});

  @override
  State<Task1> createState() => _Task1State();
}

class _Task1State extends State<Task1> {
  String dropDownValue = 'Emma Wong';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getAllUsers();
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
                Provider.of<CountryProvider>(context, listen: false).refresh();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Task2()));
              },
              child: const Text('Go to Task 2'))
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final users = value.users;
          // String dropDownValue = '${users[2].firstName} ${users[2].lastName}';

          return RefreshIndicator(
            onRefresh: () {
              value.refresh();
              value.getAllUsers();
              dropDownValue = 'Emma Wong';
              return Future.delayed(const Duration(milliseconds: 500));
            },
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton(
                      value: dropDownValue,
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = value.toString();
                        });
                      },
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: users.map((user) {
                        return DropdownMenuItem(
                            onTap: () {
                              value.changeAvatar(user.avatar);
                            },
                            value: '${user.firstName} ${user.lastName}',
                            child: Text(
                                '${user.firstName} ${user.lastName}') // use ValueKey to ensure that each item is unique
                            );
                      }).toList(),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(value.newUrl),
                      radius: 30,
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
