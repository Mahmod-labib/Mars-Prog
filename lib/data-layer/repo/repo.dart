import 'package:flutter/cupertino.dart';
import 'package:untitled6/data-layer/api/api.dart';
import 'package:untitled6/data-layer/models/mars_photo.dart';

class Repo{

  late API _api;

  Repo(){
    _api=API();

  }
  Future<List<MarsPhoto>>fetchLatestPhotos()async{
    final data=await _api.fetchLatestPhotos();
    final photos=data.map((e) => MarsPhoto.fromJson(e)).toList();
    debugPrint(photos.length.toString());
    debugPrint(photos.first.imgSrc);

    return photos;

  }

}