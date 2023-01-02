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

class EditPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _goalController = TextEditingController();


  String userID = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {

    Future<void> editFirebase() async{

      double height = double.parse(_heightController.text);
      double goal = double.parse(_goalController.text);
      double weight = double.parse(_weightController.text);

      FirebaseFirestore.instance
          .collection('user').doc(userID)
          .update(<String, dynamic>{
        'name': _nameController.text,
        'height' : height,
        'weight' :weight,
        'goal' : goal,
      });
      print("************************edit******************");

    }

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
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Text("Edit Profile", style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 30),
                          textAlign: TextAlign.center),
                      SizedBox(height: 100),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)*5/7,
                        child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText : "edit  name",
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)*5/7,
                        child: TextFormField(
                            controller: _heightController,
                            decoration: const InputDecoration(
                              labelText : "edit height",
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)*5/7,
                        child: TextFormField(
                            controller: _weightController,
                            decoration: const InputDecoration(
                              labelText : "edit weight",
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)*5/7,
                        child:TextFormField(
                            controller: _goalController,
                            decoration: const InputDecoration(
                              labelText : "edit goal",
                            )
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)*5/7,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green
                            ),
                            onPressed: (){
                              editFirebase();
                              Navigator.pop(context);
                            },
                            child: Text("SAVE")
                        )
                      )
                    ]
                )
            )
        )
    );
  }
}
