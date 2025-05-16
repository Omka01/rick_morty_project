import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_rick/config/constants.dart';
import 'package:test_rick/models/character/character.dart';
import 'package:test_rick/models/character_response/character_response.dart';
import 'package:test_rick/services/rick_and_morty_api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_rick/features/home/components/character_card.dart';
import 'package:test_rick/features/home/state/home_cubit.dart';
import 'package:test_rick/domain/use_cases/get_character_use_case.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<void> _future;

  final Dio dio = Dio();
  static const double _verticalGap = 10;
  static const double _horizontalGap = 20;
  static const double _horizontalPadding = 20;

  @override
  void initState() {
    _future = context.read<HomeCubit>().getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final CharacterResponse response =
                  await RickAndMortyApiClient(
                    dio,
                    baseUrl: AppConstants.rickAndMortyApiUrl,
                  ).getCharacters();
              response.results.forEach((Character character) {});
              // inspect(response);
            } catch (e) {
              inspect(e);
            }

            showDialog(
              context: context,
              builder:
                  (_) => Scaffold(
                    body: SafeArea(
                      bottom: false,
                      child: FutureBuilder(
                        future: _future,
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                if (snapshot.hasError) {
                                  return Column(
                                    // spacing: 8, // ← у Column нет такого параметра
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.errorMessage ?? 'Some error...',
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await context
                                              .read<HomeCubit>()
                                              .getCharacters();
                                        },
                                        child: Text("Try again"),
                                      ),
                                    ],
                                  );
                                }
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    await context
                                        .read<HomeCubit>()
                                        .getCharacters();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: _horizontalPadding,
                                    ),
                                    child: CustomScrollView(
                                      slivers: [
                                        SliverGrid(
                                          delegate: SliverChildBuilderDelegate(
                                            (BuildContext context, int index) {
                                              final character =
                                                  state.characters[index];
                                              return CharacterCard(
                                                character: character,
                                              );
                                            },
                                            childCount: state.characters.length,
                                          ),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 215,
                                                mainAxisSpacing: _verticalGap,
                                                crossAxisSpacing:
                                                    _horizontalGap,
                                                childAspectRatio: 160 / 215,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
            );
          },
          child: Text("Get characters"),
        ),
      ),
    );
  }
}
