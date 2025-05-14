import 'package:test_rick/services/rick_and_morty_api/api.dart';
import 'package:test_rick/models/character_response/character_response.dart';
class RickAndMortyRepository {
  final RickAndMortyApiClient apiClient;

  RickAndMortyRepository({required this.apiClient});

  Future<CharacterResponse> getCharacters() async {
    try {
      final response = await apiClient.getCharacters();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
