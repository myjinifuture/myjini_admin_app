import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Screen/PreviewScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Screen/MenuList.dart';

class DashboardComponent extends StatefulWidget {
  var index;
  var societyData;

  DashboardComponent({
    this.index,
    this.societyData,
  });

  @override
  _DashboardComponentState createState() => _DashboardComponentState();
}

class _DashboardComponentState extends State<DashboardComponent> {

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: widget.index,
      duration: const Duration(milliseconds: 375),
      columnCount: 1,
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: Card(
            child: ExpansionTile(
              title: Row(
                children: [
                  // if("${widget.societyData["Name"]}"==null){
                  //
                  // },
                  Image.asset(
                    'assets/building.png',
                    height: 30,
                    width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("${widget.societyData["Name"]}".toUpperCase()),
                  ),
                ],
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 20, left: 15, right: 15),
                      // child: Text("Share"),
                      child: Icon(
                        Icons.share_outlined,
                        color: Colors.grey,
                        // size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 20,
                      ),
                      child: Container(
                        height: 25,
                        color: Colors.grey[400],
                        width: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, bottom: 20, left: 10, right: 10),
                      child: GestureDetector(
                        child: Container(
                          child: Icon(Icons.call,color: Colors.black87,),
                          // Text("Call"),
                        ),
                        onTap: () {
                          setState(() {
                            var url =
                                "tel:${widget.societyData["ContactMobile"]}";
                            if (launch(url) != null) {
                              launch(url);
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Something went Wrong');
                            }
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 20,
                      ),
                      child: Container(
                        height: 25,
                        color: Colors.grey[400],
                        width: 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PreviewScreen(SocityId:widget.societyData["_id"],Societyname: widget.societyData["Name"],)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 20, left: 10, right: 10),
                        child: Icon(Icons.remove_red_eye,color: Color.fromRGBO(114, 34, 169, .7),),
                        // Text("Preview"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 20,
                      ),
                      child: Container(
                        height: 25,
                        color: Colors.grey[400],
                        width: 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuList(societyId: widget.societyData["_id"],)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 20, left: 15,right: 15),
                        // child: Text("Share"),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.menu_open,
                            color: Colors.purple,
                            // size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
