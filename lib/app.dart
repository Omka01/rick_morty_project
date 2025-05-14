import 'package:flutter/material.dart';
import 'package:test_rick/config/router.dart';
import 'package:test_rick/config/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_rick/features/home/state/home_cubit.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<HomeCubit>(create: (BuildContext context) => HomeCubit()),
      ],
      child: MaterialApp.router(
        title: 'Rick and Morty',
        theme: theme,
        routerConfig: AppRouterHelper.router,
      ),
    );
  }
}
