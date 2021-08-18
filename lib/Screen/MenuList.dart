import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/Services.dart';
import 'dart:io';
import 'package:my_jini_adminapp/Common/Constant.dart';

class MenuList extends StatefulWidget {
  var societyId;

  MenuList({this.societyId});

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  List getMenulist = [];

  showMsg(String msg, {String title = 'DashBoard'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: Text("OK"),
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
    MenuList();
  }

  selectedMenuList() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = {"societyId": widget.societyId};
        Services.responseHandler(apiName: "admin/addFunctionality", body: body)
            .then((data) async {
          if (data.Data != null) {
            print(data.Data);
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

  menuListUpdate(String id,bool vall,String Soc) async {
    try {

      final result = await InternetAddress.lookup('google.com');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var functionalityIds = prefs.getString(Session.FunctionalityId);
      var functionalityId = prefs.getString(Session.FunctionalityIds);

      print(functionalityId);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var data = {
            "functionalityId": Soc,
            "functionalityIds":id,
            "isDisplay": vall
        };
        print(data);
        Services.responseHandler(apiName: "admin/updateFunctionalityAdminIsDisplay", body: data)
            .then((data) async {
          if (data.IsSuccess == true) {
            setState(() {
              MenuList();

            });
              Fluttertoast.showToast(
                msg: "MenuList Updated Successfully",
                backgroundColor: Colors.green,
                gravity: ToastGravity.TOP,
                textColor: Colors.white,
              );
          } else {
            print("print success++++++++ end");
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
   List getlist=[];

  MenuList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Session.SocietyId,widget.societyId);
      print(prefs.getString(Session.SocietyId));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // pr.show();
        var body = {"societyId": widget.societyId};
        print("print +++++++++++++++++++++societyId");
        print(widget.societyId);
        print("print +++++++++++++++++++++End");
        print(body);
        Services.responseHandler(apiName: "admin/getFunctionality", body: body)
            .then((data) async {
          if (data.Data.length > 0) {
            setState(() {
              getMenulist = data.Data;
              getlist =  getMenulist[0]["functionality"];
            });
            print("getMenulist");
            print(getMenulist);
          } else {
            print("not find data....");
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

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu List",
            style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
      ),
      body: getMenulist.length > 0 ?
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey[500], width: 0.3))),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: getMenulist.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _getMenuItem(index);
                    },)
                /*AnimationLimiter(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: _getMenuItem,
                    itemCount: getMenulist.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height /6.5),
                    ),
                  ),
                ),*/
                /*Column(
                  children: getMenulist
                      .map((data) => Card(
                            elevation: 3,
                            child:CheckboxListTile(
                              onChanged: (value) {
                                setState(() {
                                  print("print ++++++++++++++++++++data");
                                  print(data["functionality"][2]["isDisplay"]);
                                  print("print ++++++++++++++++++++End");
                                  print(data["IconName"]);
                                });
                              },
                              value: data["functionality"][0]["isDisplay"],
                              secondary: Image.asset("assets/images/directory.png"),
                              title: Text("${data["functionality"][0]["name"]}"),
                            ),
                          ))
                      .toList(),
                ),*/
              ],
            ),
          ),
        ),
      ) : Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
    );
  }

  _getMenuItem(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(children: getlist
            .map((data) => Card(
          elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CheckboxListTile(
                  onChanged: (value) async {
                    bool divyan=data["isDisplay"];
                    bool values;
                    if(divyan==true){
                      setState(() {
                        values=false;
                      });
                    }else{
                      setState(() {
                        values=true;
                      });
                    }
                    menuListUpdate(data["_id"],values,getMenulist[index]["_id"]);

                 //     SharedPreferences prefs = await SharedPreferences.getInstance();
                   //   prefs.setString(Session.FunctionalityId,getMenulist[index]["_id"]);
                    //  prefs.setString(Session.FunctionalityIds,getlist[index]["_id"]);
                    // var functionalityIds =  prefs.getString(Session.FunctionalityIds);
                    // if(functionalityIds == data["_id"])
                      // {

                     //  }
                  },
                  value: data["isDisplay"],
                  secondary: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                      child: Image.network("https://myjini2.herokuapp.com/"+data["image"],height: 30,width: 30,)),
                  title: Text("${data["name"]}"),
                ),
              ),
            ))
            .toList(),
          /*CheckboxListTile(
            onChanged: (value) {
              setState(() {
                print(getMenulist.length);
              });
            },
            value: getMenulist[index]["functionality"][0]["isDisplay"],
            secondary: Image.asset("assets/images/directory.png"),
            title: Text("${getMenulist[index]["functionality"][0]["name"]}"),
          )*/
        )
        /*Image.asset(
          "assets/images/" + _allMenuList[index].Icon,
          width: 30,
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            _allMenuList[index].IconLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11,
                color: Colors.black,
                fontFamily: "OpenSans"),
          ),
        ),*/
      ],
    );
  }
}
