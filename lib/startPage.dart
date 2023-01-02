import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caloculator/provider/googleSignInProvider.dart';
import 'package:google_sign_in/google_sign_in.dart';



class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {

  var uid;
  String? nickname;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), () async{
      var credential = signInWithGoogle();
      uid = await credential.then((value) => value.user?.uid);
      nickname = await credential.then((value) => value.user?.displayName);
      if (uid != null) {
        FirebaseFirestore.instance.collection('user').doc(uid).set({
          'email' :FirebaseAuth.instance.currentUser!.email!,
          'name' : FirebaseAuth.instance.currentUser!.displayName!,
          'uid' : uid,
          'height' : 160,
          'weight' : 60,
          'goal' : 52,
          'age' : 24,
          'sex' : '여자',
        });
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover
          ),
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/caloculator-7a6c4.appspot.com/o/mainImage.png?alt=media&token=6a568049-914e-47ad-b875-dba2f7074ac8',
                  width: 200, height: 200
              ),
              Text(
                  "당신을 위한",
                  style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 30),
                  textAlign: TextAlign.center
              ),
              Text(
                  "내 손 안의 칼로리",
                  style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 40),
                  textAlign: TextAlign.center
              ),
              SizedBox(height:MediaQuery.of(context).size.height/7),

            ],
          ),
        )
      )
    );
  }
}


