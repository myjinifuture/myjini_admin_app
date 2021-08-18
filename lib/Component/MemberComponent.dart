import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Constant.dart' as cnst;
import 'package:my_jini_adminapp/Common/ExtensionMethods.dart';
import 'package:my_jini_adminapp/Common/Services.dart';
import 'package:my_jini_adminapp/Screen/MemberProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberComponent extends StatefulWidget {
  var MemberData, search, wingName;
  Function onAdminUpdate;

  int index;

  String SocietyId;
  //
   MemberComponent({this.SocietyId,
     this.MemberData,
     this.index,
     this.onAdminUpdate,
     this.search,
     this.wingName,});

  @override
  _MemberComponentState createState() => _MemberComponentState();
}

_openWhatsapp(mobile) {
  String whatsAppLink = cnst.whatsAppLink;
  String urlwithmobile = whatsAppLink.replaceAll("#mobile", "91$mobile");
  String urlwithmsg = urlwithmobile.replaceAll("#msg", "");
  launch(urlwithmsg);
}

class _MemberComponentState extends State<MemberComponent> {
  shareFile(String ImgUrl) async {
    ImgUrl = ImgUrl.replaceAll(" ", "%20");
    if (ImgUrl.toString() != "null" && ImgUrl.toString() != "") {
      var request = await HttpClient()
          .getUrl(Uri.parse("http://smartsociety.itfuturz.com/${ImgUrl}"));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.files('Share Profile', {'eyes.vcf': bytes}, 'image/pdf');
    }
  }

  bool isLoading = false;
  String Data = "";

  // GetVcard() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //
  //       Services.GetVcardofMember(
  //               widget.MemberData["MemberData"]["Id"].toString())
  //           .then((data) async {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         if (data != null) {
  //           setState(() {
  //             Data = data;
  //           });
  //           shareFile('${Data}');
  //         } else {
  //           setState(() {
  //             isLoading = false;
  //           });
  //         }
  //       }, onError: (e) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         showHHMsg("Try Again.", "");
  //       });
  //     }
  //   } on SocketException catch (_) {
  //     showHHMsg("No Internet Connection.", "");
  //   }
  // }
  removeAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var memberID = prefs.getString(Session.Member_Id);
    var societyID = prefs.getString(Session.SocietyId);
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      var data ={
        "societyId":widget.SocietyId,
        "memberId":widget.MemberData["_id"],
        "isVerify": false
      };
      print(data);
      Services.responseHandler(apiName: "admin/memberApproval", body: data)
          .then((data) async {
        if (data.Data != null && data.Data.toString() == "0") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Navigator.pushNamed(context,'/Dashboard');
        } else {
          // setState(() {});
        }
      },onError: (e) {
        showMsg("Something Went Wrong Please Try Again");
        setState(() {});
      });
    }
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Admin"),
          content: new Text("Are You Sure You Want To delete this Member...?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
                ;
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                removeAccount();
              },
            ),
          ],
        );
      },
    );
  }


  showMsg(String msg, {String title = 'MYJINI'}) {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //   print(widget.MemberData["MemberData"]["IsPrivate"]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: ExpansionTile(
          title: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 1.0, top: 1, bottom: 1),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                            image:
                                // widget.MemberData["MemberData"]["Image"] ==
                                //             null ||
                                //         widget.MemberData["MemberData"]["Image"] ==
                                //             ""
                                //     ?
                                AssetImage("assets/user.png"),
                            // : NetworkImage(Image_Url +
                            //     '${widget.MemberData["MemberData"]["Image"]}'),
                            fit: BoxFit.cover),
                        borderRadius:
                            BorderRadius.all(new Radius.circular(75.0)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //  Text("${widget.MemberData["MemberData"]["Name"]}",
                          Text("${widget.MemberData["Name"]}".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple)),
                          // widget.MemberData["MemberData"]["IsPrivate"] ==
                          //             false ||
                          //         widget.MemberData["MemberData"]
                          //                 ["IsPrivate"] ==
                          //             null
                          //     ?
                          // Text(
                          //         '${widget.MemberData["MemberData"]["ContactNo"]}')
                          Text("${widget.MemberData["ContactNo"]}",style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey
                          ),),
                          // : Text(
                          //     '${widget.MemberData["MemberData"]["ContactNo"]}'
                          //         .replaceRange(0, 6, "******")),
                          Text(
                            // "Flat No: ${widget.MemberData["MemberData"]["FlatNo"]}",
                            "Flat No: ${widget.MemberData["FlatData"]["flatNo"]}"
                              .toUpperCase(),
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          ),
                          /*Text(
                            //"${widget.MemberData["MemberData"]["ResidenceType"]}"
                             "${widget.MemberData["MemberData"]["ResidenceType"]}",
                            style: TextStyle(
                                color: appPrimaryMaterialColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          )*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(Radius.circular(3.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.message, color: Colors.black54),
                    // Image.asset("images/whatsapp.png",
                    //     width: 30, height: 30),
                    onPressed: () {
                      // widget.MemberData["MemberData"]["IsPrivate"] == true
                      //     ? Fluttertoast.showToast(
                      //         msg: "Profile is Private",
                      //         backgroundColor: Colors.red,
                      //         textColor: Colors.white)
                      //     : _openWhatsapp(
                      //         widget.MemberData["MemberData"]["ContactNo"]);
                    },
                  ),
                  IconButton(
                      icon: Icon(Icons.call, color: Colors.black54),
                      // Image.asset('images/call.png',
                      //     width: 20, height: 20, color: Colors.green),
                      onPressed: () {
                        // widget.MemberData["MemberData"]["IsPrivate"] == true
                        //     ? Fluttertoast.showToast(
                        //         msg: "Profile is Private",
                        //         backgroundColor: Colors.red,
                        //         textColor: Colors.white)
                        //     : launch(
                        //         "tel:${widget.MemberData["MemberData"]["ContactNo"]}");
                      }),
                  IconButton(
                      icon: Icon(Icons.remove_red_eye, color: Colors.black54),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemberProfile(
                                memberData: widget.MemberData,
                                isContactNumberPrivate: widget
                                    .MemberData["Private"]
                                ["ContactNo"]
                                    .toString(),
                                // widget.MemberData["MemberData"],
                                ),
                          ),
                        );
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        // widget.MemberData["MemberData"]["IsPrivate"] == true
                        //     ? Fluttertoast.showToast(
                        //         msg: "Profile is Private",
                        //         backgroundColor: Colors.red,
                        //         textColor: Colors.white)
                        //     : GetVcard();
                      }),
                  IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        _showConfirmDialog();
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
