import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(10, 2, 46, 1),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/agent_home.jpeg', fit: BoxFit.cover,)),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: const Color.fromARGB(205, 39, 16, 152)
                  ),
                  child: Image.asset(''),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}