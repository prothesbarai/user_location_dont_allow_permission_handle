import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:user_location_like_as_foodpanda/pages/home_page/home_page.dart';
import 'package:user_location_like_as_foodpanda/pages/location_control_pages/permission_check_intro_page.dart';

import '../location_control_pages/denied_forever_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Box ifStoreLocation;
  late Box permissionFlagBox;


  @override
  void initState() {
    super.initState();
    _checkFirstTimeInStoreLocation();
  }


  Future<void> _checkFirstTimeInStoreLocation() async{
    ifStoreLocation = Hive.box("FirstTimeCheckBox");
    permissionFlagBox = Hive.box("StorePermissionFlag");

    bool isFirstTime = ifStoreLocation.get("check_hive", defaultValue: true);
    String permissionFlag = permissionFlagBox.get("permission_flag", defaultValue: "denied");



    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (isFirstTime && permissionFlag == "denied") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PermissionCheckIntroPage()),);
      } else if (isFirstTime && permissionFlag == "denied_forever") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeniedForeverPage()),);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 150,
                  backgroundImage: AssetImage("assets/icon/icon.png"),
                )
              ],
            ),
          )
      ),


    );
  }
}
