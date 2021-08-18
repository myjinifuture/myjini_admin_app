import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_jini_adminapp/Common/ExtensionMethods.dart';

class MemberProfile extends StatefulWidget {
  var memberData;
  Function onAdminUpdate;
  String isContactNumberPrivate,wingName;

  MemberProfile({this.memberData, this.isContactNumberPrivate, this.onAdminUpdate,this.wingName});

  @override
  _MemberProfileState createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  String setDate(String date) {
    String final_date = "";
    var tempDate;
    if (date != "" || date != null) {
      tempDate = date.toString().split("-");
      if (tempDate[2].toString().length == 1) {
        tempDate[2] = "0" + tempDate[2].toString();
      }
      if (tempDate[1].toString().length == 1) {
        tempDate[1] = "0" + tempDate[1].toString();
      }
      final_date = date == "" || date == null
          ? ""
          : "${tempDate[2].toString().substring(0, 2)}-${tempDate[1].toString()}-${tempDate[0].toString()}"
              .toString();
    }
    final_date = date == "" || date == null
        ? ""
        : "${tempDate[2].toString().substring(0, 2)}-${tempDate[1].toString()}-${tempDate[0].toString()}"
            .toString();

    return final_date;
  }

  List VehicleData = new List();
  List FmemberData = new List();
  bool isLoading = false;
  String SocietyId, MemberId, ParentId;
  String SocietyIdF, MemberIdF, ParentIdF;

  @override
  void initState() {
    // GetMyvehicleData();
     //_getLocaldata();
    //GetFamilyDetail();
    // _getLocaldata1();
  }

  _getLocaldata() async {
    print(widget.memberData["Id"].toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SocietyId = widget.memberData["SocietyId"].toString();
    setState(() {
      MemberId = widget.memberData["Id"].toString();
    });
  }

  GetMyvehicleData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.GetVehicleData(MemberId).then((data) async {
          setState(() {
            isLoading = false;
          });
          if (data != null && data.length > 0) {
            setState(() {
              VehicleData = data;
              print("======================================");
              print(VehicleData.length.toString());
            });
          } else {
            setState(() {
              VehicleData = data;
              isLoading = false;
            });
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          showHHMsg("Try Again.", "");
        });
      }
    } on SocketException catch (_) {
      showHHMsg("No Internet Connection.", "");
    }
  }

  showHHMsg(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _getLocaldata1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      SocietyIdF = widget.memberData["SocietyId"].toString();
      MemberIdF = widget.memberData["Id"].toString();
    });

    if (widget.memberData["ParentId"].toString() == "null" ||
        widget.memberData["ParentId"].toString() == "")
      setState(() {
        ParentIdF = "0";
      });
    else
      setState(() {
        ParentIdF = widget.memberData["ParentId"].toString();
      });
  }

  GetFamilyDetail() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        Services.GetFamilyMember(ParentIdF, MemberIdF).then((data) async {
          setState(() {
            isLoading = false;
          });
          if (data != null && data.length > 0) {
            setState(() {
              FmemberData = data;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          showHHMsg("Try Again.", "");
        });
      }
    } on SocketException catch (_) {
      showHHMsg("No Internet Connection.", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
        title: Text(
          'Profile',
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: Colors.grey[300], width: 1))),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DirectoryProfileVehicle(
                      //               vehicleData:
                      //                   widget.MemberData["Id"].toString(),
                      //             )));
                    },
                    child: Container(
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
                          borderRadius: BorderRadius.circular(6)),
                      // decoration: BoxDecoration(
                      //     color: Colors.green,
                      //     borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                                "Vehicles :  " + VehicleData.length.toString(),
                                style: TextStyle(color: Colors.white))),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DirectoryProfileFamily(
                      //               familyData: widget.MemberData,
                      //             )));
                    },
                    child: Container(
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
                          borderRadius: BorderRadius.circular(6)),
                      // decoration: BoxDecoration(
                      //     color: appPrimaryMaterialColor,
                      //     borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                                "Members :  " + FmemberData.length.toString(),
                                style: TextStyle(color: Colors.white))),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          image: new DecorationImage(
                              image:
                                  // widget.MemberData["Image"] == null ||
                                  //         widget.MemberData["Image"] == ""
                                  //     ?
                                  AssetImage("assets/user.png"),
                              // : NetworkImage(Image_Url +
                              //     '${widget.MemberData["Image"]}'),
                              fit: BoxFit.cover),
                          borderRadius:
                              BorderRadius.all(new Radius.circular(75.0)),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 8)
                          ]),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Visible",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontSize: 14))
                    // '${widget.MemberData["IsPrivate"]}' == "null"
                    //     ? Row(
                    //         children: <Widget>[
                    //           Icon(Icons.remove_red_eye,
                    //               size: 16, color: Colors.red),
                    //           Text("Visible",
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.w700,
                    //                   fontStyle: FontStyle.italic,
                    //                   fontSize: 14))
                    //         ],
                    //       )
                    //     : Row(
                    //         children: <Widget>[
                    //           Icon(Icons.verified_user,
                    //               size: 16, color: Colors.green),
                    //           Text(
                    //             "Private",
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.w700,
                    //                 fontStyle: FontStyle.italic,
                    //                 fontSize: 14),
                    //           )
                    //         ],
                    //       )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                //  child: Text('${widget.MemberData["Name"]}',
                child: Text("${widget.memberData["Name"]}",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 7.0),
                //  child: Text("Wing-" + '${widget.MemberData["Wing"]}',
                child: Text("Wing-" + '${widget.memberData["Wing"]}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //  Text('${widget.MemberData["ResidenceType"]}',
                        Text('${widget.memberData["ResidenceType"]}',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            )),
                        Text("Resident Type",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 9.0, left: 8.0, right: 8.0),
                    child: Container(
                      color: Colors.grey[300],
                      width: 1,
                      height: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Text('${widget.MemberData["FlatNo"]}',
                        Text('${widget.memberData["FlatData"]["flatNo"]}',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            )),
                        Text("Flat  Number",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ListTile(
                leading: Image.asset('assets/phone.png',
                    width: 22, height: 22, color: Colors.grey[500]),
                // title: widget.MemberData["IsPrivate"] == null
                //     ? Text('${widget.MemberData["ContactNo"]}')
                //     : Text("******" +
                //         '${widget.MemberData["ContactNo"]}'.substring(6, 10)),
                title: Text("${widget.memberData["ContactNo"]}"),
                subtitle: Text("Mobile No"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                ),
              ),
              ListTile(
                leading: Icon(Icons.business_center,
                    color: Colors.grey[500], size: 22),
                subtitle: Text("Business / Job"),
                title:
                    //  Text('${widget.MemberData["Designation"]}'.checkForNull()),
                    Text('${widget.memberData["Designation"]}'.checkForNull()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                ),
              ),
              ListTile(
                leading:
                    Icon(Icons.description, color: Colors.grey[500], size: 22),
                subtitle: Text("Business / Job Description"),
                //title: Text('${widget.MemberData["BusinessDescription"]}'
                title: Text('${widget.memberData["BusinessDescription"]}'.checkForNull()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_balance,
                  color: Colors.grey[500],
                  size: 22,
                ),
                title:
                    // Text('${widget.MemberData["CompanyName"]}'.checkForNull()),
                    Text('${widget.memberData["CompanyName"]}'.checkForNull()),
                subtitle: Text("Company Name"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                ),
              ),
              ListTile(
                leading: Image.asset('assets/Blood.png',
                    width: 22, height: 22, color: Colors.grey[500]),
                title:
                    //   Text('${widget.MemberData["BloodGroup"]}'.checkForNull()),
                    Text('${widget.memberData["BloodGroup"]}'.checkForNull()),
                subtitle: Text("Blood Group"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                ),
              ),
              ListTile(
                leading: Image.asset('assets/gender.png',
                    //leading: Image.asset('asset/user.png',
                    width: 22,
                    height: 22,
                    color: Colors.grey[500]),
                title: Text('${widget.memberData["Gender"]}'.checkForNull()),
                subtitle: Text("Gender"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                ),
              ),
              ListTile(
                leading:
                    Icon(Icons.location_on, size: 22, color: Colors.grey[500]),
                //title: Text('${widget.MemberData["Address"]}'.checkForNull()),
                title: Text('${widget.memberData["Address"]}'.checkForNull()),
                subtitle: Text("Address"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                ),
              ),
              ListTile(
                // leading: Image.asset('images/Cake.png',
                //     width: 22, height: 22, color: Colors.grey[500]),
                leading: Icon(Icons.cake),
                 title: Text('${widget.memberData["DOB"]}' != "null" &&
                         '${widget.memberData["DOB"]}' != null
                     ? "${(widget.memberData["DOB"])}"
                     : ""),
                //title: Text("13-09-2000"),
                subtitle: Text("DOB"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
