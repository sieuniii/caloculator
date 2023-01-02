import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caloculator/provider/googleSignInProvider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'dart:math';
import 'dart:ui';
import 'package:caloculator/provider/eatProvider.dart';
import 'package:percent_indicator/percent_indicator.dart';



class LoggedInWidget extends StatefulWidget {
  @override
  State<LoggedInWidget> createState() => _LoggedInWidget();
}

class _LoggedInWidget extends State<LoggedInWidget> with TickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;


    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(now).toString();
    final eatProvider = Provider.of<EatProvider>(context);

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background2.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Text(
                      "Today",
                      style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 30),
                      textAlign: TextAlign.center
                  ),

                  SizedBox(height:MediaQuery.of(context).size.height/10),
                  new CircularPercentIndicator(
                    backgroundColor: Colors.transparent,
                    radius: 75.0,
                    lineWidth: 15.0,
                    animation: true,
                    percent: 0.7,
                    center: new Text(
                      "70.0%",
                      style:
                      new TextStyle(fontSize: 20.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Color(0xffffd7d4),
                  ),
                  SizedBox(height:30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new LinearPercentIndicator(
                        backgroundColor: Colors.transparent,
                        width: MediaQuery.of(context).size.width/3,
                        lineHeight: 16.0,
                        percent: 0.5,
                        center: Text(
                          "탄수화물 50.0%",
                          style: new TextStyle(fontSize: 11.0),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor:  Color(0xffffd7d4),
                      ),

                      new LinearPercentIndicator(
                        backgroundColor: Colors.transparent,
                        width: MediaQuery.of(context).size.width/3,
                        lineHeight: 16.0,
                        percent: 0.5,
                        center: Text(
                          "단백질 50.0%",
                          style: new TextStyle(fontSize: 11),
                        ),
                        // linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor:  Color(0xffffd7d4),
                      ),
                      new LinearPercentIndicator(
                        backgroundColor: Colors.transparent,
                        width: MediaQuery.of(context).size.width/3,
                        lineHeight: 16.0,
                        percent: 0.5,
                        center: Text(
                          "지방 50.0%",
                          style: new TextStyle(fontSize: 11.0),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor:  Color(0xffffd7d4),
                      ),

                    ],
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,'/food', arguments: "Breakfast");
                    },
                    child: SizedBox(
                    height: MediaQuery.of(context).size.height/9,
              width: (MediaQuery.of(context).size.width)*10/11,
              child: Card(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),

                ),
                elevation: 4.0,
                color: Color(0xffEBEBEB),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Breakfast 0 kcal", style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 20)),
                    ],
                  ),
                ),
              ),
            ),
                  ),

                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,'/food', arguments: "Lunch");
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height/9,
                      width: (MediaQuery.of(context).size.width)*10/11,
                      child: Card(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),

                        ),
                        elevation: 4.0,
                        color: Color(0xffEBEBEB),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Lunch 0 kcal", style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 20),),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,'/food', arguments: "Dinner");
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height/9,
                      width: (MediaQuery.of(context).size.width)*10/11,
                      child: Card(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),

                        ),
                        elevation: 4.0,
                        color: Color(0xffEBEBEB),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Dinner 0 kcal", style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 20),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            visible: true,
            closeManually: false,
            curve: Curves.bounceIn,
            overlayOpacity: 0.5,
            backgroundColor: Colors.green,
            elevation: 8.0,
            shape: CircleBorder(),
            children:[
              SpeedDialChild(
                child: Icon(Icons.person),
                onTap: (){
                  Navigator.pushNamed(context,'/profile');
                }
              ),
              SpeedDialChild(
                  child: Icon(Icons.calendar_month)
              ),

              SpeedDialChild(
                  child: Icon(Icons.directions_bike)
              ),
            ]
          ),
        )
    );
  }
}





