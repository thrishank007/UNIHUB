import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: 
            Text(
              'Settings',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.normal),
            ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(10, 2, 46, 1),
      ),
    );
  }
}