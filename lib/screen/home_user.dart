import 'dart:convert';

import 'package:api_call/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final responce =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> usermap in data) {
        userList.add(UserModel.fromJson(usermap));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Api Call",
        ),
      ),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: getUserApi(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        ReusableRow(
                          title: "Name",
                          value: snapshot.data![index].name.toString(),
                        ),
                        ReusableRow(
                          title: "Username",
                          value: snapshot.data![index].username.toString(),
                        ),
                        ReusableRow(
                          title: "Email",
                          value: snapshot.data![index].email.toString(),
                        ),
                        ReusableRow(
                          title: "Address",
                          value: snapshot.data![index].address!.city.toString(),
                        ),
                        ReusableRow(
                          title: "Geo",
                          value: snapshot.data![index].address!.geo!.lat
                              .toString(),
                        ),
                      ]),
                    ),
                  );
                },
              );
            }
          },
        ))
      ]),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
