import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caloculator/provider/foodModel.dart';
import 'package:caloculator/provider/foodProvider.dart';
import  'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:caloculator/provider/eatProvider.dart';



class FoodPage extends StatelessWidget{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final eatProvider = Provider.of<EatProvider>(context);
    final time = ModalRoute.of(context)!.settings.arguments as String;
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(now).toString();
    int num = eatProvider.eatFood.length;

    int fat(int num){
      int fatnum = 0;
      for (int i=0; i<num; i++){
        fatnum = fatnum + eatProvider.eatFood[i].fat;
      }
      return fatnum;
    }

    int kcal(int num){
      int kcalnum = 0;
      for (int i=0; i<num; i++){
        kcalnum = kcalnum + eatProvider.eatFood[i].kcal;
      }
      return kcalnum;
    }

    int protein(int num){
      int proteinnum = 0;
      for (int i=0; i<num; i++){
        proteinnum = proteinnum + eatProvider.eatFood[i].protein;
      }
      return proteinnum;
    }

    int carbon(int num){
      int carbonnum = 0;
      for (int i=0; i<num; i++){
        carbonnum = carbonnum + eatProvider.eatFood[i].carbonhydrate;
      }
      return carbonnum;
    }

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background2.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body:
          FutureBuilder(
              future: eatProvider.fetchEatFoodOrCreate(uid, strToday, time),
              builder: (context, snapshot){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                          time,
                          style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 30),
                          textAlign: TextAlign.center
                      ),

                      SizedBox(height:MediaQuery.of(context).size.height/8),

                      Text(
                          " ${kcal(num)} Kcal",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height:40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width/3,
                            lineHeight: 16.0,
                            percent: 0.5,
                            center: Text(
                              " 탄수화물 ${carbon(num)} Kcal",
                              style: new TextStyle(fontSize: 11.0),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor:  Color(0xffffd7d4),
                            backgroundColor: Color(0xffEBEBEB),
                          ),

                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width/3,
                            lineHeight: 16.0,
                            percent: 0.5,
                            center: Text(
                              " 단백질 ${protein(num)} Kcal",
                              style: new TextStyle(fontSize: 11),
                            ),
                            // linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor:  Color(0xffffd7d4),
                            backgroundColor: Color(0xffEBEBEB),
                          ),
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width/3,
                            lineHeight: 16.0,
                            percent: 0.5,
                            center: Text(
                              " 지방 ${fat(num)} Kcal",
                              style: new TextStyle(fontSize: 11.0),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor:  Color(0xffffd7d4),
                            backgroundColor: Color(0xffEBEBEB),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: eatProvider.eatFood.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(eatProvider.eatFood[index].name),
                          subtitle: Text("칼로리 : ${eatProvider.eatFood[index].kcal}, 탄수화물 : ${eatProvider.eatFood[index].carbonhydrate}, 단백질 : ${eatProvider.eatFood[index].protein}, 지방: ${eatProvider.eatFood[index].fat}"),
                          trailing: InkWell(
                            onTap: () {
                              eatProvider.removeEatFood(uid,strToday,time, eatProvider.eatFood[index]);
                            },
                            child: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),


                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context,'/search', arguments: time);
                          }, child: Text("음식 추가하기", style: TextStyle(fontSize: 20))
                      ),
                    ],
                  ),
                );

              }
          )
        )
    );
  }
}

