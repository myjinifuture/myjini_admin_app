import 'package:flutter/material.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final List<String> _residentTypeList = ["Rented", "Owner", "Owned"];

  int selected_Index;
  bool isLoading = false, verify = false, valid = false;
  String SocietyId = "";
  bool _WingLoading = false;

  String Gender = "";

  TextEditingController CodeControler = new TextEditingController();
  TextEditingController txtname = new TextEditingController();
  TextEditingController txtmobile = new TextEditingController();
  TextEditingController txtFlatNo = new TextEditingController();

  final FocusNode _Name = FocusNode();
  final FocusNode _Mobile = FocusNode();
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "MY JINI",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 40, bottom: 8),
                  child: Text(
                    "Hello There.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    "Login or sign up to continue.",
                    style: TextStyle(
                      color: Colors.white,
                      //fontSize: 30,
                      //fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: Container(
                    //  height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   "Welcome to,\nMy Jini",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w500,
                            //       fontSize: 18,
                            //       color: appPrimaryMaterialColor),
                            // ),
                            // Center(
                            //   child: Image.asset('assets/applogo.png',
                            //       width: 90, height: 90),
                            // ),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/myginitext.png',
                                height: 90,
                                color: appPrimaryMaterialColor,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextFormField(
                                      focusNode: _Name,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context, _Name, _Mobile);
                                      },
                                      controller: txtname,
                                      decoration: InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          hintText: "Your Full Name",
                                          hintStyle: TextStyle(fontSize: 13)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    // controller: _MobileNumber,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        counterText: "",
                                        focusedBorder: OutlineInputBorder(
                                            // borderSide: BorderSide(
                                            //     color: appPrimaryMaterialColor[600]),
                                            borderSide: BorderSide.none
                                            //
                                            ),
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "Your Mobile Number",
                                        hintStyle: TextStyle(fontSize: 13)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                " Gender",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Row(
                                children: <Widget>[
                                  Radio(
                                      value: 'Male',
                                      groupValue: Gender,
                                      onChanged: (value) {
                                        setState(() {
                                          Gender = value;
                                          print(Gender);
                                        });
                                      }),
                                  Text("Male", style: TextStyle(fontSize: 13)),
                                  Radio(
                                      value: 'Female',
                                      groupValue: Gender,
                                      onChanged: (value) {
                                        setState(() {
                                          Gender = value;
                                          print(Gender);
                                        });
                                      }),
                                  Text("Female", style: TextStyle(fontSize: 13))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "  Select Residence Type *",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 10,
                                children: List.generate(
                                    _residentTypeList.length, (index) {
                                  return ChoiceChip(
                                    backgroundColor: Colors.grey[200],
                                    label: Text(_residentTypeList[index]),
                                    selected: selected_Index == index,
                                    onSelected: (selected) {
                                      if (selected) {
                                        setState(() {
                                          selected_Index = index;
                                          print(_residentTypeList[index]);
                                        });
                                      }
                                    },
                                  );
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 18.0, left: 8, right: 8, bottom: 25),
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
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  //color: appPrimaryMaterialColor[500],

                                  // textColor: Colors.white,
                                  // splashColor: Colors.white,
                                  child: Text("Login",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/Dashboard');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already Have an Account?",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/LoginScreen');
                          },
                          child: Text(" Sign In ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600)))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
