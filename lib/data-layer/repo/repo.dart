import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:untitled6/data-layer/api/api.dart';
import 'package:untitled6/data-layer/db/db_functions.dart';
import 'package:untitled6/data-layer/models/mars_photo.dart';
import 'package:untitled6/data-layer/models/rover.dart';
import 'package:untitled6/data-layer/repo/repo.dart';

import '../../utils/constants.dart';

class Repo{

  late API _api;

  Repo(){
    _api=API();

  }
  Future<List<MarsPhoto>>fetchLatestPhotos()async{

    final data=await _api.fetchLatestPhotos();
    final photos=data.map((e) => MarsPhoto.fromJson(e)).toList();
    savedPhotosList(photos);
    return photos;

  }



  Future<List<MarsPhoto>>fetchDatePhotos(DateTime earthDate , {int? page})async{
    bool online = await InternetConnectionChecker().hasConnection;
    if(online == true) {
      final formattedDate=DateFormat("yyyy-MM-dd").format(earthDate);
      final data=await _api.fetchDatePhotos(formattedDate , page: page );
      final photos=data.map((e) => MarsPhoto.fromJson(e)).toList();
      savedPhotosList(photos);
      return photos;

    } else {
        return fetchDatePhotosFromDB(earthDate);
    }


  }
  Future<bool>fetchCuriosityData()async{
    try{
      final data=await _api.fetchCuriosityData();
      Rover rover=Rover.fromJson(data);
      debugPrint(rover.maxDate.toString());
      Hive.box<Rover>(roverDetailsKey).put(roverDetails, rover);
      return true;
    }catch(e){

      return false;
    }
    }


  }


