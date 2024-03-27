import 'package:flutter/material.dart';
import 'package:notes_app/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // to create something similar to a Javascript Object
  //no
  Map<String, dynamic> settings = {
    'Theme': 'Light',
    'Font Size': 16,
    'Font Family': 'Jost',
    'App Name': 'Bro Notes',
    'App Developer': 'Hari Prasad',
    'App Framework': 'Flutter',
    'App Version': 'Alpha v0.1.0',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Spacer(),
            Text('About',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Jost',
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 237, 255, 207),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 237, 255, 207),
                      Color.fromARGB(255, 217, 255, 156),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(30)),
                child: const ListTile(
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    'Made by Hari Prasad',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Jost',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Alpha v0.1.0',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Jost',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: settings.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jost',
                        fontSize: 20,
                      ),
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      title: Text(settings.keys.elementAt(index)),
                      subtitle:
                          Text(settings.values.elementAt(index).toString()),
                      onTap: () {},
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
