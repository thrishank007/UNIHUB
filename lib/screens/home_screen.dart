import 'package:flutter/material.dart';
import 'package:unihub/data/bottom_nav.dart';
import 'package:unihub/pages/scan_notes.dart';
import 'package:unihub/pages/study_planner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(188, 2, 2, 61),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/home_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 35.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        Text(
                          'Hello User!',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Dream Big, Work Smart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          size: 40.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  label: Text('Search', style: TextStyle(color: Colors.white)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Row(
            //   children: [
            //     Text(
            //       'Focus Room',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 24.0,
            //       ),
            //     ),
            //     const Spacer(),
            //     OutlinedButton(
            //       onPressed: () {},
            //       style: ButtonStyle(
            //         backgroundColor: WidgetStatePropertyAll(
            //           const Color.fromARGB(215, 46, 46, 46),
            //         ),
            //       ),
            //       child: Text('See all', style: TextStyle(color: Colors.white)),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),
            // Padding(
            //   padding: EdgeInsets.all(12.0),
            //   child: Container(
            //     width: double.infinity,
            //     height: 150,

            //     decoration: BoxDecoration(
            //       color: const Color.fromARGB(175, 12, 66, 111),
            //       borderRadius: BorderRadius.circular(35.0),
            //     ),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding: EdgeInsets.all(12.0),
            //           child: Text(
            //             'Focus Room 1',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //         const Spacer(),
            //         IconButton(
            //           onPressed: () {},
            //           icon: Icon(Icons.forward),
            //           style: ButtonStyle(
            //             iconColor: WidgetStatePropertyAll(Colors.white),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                padding: EdgeInsets.all(16.0),
                childAspectRatio: 0.85,
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudyPlanner())),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/grid_1.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20.0,
                                ),
                              ),
                            ),
                            Text(
                              'AI Study Planner',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Automatically creates and manages your study schedule with smart conflict detection.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScanNotes())),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/grid_2.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(radius: 20.0),
                              ),
                            ),
                            Text(
                              'Smart Notes Scanner',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Scan handwritten notes and convert them into organized, editable digital text with ease.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/grid_3.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(radius: 20.0),
                            ),
                          ),
                          Text(
                            'Smart Remainders',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Never miss important deadlines or study sessions with AI-powered reminders that adapt to your schedule.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/grid_4.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(radius: 20.0),
                            ),
                          ),
                          Text(
                            'SmartPrep Analyzer',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Predicts whats likely to appear - So students can focus smart.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BottomNav(),
          ],
        ),
      ),
    );
  }
}
