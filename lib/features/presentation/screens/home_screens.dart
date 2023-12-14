import 'package:apiexam/core/utils/app_color.dart';
import 'package:apiexam/features/data/models/cat_image_model.dart';
import 'package:apiexam/features/data/repository/cat_image_repository.dart';
import 'package:apiexam/features/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          title: const Text("Flutter Cats App"),
          actions: [
            IconButton(
              onPressed: () {
                sl<HomeCubit>().getImages();
              },
              icon: const Icon(Icons.replay),
            ),
          ],
          bottom: const PreferredSize(
              preferredSize: Size.square(20),
              child: Column(
                children: [
                  Text(
                    "cats",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )),
        ),
      ),
      body: Center(
        child: BlocBuilder<HomeCubit,HomeState>(

          builder: (BuildContext context, state) {
             if(state is HomeSuccessState){
              return GridView.builder(
                 itemCount: state.catImages.length,
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                   itemBuilder: (context,i){
                    CatImageModel currentImage=state.catImages[i];
                    return Image.network(
                      currentImage.url,
                      width: currentImage.width,
                      height: currentImage.height,
                      );
                   });
              }else if(state is HomeLoadingState){
               return const CircularProgressIndicator();
             }else if(state is HomeErrorState){
               print(state.error.errorMessage);
               return Container(color: Colors.red,width: 100,height: 100,child:
                 Text(state.error.errorMessage),);
             }else{
               return Container(color: Colors.black,width: 100,height: 100,);
             }

            },

        ),
      ),
    );
  }
}
