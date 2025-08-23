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

  /// Single instance of supabase client
  servicelocator.registerLazySingleton(() => supabase.client);

  _initService();
  _initCubit();
}

void _initService() {
  /// Idea Service
  servicelocator.registerLazySingleton(
    () => IdeaService(servicelocator<SupabaseClient>()),
  );

  /// Auth Service
  servicelocator.registerLazySingleton(
    () => AuthService(servicelocator<SupabaseClient>()),
  );

  /// Profile Servie
  servicelocator.registerLazySingleton(
    () => ProfileService(servicelocator<SupabaseClient>()),
  );
}

void _initCubit() {
  /// Auth Cubit
  servicelocator.registerFactory(
    () => AuthCubit(servicelocator<AuthService>()),
  );

  /// Idea Cubit
  servicelocator.registerFactory(
    () => IdeaCubit(servicelocator<IdeaService>()),
  );

  /// Profile Cubit
  servicelocator.registerFactory(
    () => ProfileCubit(servicelocator<ProfileService>()),
  );
}
