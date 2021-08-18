import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_jini_adminapp/Common/Constant.dart' as cnst;

class societyDownload extends StatefulWidget {
  String societyId, societyName;

  societyDownload({this.societyId, this.societyName});

  @override
  _societyDownloadState createState() => _societyDownloadState();
}

bool isbottomBar = false;

class _societyDownloadState extends State<societyDownload> {
  List getinstallList = [];
  bool isLoading = false;
  List _wingList = [];
  String selectedWing;
  int Index = 0;
  List getnameList = [];
  List getmemberTokenList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWing();
  }

  _getWing() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var data = {"societyId": widget.societyId};
        setState(() {
          isLoading = true;
        });
        print("print data Society");
        print(data);
        Services.responseHandler(
            apiName: "admin/getAllWingOfSociety", body: data)
            .then((data) async {
          if (data.Data != null && data.Data.length > 0) {
            setState(() {
              print("print wingOFSociety...........................");
              print(data.Data);
              for (int i = 0; i < data.Data.length; i++) {
                if (data.Data[i]["totalFloor"].toString() != "0") {
                  _wingList.add(data.Data[i]);
                  print("print ++++++++++_wingList");
                  print(_wingList);
                }
              }
              ;
              // _wingList = data.Data;
              isLoading = false;
              selectedWing = data.Data[0]["_id"].toString();
            });
            _getinstallList(selectedWing);
            // _getotherListing(SocietyId,_fromDate.toString(),_toDate.toString());
            // S.Services.getStaffData(DateTime.now().toString(), DateTime.now().toString(),
            //     data[0]["Id"].toString());
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }, onError: (e) {
          showMsg("Something Went Wrong Please Try Again");
          setState(() {
            isLoading = false;
          });
        });
      }
    } on SocketException catch (_) {
      showMsg("No Internet Connection.");
    }
  }

  showMsg(String msg, {String title = 'MYJINI'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
                ;
              },
            ),
          ],
        );
      },
    );
  }

  _getinstallList(String wingId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Session.WingId, wingId);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {"societyId": widget.societyId, "wingId": wingId};
        print(body);
        Services.responseHandler(
            apiName: "admin/getMemberInstallations", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              getinstallList = responseData.Data;
            });
          } else {
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          }
        }).catchError((error) {
          Fluttertoast.showToast(
            msg: "Error $error",
            backgroundColor: Colors.white,
            textColor: appPrimaryMaterialColor,
          );
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Society Download",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.deepPurple[900],
                // appPrimaryMaterialColor[900],
                appPrimaryMaterialColor[700],
              ],
            ),
          ),
        ),
      ),
      body: _wingList.length > 0 ?
      Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Stack(
          children: [
            Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < _wingList.length; i++) ...[
                    GestureDetector(
                      onTap: () {
                        if (selectedWing != _wingList[i]["_id"].toString()) {
                          setState(() {
                            selectedWing = _wingList[i]["_id"].toString();
                            _getinstallList(selectedWing);
                          });
                        }
                      },
                      child: Container(
                        width: selectedWing == _wingList[i]["_id"].toString()
                            ? 60
                            : 45,
                        height: selectedWing == _wingList[i]["_id"].toString()
                            ? 60
                            : 45,
                        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                            color:
                            selectedWing == _wingList[i]["_id"].toString()
                                ? cnst.appPrimaryMaterialColor
                                : Colors.white,
                            border:
                            Border.all(color: cnst.appPrimaryMaterialColor),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        alignment: Alignment.center,
                        child: Text(
                          "${_wingList[i]["wingName"]}",
                          style: TextStyle(
                              color:
                              selectedWing == _wingList[i]["_id"].toString()
                                  ? Colors.white
                                  : cnst.appPrimaryMaterialColor,
                              fontSize: 19),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Positioned(
              top: 55,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                child: AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemBuilder: _getflatItem,
                    itemCount: getinstallList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: MediaQuery
                          .of(context)
                          .size
                          .width /
                          (MediaQuery
                              .of(context)
                              .size
                              .height / 3.4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _getflatItem(BuildContext context, int index) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration: Duration(milliseconds: 375),
      columnCount: 4,
      child: SlideAnimation(
        child: ScaleAnimation(
          child: Container(
            decoration: BoxDecoration(
              border:
              Border(top: BorderSide(width: 0.1, color: Colors.black)),
            ),
            child: InkWell(
              onTap: () {
                getnameList = getinstallList[index]["memberData"];
                print("print getnameList");
                print("getmemberTokenList.........");

                if (getinstallList[index]["isInstalled"] == true) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.zero,
                        content: Stack(
                          children: [
                            Container(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.10,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.deepPurple[900],
                                      appPrimaryMaterialColor[700],
                                    ],
                                    begin: const FractionalOffset(
                                        0.0, 0.0),
                                    end: const FractionalOffset(
                                        1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.only(left: 75),
                                    ),
                                    Text(
                                      widget.societyName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(left: 55),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Flat No : " +
                                      getinstallList[index]["flatNo"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 0.5,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: getnameList.length,
                                    itemBuilder:
                                        (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(padding: EdgeInsets.only(
                                            top: 5.0,)),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Padding(padding: EdgeInsets.only(
                                                left: 15.0,)),
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 4.5,
                                                child: Text(
                                                  getnameList[index][
                                                  "memberName"],
                                                  style: TextStyle(
                                                      fontFamily: "OpenSans"),
                                                ),
                                              ),
                                              Container(child: Text(" : ")),
                                              Padding(padding: EdgeInsets.only(left:10.0)),
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 3.4,
                                                child: Text(
                                                  getnameList[index]["memberContact"],
                                                  style: TextStyle(
                                                      fontFamily: "OpenSans"),
                                                ),
                                              ),
                                              getnameList[index]["isApp"] ==
                                                  true
                                                  ? getnameList[0]["memberToken"][0]["DeviceType"] ==
                                                  "Android" ? Icon(Icons.android,color: Colors.green,) : Icon(Icons.phone_iphone,color: Colors.green,) : Icon(Icons.ad_units_outlined, color: Colors.red,) ,
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                      left:
                      BorderSide(width: 0.2, color: Colors.grey[600]),
                    )),
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: getinstallList[index]
                          ["isInstalled"] ==
                              true
                              ? Color(0xFF00796B)
                              : Color(0xFFB71C1C),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5),
                              child: Text(
                                getinstallList[index]["flatNo"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "OpenSans"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}