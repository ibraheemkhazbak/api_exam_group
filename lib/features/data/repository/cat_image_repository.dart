import 'package:apiexam/core/database/api/api_consumer.dart';
import 'package:apiexam/core/error/error_model.dart';
import 'package:apiexam/core/error/exceptions.dart';
import 'package:apiexam/core/utils/api_strings.dart';
import 'package:apiexam/features/data/models/cat_image_model.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class CatImageRepository{
  final ApiConsumer apiConsumer;

  CatImageRepository({required this.apiConsumer});
  Future<Either<ErrorModel,List<CatImageModel>>> getImages() async{
    try{
    var response = await apiConsumer.get(ApiStrings.endpoint,queryParameters:ApiStrings.queryParameters);
    List<CatImageModel> catImages=[];
    for (var element in response!) {
      catImages.add(CatImageModel.fromJson(element));
    }
    print(catImages[0]);
    return Right(catImages);
      }on ServerException catch(e){
      return Left(e.errorModel);
    }
    }
}