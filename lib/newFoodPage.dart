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

class NewFoodPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _carbonController = TextEditingController();
  final _fatController = TextEditingController();
  final _proteinController = TextEditingController();
  final _kcalController = TextEditingController();


  String userID = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {

    Future<void> addFirebase() async{

      int kcal = int.parse(_kcalController.text);
      int fat = int.parse(_fatController.text);
      int protein = int.parse(_proteinController.text);
      int carbon = int.parse(_carbonController.text);

      FirebaseFirestore.instance
          .collection('food').doc(_nameController.text)
          .set({
        'name': _nameController.text,
        'kcal' : kcal,
        'fat' :fat,
        'protein' : protein,
        'carbonhydrate' : carbon,
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
                      Text("New Food", style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 30),
                          textAlign: TextAlign.center),
                      SizedBox(height: 100),
                      SizedBox(
                        width:  (MediaQuery.of(context).size.width)*5/7,
                        child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText : "Input  name",
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)*5/7,
                        child: TextFormField(
                            controller: _kcalController,
                            decoration: const InputDecoration(
                              labelText : "Input Kcal",
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width:  (MediaQuery.of(context).size.width)*5/7,
                        child: TextFormField(
                            controller: _carbonController,
                            decoration: const InputDecoration(
                              labelText : "Input Carbon",
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)*5/7,
                        child: TextFormField(
                            controller: _proteinController,
                            decoration: const InputDecoration(
                              labelText : "Input Protein",
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)*5/7,
                        child: TextFormField(
                            controller: _fatController,
                            decoration: const InputDecoration(
                              labelText : "Input Fat",
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
                              addFirebase();
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
