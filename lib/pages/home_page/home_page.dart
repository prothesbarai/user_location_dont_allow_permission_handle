import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_location_like_as_foodpanda/widget/custom_appbar.dart';
import 'package:user_location_like_as_foodpanda/widget/custom_drawer.dart';
import '../../provider/location_provider.dart';
import '../../service/location/fetch_location_area_and_compare_polygon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  Future<void> _updateLocation() async {
    setState(() {isLoading = true;});
    await FetchLocationAreaAndComparePolygon.fetchLocation(context);
    setState(() {isLoading = false;});
  }

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  child: isLoading ? Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 30,)
                    ],
                  ) :
                  Column(children: [
                    Text("${locationProvider.locationName}", key: ValueKey(locationProvider.locationName), style: TextStyle(fontSize: 25),),
                    Text("${locationProvider.locationId}", key: ValueKey(locationProvider.locationId), style: TextStyle(fontSize: 25),),

                  ],),
                ),


                ElevatedButton(
                    onPressed: isLoading ? null : _updateLocation,
                    child: Text("Update Your Location")
                )

              ],
            ),
          )
      ),
    );
  }
}
