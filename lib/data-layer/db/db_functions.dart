

import 'package:hive/hive.dart';

import '../../utils/constants.dart';
import '../models/mars_photo.dart';

void savedPhotosList(List<MarsPhoto> photos){
  photos.map((photo){
    final MarsPhoto localPhoto = Hive.box(marsPhotosKey).get(photo.id);
    if(localPhoto != photo ){
      Hive.box(marsPhotosKey).put(photo.id, photo);

    }

  } );


}
List <MarsPhoto> fetchDatePhotosFromDB (DateTime date){
  return  Hive.box<MarsPhoto>(marsPhotosKey).values
      .where((photo) => photo.earthDate != date )
      .toList();
}
