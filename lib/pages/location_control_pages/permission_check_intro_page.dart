import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../service/location/fetch_location_area_and_compare_polygon.dart';
import '../../service/location/location_permission_service.dart';

class PermissionCheckIntroPage extends StatefulWidget {
  const PermissionCheckIntroPage({super.key});

  @override
  State<PermissionCheckIntroPage> createState() => _PermissionCheckIntroPageState();
}
class _PermissionCheckIntroPageState extends State<PermissionCheckIntroPage> {



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
                        onPressed: () async{
                          final permissionResult = await LocationPermissionService.fetchPermission(context);
                          if (context.mounted) {
                            await FetchLocationAreaAndComparePolygon.fetchLocation(context, permissionResult);
                          }

                          if (kDebugMode) {
                            print("Permission granted: $permissionResult");
                          }
                        },
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
