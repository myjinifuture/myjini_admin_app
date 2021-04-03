import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jini_adminapp/Common/Classlist.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Services.dart';
import 'package:my_jini_adminapp/Screen/SetupWings.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CreateSociety extends StatefulWidget {
  @override
  _CreateSocietyState createState() => _CreateSocietyState();
}

class _CreateSocietyState extends State<CreateSociety> {
  ProgressDialog pr;
  bool isLoading = false;
  String _stateDropdownError, _cityDropdownError;
  bool stateLoading = false;
  bool cityLoading = false;

  List<stateClass> stateClassList = [];
  stateClass _stateClass;

  List<cityClass> cityClassList = [];
  cityClass _cityClass;

  String Price_dropdownValue = 'Select';
  TextEditingController txtname = new TextEditingController();
  TextEditingController txtmobile = new TextEditingController();
  TextEditingController txtwings = new TextEditingController();

  @override
  void initState() {
    super.initState();
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
        message: "Please Wait..",
        borderRadius: 10.0,
        progressWidget: Container(
          padding: EdgeInsets.all(15),
          child: CircularProgressIndicator(
              //backgroundColor: cnst.appPrimaryMaterialColor,
              ),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w600));
    getState();
  }

  getState() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          stateLoading = true;
        });
        Future res = Services.GetState();
        res.then((data) async {
          setState(() {
            stateLoading = false;
          });
          if (data != null && data.length > 0) {
            setState(() {
              stateClassList = data;
            });
          }
        }, onError: (e) {
          showMsg("$e");
          setState(() {
            stateLoading = false;
          });
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("Something Went Wrong");
      setState(() {
        stateLoading = false;
      });
    }
  }

  getCity(String id) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          cityLoading = true;
        });
        Future res = Services.GetCity(id);
        res.then((data) async {
          setState(() {
            cityLoading = false;
          });
          if (data != null && data.length > 0) {
            setState(() {
              cityClassList = data;
            });
          }
        }, onError: (e) {
          showMsg("$e");
          setState(() {
            cityLoading = false;
          });
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("Something Went Wrong");
      setState(() {
        cityLoading = false;
      });
    }
  }

  showMsg(String msg, {String title = 'My Jini'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        title: Text("Create Society"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, right: 5.0, left: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("Type",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                  // border: Border.all(
                  //     color: Colors.black,
                  //     style: BorderStyle.solid,
                  //     width: 0.6),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: Price_dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        Price_dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Select',
                      'Building',
                      'Society',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("Society",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200],
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value.trim() == "") {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    controller: txtname,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                        // labelText: "Society Name",
                        hintText: 'Enter Society Name',
                        hintStyle: TextStyle(fontSize: 13)),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("Mobile",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200],
                  ),
                  height: 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value.trim() == "" || value.length < 10) {
                        return 'Please Enter 10 Digit Mobile Number';
                      }
                      return null;
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: txtmobile,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        counterText: "",
                        fillColor: Colors.grey[200],
                        contentPadding:
                            EdgeInsets.only(top: 5, left: 10, bottom: 5),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide.none),
                        hintText: 'Enter Mobile No',
                        // labelText: "Mobile",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("Total Wings",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200],
                  ),
                  height: 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value.trim() == "") {
                        return 'Enter Total Wings';
                      }
                      return null;
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: txtwings,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        counterText: "",
                        fillColor: Colors.grey[200],
                        contentPadding:
                            EdgeInsets.only(top: 5, left: 10, bottom: 5),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide.none),
                        hintText: 'Enter Total No of Wings',
                        // labelText: "Wings",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("State",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<stateClass>(
                  isExpanded: true,
                  hint: stateClassList.length > 0
                      ? Text(
                          'Select State',
                          style: TextStyle(fontSize: 12),
                        )
                      : Text(
                          "State Not Found",
                          style: TextStyle(fontSize: 12),
                        ),
                  value: _stateClass,
                  onChanged: (newValue) {
                    setState(() {
                      _stateClass = newValue;
                      _cityClass = null;
                      _stateDropdownError = null;
                      cityClassList = [];
                    });
                    getCity(newValue.id.toString());
                  },
                  items: stateClassList.map((stateClass value) {
                    return DropdownMenuItem<stateClass>(
                      value: value,
                      child: Text(value.Name),
                    );
                  }).toList(),
                )),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("City",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<cityClass>(
                    isExpanded: true,
                    hint: cityClassList.length > 0
                        ? Text(
                            'Select City',
                            style: TextStyle(fontSize: 12),
                          )
                        : Text(
                            "City Not Found",
                            style: TextStyle(fontSize: 12),
                          ),
                    value: _cityClass,
                    onChanged: (newValue) {
                      setState(() {
                        _cityClass = newValue;
                        _cityDropdownError = null;
                      });
                    },
                    items: cityClassList.map((cityClass value) {
                      return DropdownMenuItem<cityClass>(
                        value: value,
                        child: Text(value.Name),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 8, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.deepPurple[900],
                            appPrimaryMaterialColor[900],
                            appPrimaryMaterialColor[700],
                          ]),
                      borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    //  color: appPrimaryMaterialColor[500],
                    textColor: Colors.white,
                    splashColor: Colors.white,
                    child: Text("Create",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    onPressed: () {
                      if (Price_dropdownValue == "Select" ||
                          txtname == "" ||
                          txtmobile == "" ||
                          txtwings == "" ||
                          _stateClass.Name == null ||
                          _cityClass.Name == null) {
                        Fluttertoast.showToast(
                          msg: "Fields can't be empty",
                          gravity: ToastGravity.BOTTOM,
                        );
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SetupWings(
                                  wingData: txtwings.text,
                                )));
                      }
                      //Navigator.pushNamed(context, '/SetupWings');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
