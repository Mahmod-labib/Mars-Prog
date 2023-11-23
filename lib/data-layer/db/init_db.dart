import 'package:hive_flutter/adapters.dart';
import '../../utils/constants.dart';
import '../models/mars_photo.dart';
import '../models/rover.dart';
final Box<dynamic> settingsBox = Hive.box<dynamic>(settingsKey);

Future<void> initDB() async {

  await Hive.initFlutter();

  Hive.registerAdapter(CameraAdapter());
  Hive.registerAdapter(MarsPhotoAdapter());
  Hive.registerAdapter(RoverAdapter());
  Hive.registerAdapter(RoverCameraAdapter());

  await Hive.openBox<dynamic>(settingsKey);
  await Hive.openBox<MarsPhoto>(marsPhotosKey);
  await Hive.openBox<Rover>(roverDetailsKey);
}
