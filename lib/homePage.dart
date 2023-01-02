import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:caloculator/startPage.dart';
import 'caloPage.dart';


class  HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child:CircularProgressIndicator());
          }else if(snapshot.hasData){
            return LoggedInWidget();
          }else if(snapshot.hasError){
            return Center(child: Text ('Snapshot Error!'));
          } else {
            return StartPage();
          }
        }
    );
  }
}
