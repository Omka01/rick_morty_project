import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_rick/config/constants.dart';
import 'package:test_rick/services/rick_and_morty_api/api.dart';
import 'package:test_rick/data/rick_and_morty/repository.dart';
import 'package:test_rick/domain/use_cases/get_character_use_case.dart';

final getIt = GetIt.instance;

configureDependencies() {
  _configureNetworkDependencies();
  _configureApiClients();
  _configureRepositories();
  _configureUseCases();
}

_configureNetworkDependencies() {
  final Dio dio = Dio();
  getIt.registerSingleton<Dio>(dio);
}

_configureApiClients() {
  final dio = getIt.get<Dio>();
  final String privateBaseUrl = AppConstants.rickAndMortyApiUrl;

  getIt.registerLazySingleton<RickAndMortyApiClient>(
    () => RickAndMortyApiClient(dio, baseUrl: privateBaseUrl),
  );
}

_configureRepositories() {
  final RickAndMortyApiClient rickAndMortyApiClient =
      getIt.get<RickAndMortyApiClient>();

  getIt.registerLazySingleton<RickAndMortyRepository>(
    () => RickAndMortyRepository(apiClient: rickAndMortyApiClient),
  );
}

_configureUseCases() {
  final RickAndMortyRepository rickAndMortyRepository =
      getIt.get<RickAndMortyRepository>();
  getIt.registerLazySingleton<GetCharacterUseCase>(
    () => GetCharacterUseCase(rickAndMortyRepository),
  );
}
