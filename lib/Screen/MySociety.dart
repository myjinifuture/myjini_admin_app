import 'package:flutter/material.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';

class MySociety extends StatefulWidget {
  @override
  _MySocietyState createState() => _MySocietyState();
}

class _MySocietyState extends State<MySociety> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("My Society"),
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
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/CreateSociety');
                },
                leading: Image.asset("assets/society.png",
                    width: 35,
                    height: 35,
                    color: appPrimaryMaterialColor,
                    fit: BoxFit.fill),
                title: Expanded(
                  child: Text(
                    "Society Name",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Image.asset("assets/society.png",
                    width: 35,
                    height: 35,
                    color: appPrimaryMaterialColor,
                    fit: BoxFit.fill),
                title: Expanded(
                  child: Text(
                    "No. of Wings",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: appPrimaryMaterialColor,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/DirectoryScreen');
                },
                leading: Image.asset("assets/directory.png",
                    width: 35,
                    height: 35,
                    color: appPrimaryMaterialColor,
                    fit: BoxFit.fill),
                title: Expanded(
                  child: Text(
                    "No. of Members",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: appPrimaryMaterialColor,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Image.asset("assets/society.png",
                    width: 35,
                    height: 35,
                    color: appPrimaryMaterialColor,
                    fit: BoxFit.fill),
                title: Expanded(
                  child: Text(
                    "Vehicles",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    "0",
                    style:
                        TextStyle(color: appPrimaryMaterialColor, fontSize: 17),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Image.asset("assets/activemember.png",
                    width: 35,
                    height: 35,
                    color: appPrimaryMaterialColor,
                    fit: BoxFit.fill),
                title: Expanded(
                  child: Text(
                    "Active Members",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    "0",
                    style:
                        TextStyle(color: appPrimaryMaterialColor, fontSize: 17),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Image.asset("assets/inactivemember.png",
                    width: 35,
                    height: 35,
                    color: appPrimaryMaterialColor,
                    fit: BoxFit.fill),
                title: Expanded(
                  child: Text(
                    "Inactive Members",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    "0",
                    style:
                        TextStyle(color: appPrimaryMaterialColor, fontSize: 17),
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        )),
      ),
    );
  }
}
