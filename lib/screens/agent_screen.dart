import 'package:flutter/material.dart';

class AgentScreen extends StatefulWidget {
  const AgentScreen({super.key});

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UniHub AI',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(10, 2, 46, 1),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/agent_home.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Text(
              'What can I do for you!',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 85, 86, 91),
                  hint: Text('Ask UniHub AI'),
                  prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.white,),),
                  suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.send, color: Colors.white,),),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
            ), 
          ),
        ],
      ),
    );
  }
}
