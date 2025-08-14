import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user_location_like_as_foodpanda/pages/location_control_pages/map_select_page.dart';

class DeniedForeverPage extends StatelessWidget {
  const DeniedForeverPage({super.key});

  Future<void> _openAppSettings() async {
    await Geolocator.openAppSettings();
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
                          Text("Share your location to order with ease",style: TextStyle(color: Colors.black,fontSize: 27, fontWeight: FontWeight.bold),),
                          SizedBox(height: 30,),
                          Text(
                            "Turn on Location Service in Settings or enter your address manually to find the best restaurants,shops,and deals near you",
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16,color: Colors.grey.shade700),softWrap: true,),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: _openAppSettings,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                            child: Text("Go to Settings",style: TextStyle(color: Colors.white),)
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MapSelectPage(),));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xfffef7ff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.pink, width: 2),
                              ),
                            ),
                            child: Text("Enter address manually",style: TextStyle(color: Colors.black),)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
      ),

    );
  }
}
