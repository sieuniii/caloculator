import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caloculator/provider/foodModel.dart';
import 'package:caloculator/provider/foodProvider.dart';



class CalenderPage extends StatelessWidget{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background2.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    "Dinner",
                    style: TextStyle(fontFamily:'pyeongChangPeace' , fontSize: 30),
                    textAlign: TextAlign.center
                ),

                SizedBox(height:MediaQuery.of(context).size.height/7),

                Text("700 Kcal"),
                Expanded(child: showCard(context))

              ],
            ),
          ),

        )
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Main'),
    //     actions: <Widget>[
    //       IconButton(
    //         icon: const Icon(
    //           Icons.add,
    //           semanticLabel: 'addItem',
    //         ),
    //         onPressed: () {
    //           // Navigator.pushNamed(context,'/search');
    //           print('add Item button');
    //         },
    //       ),
    //     ],
    //   ),
    //   body: Container(
    //       child: Column(
    //         children: [
    //           Consumer<DropdownProvider>(
    //               builder: (context, value, child) =>
    //                   Container(
    //                     alignment: Alignment.center,
    //                     margin: const EdgeInsets.only(top:30),
    //                     child:DropdownButton(
    //                       value: value.selectedSort,
    //                       items: value.sortList.map((value){
    //                         return DropdownMenuItem(
    //                           value: value,
    //                           child: Text(value),
    //                         );
    //                       }).toList(),
    //                       onChanged: (v){
    //                         value.selectSortValue(v);
    //                       },
    //                     ),
    //                   )
    //           ),
    //           Expanded(
    //               child: showCard(context)
    //           ),
    //         ],
    //       )
    //   ),
    //   resizeToAvoidBottomInset: false,
    // );
  }

  FutureBuilder showCard(BuildContext context){

    final user = FirebaseAuth.instance.currentUser;
    final foodProvider = Provider.of<FoodProvider>(context);

    return FutureBuilder(
      future: foodProvider.fetchFood(),
      builder: (context,snapshots){
        if(foodProvider.foods.length == 0){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else{
          return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1/1.5,
              ),
              itemCount: foodProvider.foods.length,
              itemBuilder: (context, index){
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(foodProvider.foods[index].name, style: TextStyle(fontSize: 15)),
                              const SizedBox(height: 8.0),
                              Text(foodProvider.foods[index].kcal.toString()+"kcal", style: TextStyle(fontSize: 16)),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        }
      },
    );
  }
}