part of 'mars_cubit.dart';

abstract class MarsState {}

class MarsInitial extends MarsState {}
class MarsPhotosLoading extends MarsState {}
class MarsPhotosLoaded extends MarsState {
  final List<MarsPhoto> photos;
  MarsPhotosLoaded({required this.photos});
}
class RoverDataLoading extends MarsState {}
class RoverDataLoaded extends MarsState {}
