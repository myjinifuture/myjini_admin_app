import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Services.dart';
import 'package:my_jini_adminapp/Component/ApproveComponent.dart';

class ApproveSociety extends StatefulWidget {
  @override
  _ApproveSocietyState createState() => _ApproveSocietyState();
}

class _ApproveSocietyState extends State<ApproveSociety> {
  TextEditingController _search=new TextEditingController();

  bool isLoading = false;
  int Count=0;
  List societyList=[];

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
      appBar: AppBar(
        title: Text('Approve Society'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 15),
            elevation: 1,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                textInputAction: TextInputAction.done,
                controller: _search,
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
                    hintText: "Search Society",
                    hintStyle: TextStyle(fontSize: 13)),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 160,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: societyList.length,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return ApproveComponent(
                    index: index,
                    societyData: societyList[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
