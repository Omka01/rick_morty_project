import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:test_rick/services/rick_and_morty_api/api.dart';
import 'package:test_rick/config/constants.dart';
import 'package:dio/dio.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final response =
                  await RickAndMortyApiClient(dio, baseUrl: AppConstants.rickAndMortyUrl).getCharacters();
              inspect(response);
            } catch (e) {
              inspect(e);
            }
          },
          child: Text("Get characters"),
        ),
      ),
    );
  }
}
