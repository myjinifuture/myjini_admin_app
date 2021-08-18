import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Services.dart';
import 'package:my_jini_adminapp/Component/DashboardComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController _txtsearch = new TextEditingController();
  bool isLoading = false;
  int Count = 0;
  List societyList = [];

  _getSocietyList() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "IsVerify": "true",
        };
        Services.responseHandler(
                apiName: "masterAdmin/getSocietyList", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            societyList = responseData.Data;
            print("print Id +++++++++++++++++++++");
            print(societyList);
            print("print Id +++++++++++++++++++++End");
            setState(() {
              isLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
            msg: "Error $error",
            backgroundColor: Colors.white,
            textColor: appPrimaryMaterialColor,
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getSocietyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(),
        body: Stack(children: [
          // Background with gradient
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurple[900],
                      appPrimaryMaterialColor[900],
                      appPrimaryMaterialColor[700],
                    ]),
              ),
              height: MediaQuery.of(context).size.height * 0.18),
          Card(
            margin: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 110.0, bottom: 15),
            elevation: 1,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                textInputAction: TextInputAction.done,
                controller: _txtsearch,
                keyboardType: TextInputType.text,
                cursorColor: appPrimaryMaterialColor,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      // borderSide:
                      //     BorderSide(color: appPrimaryMaterialColor[600]),
                      borderSide: BorderSide.none,
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      // borderSide: new BorderSide(),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search your members",
                    hintStyle: TextStyle(fontSize: 13)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 170.0, bottom: 15),
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: societyList.length,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return DashboardComponent(
                    index: index,
                    societyData: societyList[index],
                  );
                },
              ),
            ),
          ),
          //Above card
          // Card(
          //     elevation: 20.0,
          //     margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 100.0),
          //     child: ListView(
          //         padding: EdgeInsets.only(
          //             top: 20.0, left: 20.0, right: 18.0, bottom: 5.0),
          //         children: <Widget>[TextField(), TextField()])),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text("Dashboard"),
            ),
          ),
        ]));
  }
}
