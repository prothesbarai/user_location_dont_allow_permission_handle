import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:user_location_like_as_foodpanda/widget/custom_appbar.dart';

class MapSelectPage extends StatefulWidget {
  const MapSelectPage({super.key});

  @override
  State<MapSelectPage> createState() => _MapSelectPageState();
}

class _MapSelectPageState extends State<MapSelectPage> {

  LatLng selectedLocation = LatLng(23.6850, 90.3563);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(titleName: "Map Page"),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: selectedLocation,
          initialZoom: 6.0,
          onTap: (tapPosition, point){
            setState(() {
              selectedLocation = point;
            });
          }
        ),
        children: [
          /*
            OpenStreetMap Register But this map only uses Some Limited Users... So Its Practices Purpose But Need [ google_maps_flutter ]
            Package With Google Cloud Console API key
          */
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.user_location_like_as_foodpanda',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: selectedLocation,
                width: 60,
                height: 60,
                child: const Icon(Icons.location_on, color: Colors.red, size: 40,),
              ),
            ],
          ),
          Positioned(
            bottom: 50, left: 16, right: 16,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("Selected Lat: ${selectedLocation.latitude}, Selected Lng: ${selectedLocation.longitude}");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: const Text("Continue",style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
