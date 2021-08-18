import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_jini_adminapp/Common/Constant.dart'as cnst;
import 'package:my_jini_adminapp/Common/Services.dart';
import 'package:my_jini_adminapp/Component/MemberComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_jini_adminapp/Common/ExtensionMethods.dart';

class DirectoryScreen extends StatefulWidget {

  String SocietyId;
  DirectoryScreen({this.SocietyId});
  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  List MemberData = new List();
  List FilterMemberData = new List();
  bool isLoading = false, isSelected = false;
  String SocietyId, selectedWing = "";

  TextEditingController _controller = TextEditingController();

  Widget appBarTitle = new Text(
    "Directory",
  );

  List searchMemberData = new List();
  List WingData = List();
  bool _isSearching = false,
      isfirst = false,
      isFilter = false,
      isMemberLoading = false;

  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  void initState() {
    getLocaldata();
    //GetWingList();
    //_getLocaldata();
    //_getDirectoryListing();
  }

  /*_getLocaldata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SocietyId = prefs.getString(cnst.Session.SocietyId);
  }

  GetWingList() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.GetWingData(SocietyId).then((data) async {
          setState(() {
            isLoading = false;
          });
          if (data != null && data.length > 0) {
            setState(() {
              WingData = data;
              selectedWing = data[0]["Id"].toString();
            });
            GetMemberData(data[0]["Id"].toString());
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
  }*/

  List memberData = [];
  bool dataFound = false;

  getLocaldata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      SocietyId = prefs.getString(cnst.Session.SocietyId);
    });
    _getWing(widget.SocietyId);
  }

  List _wingList = [];

  _getWing(String societyId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var data = {"societyId": widget.SocietyId};
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
            _getDirectoryListing(selectedWing);
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

  _getDirectoryListing(String seletecedWing) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var societyId = prefs.getString(cnst.Session.SocietyId);
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var data = {
          "societyId": widget.SocietyId
        };
        //setState(() {
        //   isLoading = true;
        // });
        Services.responseHandler(apiName: "admin/directoryListing", body: data)
            .then((data) async {
          memberData.clear();
          if (data.Data != null && data.Data.length > 0) {
            setState(() {
              dataFound = true;
              // memberData = data.Data;
              for (int i = 0; i < data.Data.length; i++) {
                if (data.Data[i]["society"]["wingId"] == selectedWing) {
                  memberData.add(data.Data[i]);
                }
              }
              // isLoading = false;
            });
            print("memberData");
            print(memberData);
          } else {
            // setState(() {
            //   isLoading = false;
            // });
          }
        }, onError: (e) {
          showHHMsg("Something Went Wrong Please Try Again", "");
          setState(() {
            isLoading = false;
          });
        });
      }
    } on SocketException catch (_) {
      showHHMsg("No Internet Connection.", "");
    }
  }

  /*GetMemberData(selectedWing) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isMemberLoading = true;
        });
        Services.GetMemberByWing(SocietyId, selectedWing).then((data) async {
          setState(() {
            isMemberLoading = false;
          });
          if (data != null && data.length > 0) {
            setState(() {
              MemberData = data;
            });
          } else {
            setState(() {
              MemberData = data;
            });
          }
        }, onError: (e) {
          setState(() {
            isMemberLoading = false;
          });
          showHHMsg("Try Again.", "");
        });
      }
    } on SocketException catch (_) {
      showHHMsg("No Internet Connection.", "");
    }
  }*/

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body:memberData.length > 0
          ?  Column(
              children: <Widget>[
                Container(
                  color: cnst.appPrimaryMaterialColor,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  padding: EdgeInsets.only(left: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Members : ${memberData.length}",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                /*FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Filter",
                        style: TextStyle(
                            fontSize: 16,
                            color: cnst.appPrimaryMaterialColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.filter_list,
                        size: 19,
                        color: cnst.appPrimaryMaterialColor,
                      ),
                    ],
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return showFilterDailog(
                            onSelect: (gender, isOwned, isOwner, isRented) {
                              String owned = isOwned ? "Owned" : "";
                              String owner = isOwner ? "Owner" : "";
                              String rented = isRented ? "Rented" : "";
                              setState(() {
                                isFilter = true;
                                FilterMemberData.clear();
                              });
                              for (int i = 0; i < MemberData.length; i++) {
                                if (MemberData[i]["MemberData"]["Gender"] ==
                                    gender ||
                                    MemberData[i]["MemberData"]
                                    ["ResidenceType"] ==
                                        owned ||
                                    MemberData[i]["MemberData"]
                                    ["ResidenceType"] ==
                                        owner ||
                                    MemberData[i]["MemberData"]
                                    ["ResidenceType"] ==
                                        rented) {
                                  FilterMemberData.add(MemberData[i]);
                                }
                              }
                              setState(() {});
                            },
                          );
                        });
                  },
                ).alignAtEnd(),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < _wingList.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          if (selectedWing !=
                              _wingList[i]["_id"].toString()) {
                            setState(() {
                              selectedWing = _wingList[i]["_id"].toString();
                              _getDirectoryListing(selectedWing);
                            });
                            setState(() {
                              memberData = [];
                              //filterMemberData = [];
                              searchMemberData = [];
                              isFilter = false;
                              _isSearching = false;
                            });
                          }
                        },
                        child: Container(
                          width:
                          selectedWing == _wingList[i]["_id"].toString()
                              ? 60
                              : 45,
                          height:
                          selectedWing == _wingList[i]["_id"].toString()
                              ? 60
                              : 45,
                          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: selectedWing ==
                                  _wingList[i]["_id"].toString()
                                  ? cnst.appPrimaryMaterialColor
                                  : Colors.white,
                              border: Border.all(
                                  color: cnst.appPrimaryMaterialColor),
                              borderRadius:
                              BorderRadius.all(Radius.circular(4))),
                          alignment: Alignment.center,
                          child: Text(
                            "${_wingList[i]["wingName"]}",
                            style: TextStyle(
                                color: selectedWing ==
                                    _wingList[i]["_id"].toString()
                                    ? Colors.white
                                    : cnst.appPrimaryMaterialColor,
                                fontSize: 19),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                isMemberLoading
                    ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    : Expanded(
                  child: memberData.length > 0 && memberData != null
                      ? searchMemberData.length != 0
                      ? AnimationLimiter(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: memberData.length,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return MemberComponent(
                            SocietyId: widget.SocietyId,
                            MemberData: memberData[index],
                            index: index);
                      },
                    ),
                  )
                      : _isSearching && isfirst
                      ? AnimationLimiter(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: searchMemberData.length,
                      itemBuilder: (BuildContext context,
                          int index) {
                        return MemberComponent(
                            SocietyId: widget.SocietyId,
                            MemberData: memberData[index],
                            index: index);
                      },
                    ),
                  )
                      : AnimationLimiter(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: memberData.length,
                      itemBuilder: (BuildContext context,
                          int index) {
                        return MemberComponent(
                            SocietyId: widget.SocietyId,
                            MemberData: memberData[index],
                            index: index);
                      },
                    ),
                  )
                      : !dataFound
                      ? Container(
                    child: Center(),
                  )
                      : Center(
                    child: Text('No Data Found'),
                  ),
                ),


                /*Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MemberComponent(
                            // MemberData[index]
                            );
                      },
                    ),
                  ),
                ),*/

                // isMemberLoading
                //     ? Container(
                //         child: Center(
                //           child: CircularProgressIndicator(),
                //         ),
                //       )
                //     : Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.only(top: 1.0),
                //           child: Container(
                //             width: MediaQuery.of(context).size.width,
                //             child: isLoading
                //                 ? Container(
                //                     child: Center(
                //                       child: CircularProgressIndicator(),
                //                     ),
                //                   )
                //                 : isFilter
                //                     ? FilterMemberData.length > 0
                //                         ? ListView.builder(
                //                             itemCount: FilterMemberData.length,
                //                             shrinkWrap: true,
                //                             itemBuilder: (BuildContext context,
                //                                 int index) {
                //                               return MemberComponent(
                //                                   FilterMemberData[index]);
                //                             },
                //                           )
                //                         : Container(
                //                             child: Center(
                //                                 child: Text("No Member Found")),
                //                           )
                //                     : MemberData.length > 0 &&
                //                             MemberData != null
                //                         ? searchMemberData.length > 0
                //                             ? ListView.builder(
                //                                 itemCount:
                //                                     searchMemberData.length,
                //                                 shrinkWrap: true,
                //                                 itemBuilder:
                //                                     (BuildContext context,
                //                                         int index) {
                //                                   return MemberComponent(
                //                                       searchMemberData[index]);
                //                                 },
                //                               )
                //                             : _isSearching && isfirst
                //                                 ? ListView.builder(
                //                                     padding: EdgeInsets.all(0),
                //                                     itemCount:
                //                                         searchMemberData.length,
                //                                     itemBuilder:
                //                                         (BuildContext context,
                //                                             int index) {
                //                                       return MemberComponent(
                //                                           searchMemberData[
                //                                               index]);
                //                                     },
                //                                   )
                //                                 : ListView.builder(
                //                                     padding: EdgeInsets.all(0),
                //                                     itemCount:
                //                                         MemberData.length,
                //                                     itemBuilder:
                //                                         (BuildContext context,
                //                                             int index) {
                //                                       return MemberComponent(
                //                                           MemberData[index]);
                //                                     },
                //                                   )
                //                         : Container(
                //                             child: Center(
                //                                 child: Text("No Member Found")),
                //                           ),
                //           ),
                //         ),
                //       ),
              ],
            ):
            Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: appBarTitle,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.deepPurple[900],
              cnst.appPrimaryMaterialColor[700],
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
      this.appBarTitle = Text('Member Directory');
      _isSearching = false;
      isfirst = false;
      searchMemberData.clear();
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchMemberData.clear();
    if (_isSearching != null) {
      isfirst = true;
      for (int i = 0; i < MemberData.length; i++) {
        String name = MemberData[i]["MemberData"]["Name"];
        String flat = MemberData[i]["MemberData"]["FlatNo"].toString();
        String mobile = MemberData[i]["MemberData"]["ContactNo"].toString();
        String bloodGroup =
            MemberData[i]["MemberData"]["BloodGroup"].toString();
        String designation =
            MemberData[i]["MemberData"]["Designation"].toString();
        if (name.toLowerCase().contains(searchText.toLowerCase()) ||
            designation.toLowerCase().contains(searchText.toLowerCase()) ||
            mobile.toLowerCase().contains(searchText.toLowerCase()) ||
            bloodGroup.toLowerCase().contains(searchText.toLowerCase()) ||
            flat.toLowerCase().contains(searchText.toLowerCase())) {
          searchMemberData.add(MemberData[i]);
        }
      }
    }
    setState(() {});
  }
}

class showFilterDailog extends StatefulWidget {
  Function onSelect;

  showFilterDailog({this.onSelect});

  @override
  _showFilterDailogState createState() => _showFilterDailogState();
}

class _showFilterDailogState extends State<showFilterDailog> {
  String _gender;

  bool ownerSelect = false, rentedSelect = false, ownedSelect = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Filter Your Criteria"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Gender",
            style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Row(
              children: <Widget>[
                Radio(
                    value: 'Male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    }),
                Text("Male", style: TextStyle(fontSize: 13)),
                Radio(
                    value: 'Female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    }),
                Text("Female", style: TextStyle(fontSize: 13))
              ],
            ),
          ),
          Text(
            "Residential Type",
            style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                  activeColor: Colors.green,
                  value: ownedSelect,
                  onChanged: (bool value) {
                    setState(() {
                      ownedSelect = value;
                    });
                  }),
              Text(
                "Owned",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                  activeColor: Colors.green,
                  value: rentedSelect,
                  onChanged: (bool value) {
                    setState(() {
                      rentedSelect = value;
                    });
                  }),
              Text(
                "Rented",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                  activeColor: Colors.green,
                  value: ownerSelect,
                  onChanged: (bool value) {
                    setState(() {
                      ownerSelect = value;
                    });
                  }),
              Text(
                "Owner",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onSelect(_gender, ownedSelect, ownerSelect, rentedSelect);
          },
          child: Text("Done"),
        )
      ],
    );
  }
}
