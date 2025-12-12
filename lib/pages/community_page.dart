import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget{
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
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
              'Community',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              'Connect. Share. Grow.',
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
            Positioned.fill(child: Image.asset('assets/images/agent_home.jpeg', fit: BoxFit.cover,),),
            Column(
              children: [
                Padding(padding: EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: double.infinity,
                  height: 500,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.all(12.0),
                            child: CircleAvatar(radius: 35,)),
                          const SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Text('Electronics Club', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Text('2 hours ago'),],
                              ),         
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/community_demo.jpeg'), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(12.0),
                          ),  
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text('💡 Innoyudh Hackathon - Team Connect', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, ),),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Hi Innovators! Use this group for updates, discussions, and teamwork.Let\'s make Innoyudh memorable with great ideas! 💡', style: TextStyle(fontSize: 20,),))
                    ],
                  ),
                  
                ),),
                Padding(padding: EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.all(12.0),
                            child: CircleAvatar(radius: 35,)),
                          const SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Text('Alex Kumar', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Text('11 hours ago'),],
                              ),         
                        ],
                      ),  
                      const SizedBox(height: 20,),
                      Text('💡Exploring New Innovation!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, ),),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Hey everyone, let\'s start sharing fresh ideas and creative solutions.Any small spark can turn into a great innovation if we work together.Let\'s collaborate and build something impactful!', style: TextStyle(fontSize: 20,),))
                    ],
                  ),
                  
                ),),
                 Padding(padding: EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.all(12.0),
                            child: CircleAvatar(radius: 35,)),
                          const SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Text('Alex Kumar', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Text('11 hours ago'),],
                              ),         
                        ],
                      ),  
                      const SizedBox(height: 20,),
                      Text('💡Exploring New Innovation!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, ),),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Hey everyone, let\'s start sharing fresh ideas and creative solutions.Any small spark can turn into a great innovation if we work together.Let\'s collaborate and build something impactful!', style: TextStyle(fontSize: 20,),))
                    ],
                  ), 
                ),),
                Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 85, 86, 91),
                  hint: Text('Write anything to share'),
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
            )
          ],
        ),
      ),
    );
  }
}