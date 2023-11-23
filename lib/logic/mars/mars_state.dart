part of 'mars_cubit.dart';

abstract class MarsState {}

class MarsInitial extends MarsState {}
class MarsPhotosLoading extends MarsState {}
class MarsPhotosLoaded extends MarsState {}
class RoverDataLoading extends MarsState {}
class RoverDataLoaded extends MarsState {}
