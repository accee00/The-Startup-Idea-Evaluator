part of 'init_di_imports.dart';

final GetIt servicelocator = GetIt.instance;

Future<void> initDi() async {
  final Supabase supabase = await Supabase.initialize(
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    url: dotenv.env['SUPABASE_URL'] ?? '',
    debug: true,
  );

  /// Dark / Light Theme Preference
  final HydratedStorage storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationSupportDirectory()).path,
          ),
  );
  HydratedBloc.storage = storage;

  /// Hydrated Bloc initialization

  servicelocator.registerFactory(() => AppBloc());

  servicelocator.registerLazySingleton(() => supabase.client);

  /// Auth Service
  servicelocator.registerLazySingleton(
    () => AuthService(servicelocator<SupabaseClient>()),
  );

  /// Auth Cubit
  servicelocator.registerFactory(
    () => AuthCubit(servicelocator<AuthService>()),
  );

  /// Idea Service
  servicelocator.registerLazySingleton(
    () => IdeaService(servicelocator<SupabaseClient>()),
  );

  /// Idea Cubit
  servicelocator.registerFactory(
    () => IdeaCubit(servicelocator<IdeaService>()),
  );
}
