import 'package:flutter/material.dart';
import 'package:unihub/data/bottom_nav.dart';

class ScanNotes extends StatefulWidget {
  const ScanNotes({super.key});

  @override
  State<ScanNotes> createState() => _ScanNotesState();
}

class _ScanNotesState extends State<ScanNotes> {
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
              'Notes Scanner',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              'From paper to power',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(10, 2, 46, 1),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              'assets/images/agent_home.jpeg',
              fit: BoxFit.cover,
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    height: 300,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 80.0,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Scan Your Notes',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Smarter Notes Start Here',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
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
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          iconSize: 40,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Upload your notes here',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Recent Scans',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child:
                                  Image.asset('assets/images/notes_img.jpeg')),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  'Data Structres Notes',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                'Trees & Graphs',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child:
                                  Image.asset('assets/images/notes_img.jpeg')),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  'ML Assignment',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                'Neural Networks',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                    alignment: Alignment.bottomCenter, child: BottomNav()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
