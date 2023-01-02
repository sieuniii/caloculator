import 'package:cloud_firestore/cloud_firestore.dart';

class Info{
  late String id;
  late String email;
  late double goal;
  late double goalKcal;
  late double height;
  late String name;
  late String uid;
  late double weight;
  late double age;


  Info({
    required this.id,
    required this.email,
    required this.goal,
    required this.goalKcal,
    required this.height,
    required this.name,
    required this.uid,
    required this.weight,
    required this.age,

  });

  Info.fromSnapshot(DocumentSnapshot snapshot){
    Map<String,dynamic> data = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;
    name = data['name'];
    email = data['email'];
    goal = data['goal'];
    goalKcal = data['goalKcal'];
    height = data['height'];
    weight = data['weight'];
    uid = data['uid'];
    age = data['age'];
  }


  Info.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    goal = data['goal'];
    goalKcal = data['goalKcal'];
    height = data['height'];
    weight = data['weight'];
    uid = data['uid'];
    age = data['age'];
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight':weight,
      'email':email,
      'goal':goal,
      'goalKcal':goalKcal,
      'uid':uid,
      'age': age,
    };
  }

}