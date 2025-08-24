import 'package:ai_voting_app/core/bloc/app_bloc.dart';
import 'package:ai_voting_app/core/di/init_di_imports.dart';
import 'package:ai_voting_app/core/routes/app_routes.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/auth/cubit/auth_cubit.dart';
import 'package:ai_voting_app/feature/idea/cubit/idea_cubit.dart';
import 'package:ai_voting_app/feature/profile/cubit/profile_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initDi();
  runApp(const MyApp());
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => servicelocator<AppBloc>()),
        BlocProvider(
          create: (_) => servicelocator<AuthCubit>()..getCurrentUser(),
        ),
        BlocProvider(create: (_) => servicelocator<IdeaCubit>()),
        BlocProvider(create: (_) => servicelocator<ProfileCubit>()),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Startup Idea Evaluator',
            initialRoute: AppRoutes.splash,
            onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.isDarkMode ? ThemeMode.light : ThemeMode.dark,
          );
        },
      ),
    );
  }
}
