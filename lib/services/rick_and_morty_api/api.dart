import 'package:retrofit/retrofit.dart';
import 'package:test_rick/models/character_response/character_response.dart';
import 'package:dio/dio.dart';
import 'package:test_rick/models/character/character.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class RickAndMortyApiClient {
  factory RickAndMortyApiClient(Dio dio, {String baseUrl}) = _RickAndMortyApiClient;

  @GET('/character')
  Future<CharacterResponse> getCharacters();

  @GET('/character/{id}')
  Future<Character> getCharacterDetails(@Path('id') String id);
}
