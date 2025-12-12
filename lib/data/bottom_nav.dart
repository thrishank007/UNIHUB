import 'package:flutter/material.dart';
import 'package:unihub/screens/agent_screen.dart';
import 'package:unihub/screens/home_screen.dart';
import 'package:unihub/screens/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: 300,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color.fromARGB(186, 69, 72, 79),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    style: ButtonStyle(
                      iconColor: WidgetStatePropertyAll(Colors.blueGrey),
                    ),
                    hoverColor: Colors.white,
                    icon: Icon(Icons.home)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AgentScreen()));
                    },
                    style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll(Colors.blueGrey)),
                    hoverColor: Colors.white,
                    icon: Icon(Icons.map)),
                IconButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll(Colors.blueGrey)),
                    hoverColor: Colors.white,
                    icon: Icon(Icons.settings)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ));
                    },
                    style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll(Colors.blueGrey)),
                    hoverColor: Colors.white,
                    icon: Icon(Icons.person)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
