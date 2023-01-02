import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:caloculator/provider/foodModel.dart';

class EatProvider with ChangeNotifier {
  late CollectionReference eatReference;
  List<Food> eatFood = [];

  EatProvider({reference}) {
    eatReference = reference ?? FirebaseFirestore.instance.collection('eat');
  }

  Future<void> fetchEatFoodOrCreate(String uid, String date, String time) async {
    if (uid == ''){
      return ;
    }
    final eatSnapshot = await eatReference.doc(uid).collection(date).doc(time).get();
    if(eatSnapshot.exists) {
      Map<String, dynamic> eatFoodMap = eatSnapshot.data() as Map<String, dynamic>;
      List<Food> temp = [];
      for (var food in eatFoodMap['eatFood']) {
        temp.add(Food.fromMap(food));
      }
      eatFood = temp;
      notifyListeners();
    } else {
      await eatReference.doc(uid).collection(date).doc(time).set({'eatFood': []});
      notifyListeners();
    }
  }


  Future<void> addeatFood(String uid, String date, String time,Food food) async {

    eatFood.add(food);
    Map<String, dynamic> eatFoodMap = {
      'eatFood': eatFood.map( (food) {
        return food.toSnapshot();
      }).toList()
    };

    var newFood =  FirebaseFirestore.instance.collection('eat');
    await newFood.doc(uid).collection(date).doc(time).set(eatFoodMap);

    notifyListeners();
  }

  Future<void> removeEatFood(String uid, String date, String time,Food food) async {
    eatFood.removeWhere((element) => element.name == food.name);
    Map<String, dynamic> eatFoodMap = {
      'eatFood': eatFood.map((food) {
        return food.toSnapshot();
      }).toList()
    };

    await eatReference.doc(uid).collection(date).doc(time).set(eatFoodMap);
    notifyListeners();
  }

  // bool iseatFoodIn(Food food) {
  //   return eatFood.any((element) => element.id == product.id);
  // }
}