import 'package:cloud_firestore/cloud_firestore.dart';

class Food{
  late int fat;
  late int protein;
  late int carbonhydrate;
  late String name;
  late int kcal;



  Food({
    required this.fat,
    required this.protein,
    required this.carbonhydrate,
    required this.name,
    required this.kcal,
  });

  Food.fromSnapshot(DocumentSnapshot snapshot){
    Map<String,dynamic> data = snapshot.data() as Map<String, dynamic>;
    name = data['name'];
    fat = data['fat'];
    protein = data['protein'];
    carbonhydrate = data['carbonhydrate'];
    kcal = data['kcal'];
  }

  Food.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    fat = data['fat'];
    protein = data['protein'];
    carbonhydrate = data['carbonhydrate'];
    kcal = data['kcal'];
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'name': name,
      'carbonhydrate': carbonhydrate,
      'kcal':kcal,
      'fat':fat,
      'protein':protein,
    };
  }

}