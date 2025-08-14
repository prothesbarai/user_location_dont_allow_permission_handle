import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../location_store_hive_model/location_store_hive_model.dart';

class HiveService {
  static Future<void> initHive() async{
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(LocationStoreHiveModelAdapter());
    await Hive.openBox("FirstTimeCheckBox");
    await Hive.openBox("StorePermissionFlag");
    await Hive.openBox<LocationStoreHiveModel>("StoreUserLocations");
  }
}