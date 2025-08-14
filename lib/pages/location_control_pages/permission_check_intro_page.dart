import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:user_location_like_as_foodpanda/pages/home_page/home_page.dart';
import 'package:user_location_like_as_foodpanda/pages/location_control_pages/denied_forever_page.dart';
import 'package:user_location_like_as_foodpanda/pages/location_control_pages/map_select_page.dart';

class PermissionCheckIntroPage extends StatefulWidget {
  const PermissionCheckIntroPage({super.key});

  @override
  State<PermissionCheckIntroPage> createState() => _PermissionCheckIntroPageState();
}

class _PermissionCheckIntroPageState extends State<PermissionCheckIntroPage> {

  late Box ifStoreLocation;
  late Box permissionFlagBox;



  Future<void> fetchLocation() async{
    ifStoreLocation = Hive.box("FirstTimeCheckBox");
    permissionFlagBox = Hive.box("StorePermissionFlag");
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      await permissionFlagBox.put("permission_flag","denied");
    }

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      await ifStoreLocation.put("check_hive", false);
      await permissionFlagBox.put("permission_flag","granted");
      if (mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      }
    } else if (permission == LocationPermission.deniedForever) {
      if (mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeniedForeverPage(),));
      }
      await permissionFlagBox.put("permission_flag","denied_forever");
    } else {
      if (mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MapSelectPage(),));
      }
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 30,),
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage("assets/icon/icon.png"),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 30,),
                          Text("Allow location access on the next screen for :",style: TextStyle(color: Colors.black,fontSize: 30, fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.star,color: Colors.black,)
                                ),
                                SizedBox(width: 15),
                                Expanded(child: Text("Finding the best restaurants and shops near you",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),softWrap: true,),),
                              ],
                            ),
                          ),
                          SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.star,color: Colors.black,)
                                ),
                                SizedBox(width: 15),
                                Expanded(child: Text("Faster and more accurate delivery",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),softWrap: true,),),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: fetchLocation,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                        ),
                        child: Text("Continue",style: TextStyle(color: Colors.white),)
                    ),
                  ),
                ],
              ),
            ),
          )
      ),

    );
  }
}
