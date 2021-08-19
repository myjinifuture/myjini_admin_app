import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Services.dart';
import 'package:my_jini_adminapp/Screen/DirectoryScreen.dart';
import 'package:my_jini_adminapp/Screen/societyDownload.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviewScreen extends StatefulWidget {
  String SocityId,Societyname;
  PreviewScreen({this.SocityId,this.Societyname});
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocalData();
  }

  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text("Preview");
  TextEditingController _controller = TextEditingController();
  List searchMemberData = new List();
  List memberData = [];
  bool _isSearching = false;
  List wingsList = [];
  List wingsNameList = [];
  String mobileNo,societyCode;

  var _AdminMenuList = [
    {
      "image": "assets/society.png",
      "count": "0",
      "title": "My Society",
      "screen": "MySociety"
    },
    {
      "image": "assets/announcement.png",
      "count": "0",
      "title": "Notice",
      "screen": "AllNotice"
    },
    {
      "image": "assets/document.png",
      "count": "0",
      "title": "Document",
      "screen": "Document"
    },
    {
      "image": "assets/directory.png",
      "count": "0",
      "title": "Directory",
      "screen": "DirectoryMember"
    },
    {
      "image": "assets/visitor.png",
      "count": "0",
      "title": "Visitors",
      "screen": "Visitor"
    },
    {
      "image": "assets/staff.png",
      "count": "0",
      "title": "Staffs",
      "screen": "Staff"
    },
    {
      "image": "assets/complain.png",
      "count": "0",
      "title": "Complaints",
      "screen": "AllComplaints"
    },
    {
      "image": "assets/rules.png",
      "count": "0",
      "title": "Rules & Regulations",
      "screen": "RulesAndRegulations"
    },
    {
      "image": "assets/event.png",
      "count": "0",
      "title": "Events",
      "screen": "EventsAdmin"
    },
    {
      "image": "assets/gallery.png",
      "count": "0",
      "title": "Gallary",
      "screen": "Gallary"
    },
    {
      "image": "assets/incomes.png",
      "count": "0",
      "title": "Income",
      "screen": "Income"
    },
    {
      "image": "assets/expenses.png",
      "count": "0",
      "title": "Expense",
      "screen": "Expense"
    },
    {
      "image": "assets/balance-sheet.png",
      "count": "0",
      "title": "Balance Sheet",
      "screen": "BalanceSheet"
    },
    {
      "image": "assets/polling.png",
      "count": "0",
      "title": "Polling",
      "screen": "AllPolling"
    },
    {
      "image": "assets/amcs.png",
      "count": "0",
      "title": "AMCs",
      "screen": "amcList"
    },
    {
      "image": "assets/amenities.png",
      "count": "0",
      "title": "Amenities",
      "screen": "getAmenitiesScreen"
    },
      {
      "image": "assets/download.png",
      "count": "0",
      "title": "Society Download",
      "screen": "societyDownload"
    },
    /*{
      "image": "assets/Vendors.png",
      "count": "0",
      "title": "Service Requests",
      "screen": "MyServiceRequests"
    },*/
    /*  {
      "image": "assets/Vendors.png",
      "count": "0",
      "title": "Advertisement",
      "screen": "AdvertisementList"
    }*/
  ];
  bool isLoading = false;

  setDashboardData(data) {
    for (int i = 0; i < _AdminMenuList.length; i++) {
      if (_AdminMenuList[i]["title"] == "Notice")
        setState(() {
          _AdminMenuList[i]["count"] = data["NoticeBoard"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Document")
        setState(() {
          _AdminMenuList[i]["count"] = data["Docs"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Directory")
        setState(() {
          _AdminMenuList[i]["count"] = data["Members"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Visitors")
        setState(() {
          _AdminMenuList[i]["count"] = data["Visitor"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Staffs")
        setState(() {
          _AdminMenuList[i]["count"] = data["TotalStaff"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Edit Wing Details")
        setState(() {
          _AdminMenuList[i]["count"] = data["Wing"].toString();
        });
      if (_AdminMenuList[i]["title"] == "All Vendors")
        setState(() {
          _AdminMenuList[i]["count"] = data["Vendor"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Emergency Numbers")
        setState(() {
          _AdminMenuList[i]["count"] =
              data["SocietyEmergencyContact"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Amenities")
        setState(() {
          _AdminMenuList[i]["count"] = data["Amenities"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Events")
        setState(() {
          _AdminMenuList[i]["count"] = data["Event"].toString();
        });

      //
      if (_AdminMenuList[i]["title"] == "Complaints")
        setState(() {
          _AdminMenuList[i]["count"] = data["Complain"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Rules & Regulations")
        setState(() {
          _AdminMenuList[i]["count"] = data["Rule"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Gallery")
        setState(() {
          _AdminMenuList[i]["count"] = data["Gallery"].toString();
        });

      if (_AdminMenuList[i]["title"] == "Pending Approvals")
        setState(() {
          _AdminMenuList[i]["count"] = data["PendingApprovalMember"].toString();
        });
      if (_AdminMenuList[i]["title"] == "Income") {
        if (data["Income"].toString() != "null" &&
            data["Income"].toString() != "") {
          setState(() {
            _AdminMenuList[i]["count"] = double.parse(data["Income"].toString())
                .toStringAsFixed(2)
                .toString();
          });
        }
      }
      if (_AdminMenuList[i]["title"] == "Expense") {
        if (data["ExpenseTotal"].toString() != "null" &&
            data["ExpenseTotal"].toString() != "") {
          setState(() {
            _AdminMenuList[i]["count"] =
                double.parse(data[0]["ExpenseTotal"].toString())
                    .toStringAsFixed(2)
                    .toString();
          });
        }
      }
      if (_AdminMenuList[i]["title"] == "Society Download")
        setState(() {
          _AdminMenuList[i]["count"] = data["install"].toString();
        });

      if (_AdminMenuList[i]["title"] == "Balance Sheet")
        setState(() {
          _AdminMenuList[i]["count"] =
              double.parse(data["BalanceSheet"].toString())
                  .toStringAsFixed(2)
                  .toString();
        });
      if (_AdminMenuList[i]["title"] == "Polling")
        setState(() {
          _AdminMenuList[i]["count"] = data["Polling"].toString();
        });
    }
  }

  getMobileNoAndSocietyCode() async {
    try {
      print("getMobileNoAndSocietyCode data called");
      final result = await InternetAddress.lookup('google.com');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var memberID = prefs.getString(Session.Member_Id);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = {"memberId": memberID, "societyId": widget.SocityId};
        Services.responseHandler(
            apiName: "member/getMemberInformation", body: body)
            .then((data) async {
          if (data.Data.length > 0) {
            mobileNo = data.Data[0]["ContactNo"];
            societyCode = data.Data[0]["SocietyData"][0]["societyCode"];
          }
        }, onError: (e) {
          showMsg("$e");
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("Something Went Wrong");
    }
  }

  String societyId, memberId,wingId;

  _getLocalData() async {
    print("local data called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     // memberType = prefs.getString(cnst.Session.Role);
      societyId = prefs.getString(Session.SocietyId);
      memberId = prefs.getString(Session.Member_Id);
      wingId = prefs.getString(Session.WingId);
    });
    _getDashboardCount(
        widget.SocityId,wingId); // ask monil to make dashboardcount api service 16 - number
  }

  getWingsId() async {
    try {
      print("getWingsId called");
      final result = await InternetAddress.lookup('google.com');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = {"societyId": widget.SocityId};
        Services.responseHandler(
            apiName: "admin/getAllWingOfSociety", body: body)
            .then((data) async {
          if (data.Data != null) {
            setState(() {
              // wingsList = data.Data;
              for (int i = 0; i < data.Data.length; i++) {
                if (data.Data[i]["totalFloor"].toString() != "0") {
                  wingsList.add(data.Data[i]);
                }
              }
              for (int i = 0; i < wingsList.length; i++) {
                wingsNameList.add({
                  "Name" : wingsList[i]["wingName"],
                  "Id" : wingsList[i]["_id"],
                });
              }
            });
            getMobileNoAndSocietyCode();
          }
        }, onError: (e) {
          setState(() {
            showMsg("$e");
          });
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("Something Went Wrong");
    }
  }

  _getDashboardCount(String societyId,String wingId) async {
    try {
      print("dashoard called");
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var data = {"societyId": societyId,
          "wingId" : wingId
        };
        Services.responseHandler(apiName: "admin/getDashboardCount_v3", body: data)
            .then((data) async {
          if (data.Data != null && data.Data.length > 0) {
            setDashboardData(data.Data);
            setState(() {
              isLoading = false;
            });
            getWingsId();
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

  showMsg(String msg, {String title = 'MYJINI ADMIN'}) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appBarTitle,
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
        actions: <Widget>[
          new IconButton(
            icon: icon,
            onPressed: () {
              if (this.icon.icon == Icons.search) {
                this.icon = new Icon(
                  Icons.close,
                  color: Colors.white,
                );
                this.appBarTitle = new TextField(
                  controller: _controller,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)),
                  onChanged: searchOperation,
                );
                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            },
          ),
        ],
      ),
      body: Container(
          color: Colors.grey[200],
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: /*societyList.length > 0 ?
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 180),
                  child: Lottie.asset(
                      "assets/json/splash_loader.json",
                      width: 100,
                      height: 100)),
            )
                :*/AnimationLimiter(
            child: GridView.builder(
                itemCount: _AdminMenuList.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 4.2),
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: 2,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            if(_AdminMenuList[index]["screen"] == "DirectoryMember")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (conetxt)=>DirectoryScreen(SocietyId: widget.SocityId,)));
                              }else if(_AdminMenuList[index]["screen"] == "societyDownload"){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>societyDownload(societyId: widget.SocityId,societyName: widget.Societyname,)));
                            }
                            else{
                              Navigator.pushNamed(
                                  context, "/${_AdminMenuList[index]["screen"]}");
                            }
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(6),
                              child: Row(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(left: 7)),
                                  Image.asset(
                                      "${_AdminMenuList[index]["image"]}",
                                      width: 37,
                                      height: 37,
                                      color: appPrimaryMaterialColor,
                                      fit: BoxFit.fill),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            "${_AdminMenuList[index]["count"]}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600)),
                                        Expanded(
                                          child: Text(
                                            "${_AdminMenuList[index]["title"]}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[600]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      setState(() {});
      this.appBarTitle = Text("My JINI");
      _isSearching = false;
      searchMemberData.clear();
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchMemberData.clear();
    if (_isSearching != null) {
      if (searchText != "") {
        for (int i = 0; i < memberData.length; i++) {
          String name = memberData[i]["Name"];
          String flat = memberData[i]["FlatNo"].toString();
          if (name.toLowerCase().contains(searchText.toLowerCase()) ||
              flat.toLowerCase().contains(searchText.toLowerCase())) {
            searchMemberData.add(memberData[i]);
          }
        }
      } else
        searchMemberData.clear();
    }
    setState(() {});
  }
}
