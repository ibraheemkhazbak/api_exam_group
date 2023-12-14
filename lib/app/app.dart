import 'package:apiexam/features/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/services/service_locator.dart';
import '../features/presentation/screens/home_screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<HomeCubit>(

          create: (context) => sl<HomeCubit>(),
          child: HomeScreen()),
    );
  }
}
