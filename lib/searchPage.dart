import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caloculator/provider/googleSignInProvider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:caloculator/provider/foodModel.dart';
import 'package:caloculator/provider/eatProvider.dart';

class SearchPage extends StatefulWidget {
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {

  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";
  String userID = FirebaseAuth.instance.currentUser!.uid.toString();

  _SearchPage() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('food').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data!.docs);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data().toString().contains(_searchText)) {
        searchResults.add(d);
      }
    }
    return Expanded(
      child: ListView(
          children: searchResults
              .map((data) => _buildListItem(context, data))
              .toList()
      )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    var eatProvider = Provider.of<EatProvider>(context);
    final time = ModalRoute.of(context)!.settings.arguments as String;
    final food = Food.fromSnapshot(data);
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(now).toString();
    return
    Column(
      children: [
        ListTile(
          onTap: (){

           showDialog(
               context: context,
               builder: (BuildContext context){
                 return AlertDialog(
                     content: Text("${food.name}??? ${time} ??? ?????????????????????????"),
                     actions: [
                       TextButton(
                           onPressed: (){
                             eatProvider.addeatFood(userID, strToday, time , food);
                             Navigator.popUntil(context, ModalRoute.withName("/food"));
                           },
                           child: Text("???")
                       ),
                       TextButton(
                           onPressed: (){
                             Navigator.of(context).pop();
                           },
                           child: Text("?????????")
                       ),
                     ]
                 );
               }
           );
          },
          title: Text(food.name),
          subtitle: Text("????????? : ${food.kcal},  ????????? : ${food.protein},  ?????? : ${food.fat},  ???????????? : ${food.carbonhydrate}"),
          tileColor: Colors.white,
        ),
        Divider(height: 1, color: Colors.black)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {


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
            body: Column(
                children: <Widget>[
              Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(children: <Widget>[
                    Expanded(
                        flex: 6,
                        child: TextField(
                          focusNode: focusNode,
                          style: TextStyle(fontSize: 15),
                          autofocus: true,
                          controller: _filter,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white12,
                            prefixIcon: Icon(Icons.search,
                                color: Colors.white, size: 20),
                            suffixIcon: focusNode.hasFocus
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _filter.clear();
                                        _searchText = "";
                                      });
                                    },
                                    icon: Icon(Icons.cancel,
                                        size: 20, color: Colors.white))
                                : Container(),
                            hintText: '????????? ??????????????????',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ))
                  ])),
              _buildBody(context),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(

                      primary: Colors.green
                    ),
                      onPressed: (){
                        Navigator.pushNamed(context,'/newFood');
                      },
                      child: Text("????????? ?????? ????????????", style: TextStyle(fontSize: 20))
                  ),
                  SizedBox(height: 20)
            ]),

        ));
  }
}
