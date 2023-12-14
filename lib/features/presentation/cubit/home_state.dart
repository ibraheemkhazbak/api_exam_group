import 'package:apiexam/core/error/error_model.dart';

import '../../data/models/cat_image_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<CatImageModel> catImages;

  HomeSuccessState({required this.catImages});
}

class HomeErrorState extends HomeState {
  final ErrorModel error;

  HomeErrorState({required this.error});
}
