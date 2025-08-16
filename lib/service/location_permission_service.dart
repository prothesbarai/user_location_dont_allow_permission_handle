import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import '../pages/home_page/home_page.dart';
import '../pages/location_control_pages/denied_forever_page.dart';
import '../pages/location_control_pages/map_select_page.dart';

class LocationPermissionService {
  static late Box ifStoreLocation;
  static late Box permissionFlagBox;

  static Future<bool> fetchLocation(BuildContext context) async {
    ifStoreLocation = Hive.box("FirstTimeCheckBox");
    permissionFlagBox = Hive.box("StorePermissionFlag");

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    // Ask Every Time
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        // Allow
        await ifStoreLocation.put("check_hive", false);
        await permissionFlagBox.put("permission_flag", "granted");
        if (context.mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
        }
        return true;
      } else if (permission == LocationPermission.deniedForever) {
        // Again Denied Forever
        await permissionFlagBox.put("permission_flag", "denied_forever");
        if (context.mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeniedForeverPage()),);
        }
        return false;
      } else {
        // User Again Deny
        await permissionFlagBox.put("permission_flag", "denied");
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapSelectPage()),);
        }
        return false;
      }
    }

    // Direct Allow
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      await ifStoreLocation.put("check_hive", false);
      await permissionFlagBox.put("permission_flag", "granted");
      if (context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
      }
      return true;
    }

    //  Forever Denied
    if (permission == LocationPermission.deniedForever) {
      await permissionFlagBox.put("permission_flag", "denied_forever");
      if (context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeniedForeverPage()),);
      }
      return false;
    }

    // Default Map Select Page
    if (context.mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MapSelectPage()),);
    }
    return false;
  }
}
