import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bhhh_noise/repository/noise_player_model.dart';

import 'cubit/player_cubit.dart';
import 'player_page.dart';
import 'repository/player_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          PlayerRepository(noisePlayersMap: staticNoisePlayMap),
      child: BlocProvider(
        create: (context) => PlayerCubit(
          repository: RepositoryProvider.of<PlayerRepository>(context),
        ),
        child: MaterialApp(
          title: 'bhh noise',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
          ),
          home: const PlayerPage(),
        ),
      ),
    );
  }
}
