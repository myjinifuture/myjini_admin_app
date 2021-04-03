import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text("Preview");
  TextEditingController _controller = TextEditingController();
  List searchMemberData = new List();
  List memberData = [];
  bool _isSearching = false;
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
    /*  {
      "image": "assets/Vendors.png",
      "count": "0",
      "title": "Vendors",
      "screen": "Vendors"
    },
    {
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
          child: AnimationLimiter(
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
                            Navigator.pushNamed(
                                context, "/${_AdminMenuList[index]["screen"]}");
                          },
                          child: Card(
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
