import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';

class DashboardComponent extends StatefulWidget {
  var index;
  DashboardComponent({this.index});
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
                  Image.asset(
                    'assets/user.png',
                    height: 30,
                    width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Sharma Rinki',
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, bottom: 20, left: 15, right: 15),
                      child: Text("Share"),
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
                          top: 5.0, bottom: 20, left: 15, right: 15),
                      child: Text("Call"),
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
                        Navigator.pushNamed(context, '/PreviewScreen');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 20, left: 15, right: 35),
                        child: Text("Preview"),
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
