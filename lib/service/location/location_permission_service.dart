import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import '../../pages/home_page/home_page.dart';
import '../../pages/location_control_pages/denied_forever_page.dart';
import '../../pages/location_control_pages/map_select_page.dart';
import 'fetch_location_area_and_compare_polygon.dart';
import 'overlay_update_hive.dart';

class LocationPermissionService {
  static late Box ifFirstTimeStoreLocation;
  static late Box permissionFlagBox;

  static Future<void> fetchPermission(BuildContext context) async {
    ifFirstTimeStoreLocation = Hive.box("FirstTimeCheckBox");
    permissionFlagBox = Hive.box("StorePermissionFlag");

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    // Ask Every Time
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        // Allow
        await ifFirstTimeStoreLocation.put("check_hive", false);
        await permissionFlagBox.put("permission_flag", "granted");

        if(context.mounted){OverlayUpdateHive.show(context, "Loading...");} // Show Overlay
        if(context.mounted){await FetchLocationAreaAndComparePolygon.fetchLocation(context);}
        if(context.mounted){OverlayUpdateHive.hide(context);} // Hide Overlay
        if (context.mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
        }
        return;
      } else if (permission == LocationPermission.deniedForever) {
        // Again Denied Forever
        await permissionFlagBox.put("permission_flag", "denied_forever");
        if (context.mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeniedForeverPage()),);
        }
        return;
      } else {
        // User Again Deny
        await permissionFlagBox.put("permission_flag", "denied");
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapSelectPage()),);
        }
        return;
      }
    }

    // Direct Allow
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      await ifFirstTimeStoreLocation.put("check_hive", false);
      await permissionFlagBox.put("permission_flag", "granted");
      if (context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
      }
      return;
    }

    //  Forever Denied
    if (permission == LocationPermission.deniedForever) {
      await permissionFlagBox.put("permission_flag", "denied_forever");
      if (context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeniedForeverPage()),);
      }
      return;
    }

    // Default Map Select Page
    if (context.mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MapSelectPage()),);
    }
  }
}
