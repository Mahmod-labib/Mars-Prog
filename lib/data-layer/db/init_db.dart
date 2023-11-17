import 'package:hive_flutter/adapters.dart';

import '../../utils/constants.dart';
import '../models/mars_photo.dart';

Future <void> initDB() async{
  await Hive.initFlutter();
  await Hive.openBox(settingsKey);

  await Hive.openBox<MarsPhoto>(marsPhotosKey);
  Hive.registerAdapter(CameraAdapter());
  Hive.registerAdapter(MarsPhotoAdapter());


}