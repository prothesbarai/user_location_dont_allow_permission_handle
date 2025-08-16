import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:turf/along.dart' as turf;
import 'package:turf/boolean.dart' hide Position;
import '../../location_store_hive_model/location_store_hive_model.dart';
import '../../provider/location_provider.dart';
import 'map_polygon.dart';


class FetchLocationAreaAndComparePolygon {
  static late Box locationBox;
  static Future<void> fetchLocation(BuildContext context,bool isPermission) async{

    locationBox = Hive.box<LocationStoreHiveModel>("StoreUserLocations");

    if(!isPermission) return;
    try{
      Position position = await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high,distanceFilter: 0));
      final userPosition = turf.Position(position.longitude, position.latitude);
      final locationInfo = getLocationInfo(userPosition);
      List<Placemark> placeMark = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMark[0];

      final customPlace = LocationStoreHiveModel(
        name: locationInfo["name"],
        street: place.street,
        administrativeArea: place.administrativeArea,
        subAdministrativeArea: place.subAdministrativeArea,
        thoroughfare: place.thoroughfare,
        subThoroughfare: place.subThoroughfare,
        locality: place.locality,
        subLocality: place.subLocality,
        postalCode: place.postalCode,
        isoCountryCode: place.isoCountryCode,
        country: place.country,
        latitude: position.latitude,
        longitude: position.longitude,
        locationId: locationInfo["locationId"],
      );

      await locationBox.put("store_location", customPlace);
      if(context.mounted){
        Provider.of<LocationProvider>(context, listen: false).refreshLocation();
      }

    }catch(e){
      debugPrint("Error fetching location: $e");
    }
  }

}




Map<String,dynamic> getLocationInfo(turf.Position userPosition){
  final polygons = [
    {"name": "Dhanmondi", "locationId": 8, "polygon": dhanmondiPolygon},
    {"name": "Banashree", "locationId": 9, "polygon": banashreePolygon},
    {"name": "South Banashree", "locationId": 10, "polygon": southBanashreePolygon},
    {"name": "Mirpur", "locationId": 11, "polygon": mirpurPolygon},
    {"name": "Badda", "locationId": 12, "polygon": baddaPolygon},
  ];


  for (final items in polygons) {

    final String name = items["name"] as String;
    final int locationId = items["locationId"] as int;
    final turf.GeoJSONObject polygon = items["polygon"] as turf.GeoJSONObject;
    if (booleanPointInPolygon(userPosition, polygon)) {
      return {
        "name": name,
        "locationId": locationId,
      };
    }

  }

  return {
    "name": "Out Of Dhaka City",
    "locationId": 13,
  };
}