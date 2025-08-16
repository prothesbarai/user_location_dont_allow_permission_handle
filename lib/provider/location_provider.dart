import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../location_store_hive_model/location_store_hive_model.dart';

class LocationProvider extends ChangeNotifier{

  String? locationName;
  int? locationId;

  LocationProvider(){
    _loadLocationFromHive();
  }

  void _loadLocationFromHive(){
    final locationBox = Hive.box<LocationStoreHiveModel>("StoreUserLocations");
    final location = locationBox.get("store_location");
    if(location != null){
      locationName = location.name;
      locationId = location.locationId;
      notifyListeners();
    }
  }


  void refreshLocation() {
    _loadLocationFromHive();
  }

}