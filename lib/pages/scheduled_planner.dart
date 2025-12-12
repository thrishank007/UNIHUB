import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class ScheduledPlanner extends StatefulWidget{
  const ScheduledPlanner({super.key});

  @override
  State<ScheduledPlanner> createState() => _ScheduledPlannerState();
}

class _ScheduledPlannerState extends State<ScheduledPlanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(10, 2, 46, 1),
        title: Text('Your Chemistry Revision Plan', style: TextStyle(color: Colors.white, fontSize: 24,),),
        leading: BackButton(color: Colors.white,),
      ),
      body: Stack(

        children: [
          Positioned.fill(child: Image.asset('assets/images/agent_home.jpeg', fit: BoxFit.cover,)),
          Column(
            children: [
              const SizedBox(height: 10,),
              Container(alignment: Alignment.center,
              child: CircularPercentIndicator(radius: 70.0,
              lineWidth: 12.0,
              percent: 0.0,
              backgroundColor: Colors.white,
              progressColor: Colors.blueAccent,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              ),
              ),
          
            ],
          ),
        ],
      ),
    );
  }
}