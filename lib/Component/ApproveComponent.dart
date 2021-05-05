import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Services.dart';

class ApproveComponent extends StatefulWidget {
  var societyData;
  var index;

  ApproveComponent({this.index,this.societyData});

  @override
  _ApproveComponentState createState() => _ApproveComponentState();
}

class _ApproveComponentState extends State<ApproveComponent> {
  bool isSwitched = false;
  bool isLoading=false;
  _isApproved() async {
    await setState(() {
      isSwitched=widget.societyData["IsVerify"];
      // print(isSwitched);
    });
  }

  _isVerify() async{
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": "${widget.societyData["_id"]}",
          "IsVerify": !isSwitched,
          "adminId": "606db27a0a7f1503d30f8887"
        };
        Services.responseHandler(
            apiName: "masterAdmin/societyVerification", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print('Message:'+responseData.Message.toString());
            Fluttertoast.showToast(msg: responseData.Message.toString());
            setState(() {
              isLoading = false;
              isSwitched=!isSwitched;
              // print(isSwitched);
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
        msg: "You aren't connected to the Internet ! !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    _isApproved();
    // _isVerify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Card(
        child: ExpansionTile(
          title: Container(
            // margin: EdgeInsets.all(5),
            // padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/building.png',
                      height: 20,
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Text('${widget.societyData["Name"]}'.toUpperCase()),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        _isVerify();
                      },
                      activeColor: Colors.green,
                      activeTrackColor: Colors.lightGreen,
                      inactiveTrackColor: Colors.red[400],
                    ),
                  ],
                ),
              ],
            ),
          ),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${widget.societyData["ContactPerson"]}'),
                Text('${widget.societyData["ContactMobile"]}'),
                Text('${widget.societyData["Email"]}'),
                Text('${widget.societyData["Address"]}'),
                Text('${widget.societyData["city"]}'),

              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
