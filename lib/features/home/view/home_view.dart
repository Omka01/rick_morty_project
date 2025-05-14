import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_rick/features/home/state/home_cubit.dart';
import 'package:test_rick/models/character/character.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await context.read<HomeCubit>().getCharacters();
                      } catch (e) {
                        inspect(e);
                      }
                    },
                    child: Text('Get characte'),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  sliver: SliverList.separated(
                    itemCount: state.characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Character character = state.characters[index];
                      return Text(character.name);
                    },
                    separatorBuilder: (BuildContext cotext, index) {
                      return SizedBox(height: 8);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
