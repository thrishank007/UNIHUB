import 'package:flutter/material.dart';
import 'package:unihub/data/bottom_nav.dart';
import 'package:unihub/pages/scheduled_planner.dart';

class StudyPlanner extends StatefulWidget {
  const StudyPlanner({super.key});

  @override
  State<StudyPlanner> createState() => _StudyPlannerState();
}

class _StudyPlannerState extends State<StudyPlanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Column(
          children: [
            Text(
              'Study Planner',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              'Let AI create study schedule',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(10, 2, 46, 1),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/images/agent_home.jpeg',
            fit: BoxFit.cover,
          )),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'What do you want to study?',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 85, 86, 91),
                      hint: Text(
                        'E.g: Prepare for chemistry exam',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Available Time',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 85, 86, 91),
                      hint: Text(
                        'E.g: 2hours per day',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Focus Type',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text('Deep Work'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Chip(
                        label: Text('Notes'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Chip(
                        label: Text('Revision'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Chip(
                        label: Text('Exam Preparation'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Upload document',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color.fromARGB(255, 85, 86, 91),
                      ),
                      width: double.infinity,
                      height: 250,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.upload),
                            color: Colors.white,
                            iconSize: 40,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Click to upload',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'PDF, JPG, PNG less than 10MB',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduledPlanner()));
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  const Color.fromARGB(255, 43, 52, 227))),
                          child: Text(
                            'Generate Schedule',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(alignment: Alignment.bottomCenter, child: BottomNav()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
