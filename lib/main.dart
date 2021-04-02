import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:maktube/ui/peges/pages.dart';

import 'cubit/cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserCubit()),
          BlocProvider(create: (_) => VideosCubit()),
          BlocProvider(create: (_) => VisitorsCubit()),
        ],
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false, home: SplashScreen()));
  }
}
