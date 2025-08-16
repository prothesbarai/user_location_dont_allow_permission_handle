import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_location_like_as_foodpanda/widget/custom_appbar.dart';
import 'package:user_location_like_as_foodpanda/widget/custom_drawer.dart';
import '../../provider/location_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final locationProvider = Provider.of<LocationProvider>(context);

    if(locationProvider.locationName == null && locationProvider.locationId == null){
      return Scaffold(body: Center(child: CircularProgressIndicator(),),);
    }

    return Scaffold(
      appBar: CustomAppbar(titleName: "Home",),
      drawer: CustomDrawer(),
      body: SafeArea(
          child: Center(
            child: Column(
              children: [

                Text("${locationProvider.locationName}"),
                Text("${locationProvider.locationId}"),

              ],
            ),
          )
      ),
    );
  }
}
