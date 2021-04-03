import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Screen/Dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _MobileNumber = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Container(
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
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 40, bottom: 8),
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
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20, right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.5,
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
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    controller: _MobileNumber,
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
                                              new BorderRadius.circular(
                                                  5.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "Your Mobile Number",
                                        hintStyle: TextStyle(fontSize: 13)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 18.0, left: 8, right: 8),
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
                                        borderRadius:
                                            BorderRadius.circular(5)),
                                    //color: appPrimaryMaterialColor[500],

                                    // textColor: Colors.white,
                                    // splashColor: Colors.white,
                                    child: Text("Login",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/Dashboard');
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
                          "Don't Have an Account?",
                          style:
                              TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/RegistrationScreen');
                            },
                            child: Text(" Sign Up ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)))
                      ],
                    ),
                  )
                ],
              ))

//         Padding(
//           padding: const EdgeInsets.only(top: 110.0),
//           child: Container(
//             child: Center(
//               child: Stack(
//                 children: <Widget>[
//                   Container(
//                     height: 200,
//                     width: MediaQuery.of(context).size.width,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Image.asset('assets/applogo.png',
//                                   width: 90, height: 90),
//                             ],
//                           ),
//                         ),
//                         Text("Welcome User",
//                             style: TextStyle(
//                                 fontSize: 23,
//                                 fontWeight: FontWeight.w600,
//                                 color: appPrimaryMaterialColor)),
//                         Text("Login with Mobile Number to Continue",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: appPrimaryMaterialColor)),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 180.0),
//                     child: Container(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
// //                  Text(
// //                    "Welcome to,\nMy Genie",
// //                    style: TextStyle(
// //                        fontWeight: FontWeight.w600,
// //                        fontSize: 24,
// //                        color: Color.fromRGBO(81, 92, 111, 1)),
// //                  ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 20.0, left: 10.0, right: 10.0),
//                             child: Column(
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 4.0, right: 8.0, top: 6.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       SizedBox(
//                                         height: 50,
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 8.0),
//                                           child: TextFormField(
//                                             textInputAction:
//                                                 TextInputAction.done,
//                                             controller: _MobileNumber,
//                                             maxLength: 10,
//                                             keyboardType: TextInputType.number,
//                                             decoration: InputDecoration(
//                                                 counterText: "",
//                                                 focusedBorder: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color:
//                                                             appPrimaryMaterialColor[
//                                                                 600])),
//                                                 border: new OutlineInputBorder(
//                                                   borderRadius:
//                                                       new BorderRadius.circular(
//                                                           5.0),
//                                                   borderSide: new BorderSide(),
//                                                 ),
//                                                 hintText: "Your Mobile Number",
//                                                 hintStyle:
//                                                     TextStyle(fontSize: 13)),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 18.0, left: 8, right: 8),
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width,
//                                     height: 45,
//                                     child: RaisedButton(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       color: appPrimaryMaterialColor[500],
//                                       textColor: Colors.white,
//                                       splashColor: Colors.white,
//                                       child: Text("Login",
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w600)),
//                                       onPressed: () {
//                                         Navigator.pushNamed(
//                                             context, '/Dashboard');
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(top: 35.0, bottom: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Text("Don't Have an Account?"),
//                                 GestureDetector(
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                           context, '/RegisterScreen');
//                                     },
//                                     child: Text("Register",
//                                         style: TextStyle(
//                                             color: appPrimaryMaterialColor[700],
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600)))
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
          ),
    )));
  }
}
