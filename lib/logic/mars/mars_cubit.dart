
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data-layer/models/mars_photo.dart';
import '../../data-layer/repo/repo.dart';

part 'mars_state.dart';

class MarsCubit extends Cubit<MarsState> {
  final Repo repo;
  MarsCubit({required this.repo}) : super(MarsInitial()){
    fetchRoverData();
  }
  static MarsCubit get(context)=>BlocProvider.of<MarsCubit>(context);
  Future <void>  fetchRoverData()async{
    emit(RoverDataLoading());
    await repo.fetchCuriosityData();
    emit(RoverDataLoaded());
  }
   void fetchLatestPhotos()async{
    emit(MarsPhotosLoading());
   final photoList=await repo.fetchLatestPhotos();
    emit(MarsPhotosLoaded(photos: photoList));


   }
  void fetchDatePhotos(DateTime earthDate)async{
    emit(MarsPhotosLoading());
    final photoList=await repo.fetchDatePhotos(earthDate);
    emit(MarsPhotosLoaded(photos: photoList));


  }


}
