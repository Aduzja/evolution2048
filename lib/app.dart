import 'package:evolution2048/features/game/logic/game_cubit.dart';
import 'package:evolution2048/features/game/logic/game_state.dart';
import 'package:evolution2048/features/game/presentation/home_screen.dart';
import 'package:evolution2048/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
        BlocProvider<GameCubit>(create: (context) => GameCubit()..init(),
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Ewolucja 2048',
            theme: AppTheme.theme,
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('pl'), Locale('en')],
          );
        },
      ),
    );
  }
}
