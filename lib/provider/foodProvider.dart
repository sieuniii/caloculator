import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'foodModel.dart';


class FoodProvider with ChangeNotifier{
  late CollectionReference foodReference;
  List<Food> foods = [];

  FoodProvider({reference}){
    foodReference = reference ?? FirebaseFirestore.instance.collection('food');
  }

  Future<void> fetchFood() async{
    foods = await foodReference.get().then( (QuerySnapshot results){
      return results.docs.map((DocumentSnapshot document){
        return Food.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }
}

