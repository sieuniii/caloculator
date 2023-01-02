import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/googleSignInProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caloculator/provider/userProvider.dart';
import 'searchPage.dart';
import 'package:caloculator/provider/foodModel.dart';
import 'userModel.dart';

class ProfilePage extends StatelessWidget {
  String userID = FirebaseAuth.instance.currentUser!.uid.toString();
  final Stream<DocumentSnapshot<Map<String, dynamic>>> usersStream =
      FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid.toString()).snapshots();

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);



      String name = userProvider.name();
      String email = userProvider.email();
      String goal = userProvider.goal();
      String weight = userProvider.weight();
      String height = userProvider.height();
      String age = userProvider.age();
      String calculate = userProvider.calculate();
      String sex = userProvider.sex();
      var calculateDouble = double.parse(calculate);


    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background2.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  semanticLabel: 'logout',
                ),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                  print('logout button');
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Text("Information",
                      style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 30),
                      textAlign: TextAlign.center
                  ),
                  SizedBox(height: 25),
                  CircleAvatar(
                      backgroundImage:NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                    radius: 50,
                  ),
                  SizedBox(height: 30),
                  Text(name.toString(), style: TextStyle( fontSize: 20),),
                  SizedBox(height: 30),
                  Text("age : $age"),
                  SizedBox(height: 30),
                  Text("gender : $sex"),
                  SizedBox(height: 30),
                  Text("Height : $height"),
                  SizedBox(height: 30),
                  Text("Weight : $weight"),
                  SizedBox(height: 30),
                  Text("Goal : $goal"),
                  SizedBox(height: 30),
                  calculateDouble >=0 ?
                  (calculateDouble ==0 ? Text("현재 유지 중", style: TextStyle( fontSize: 20),) : Text("현재 $calculateDouble kg 증량 중", style: TextStyle( fontSize: 20),) ):
                  Text("현재 $calculateDouble kg 감량 중", style: TextStyle( fontSize: 20),),
                  SizedBox(height: 30),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context,'/edit');
                      },
                      child: Text("EDIT")
                  )
                ]
            )
          )
      )
    );
  }
}
