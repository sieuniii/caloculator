import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:caloculator/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier{

  String userID = FirebaseAuth.instance.currentUser!.uid.toString();

  late String _name;
  late String _height;
  late String _weight;
  late String _goal;
  late String _email;
  late String _uid;
  late String _calculate;
  late String _age;
  late String _sex;

  UserProvider(){
    update();
  }

  String name() => _name;

  String height() => _height;

  String weight() => _weight;

  String goal() => _goal;

  String email() => _email;

  String uid() => _uid;

  String calculate() => _calculate;

  String age() => _age;

  String sex() => _sex;

  void nameSet(String value) {
    _name = value;
    print(_name);
    notifyListeners();
  }

  void heightSet(String value) {
    _height = value;
    print(_height);
    notifyListeners();
  }


  void ageSet(String value) {
    _age = value;
    print(_age);
    notifyListeners();
  }

  void weightSet(String value) {
    _weight = value;
    print(_weight);
    notifyListeners();
  }

  void goalSet(String value) {
    _goal = value;
    print(_goal);
    notifyListeners();
  }

  void sexSet(String value) {
    _sex = value;
    print(_sex);
    notifyListeners();
  }

  void emailSet(String value) {
    _email = value;
    print(_email);
    notifyListeners();
  }

  void uidSet(String value) {
    _uid = value;
    print(_uid);
    notifyListeners();
  }

  void calculateSet(String value) {
    _calculate = value;
    print(_calculate);
    notifyListeners();
  }

  void update() {
    DocumentReference docref = FirebaseFirestore.instance.collection('user').doc(userID);

    docref.get().then((DocumentSnapshot documentSnapshot) {
      nameSet(documentSnapshot.get('name'));
      heightSet(documentSnapshot.get('height').toString());
      weightSet(documentSnapshot.get('weight').toString());
      ageSet(documentSnapshot.get('age').toString());
      goalSet(documentSnapshot.get('goal').toString());
      emailSet(documentSnapshot.get('email'));
      uidSet(documentSnapshot.get('uid'));
      sexSet(documentSnapshot.get('sex'));
      calculateSet((documentSnapshot.get('goal')-documentSnapshot.get('weight')).toString());
    });

    notifyListeners();
  }
}

