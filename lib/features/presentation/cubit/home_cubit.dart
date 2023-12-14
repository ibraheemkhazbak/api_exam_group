
import 'package:apiexam/features/data/repository/cat_image_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(HomeInitial());
  final CatImageRepository repo;


  Future<void> getImages() async{
    emit(HomeLoadingState());
    var response =await repo.getImages();
    if(response.isRight) {
      emit(HomeSuccessState(catImages: response.right));
    }else{
      emit(HomeErrorState(error: response.left));
    }

  }

}
