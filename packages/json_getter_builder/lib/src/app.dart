import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repository/json_repository_impl.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/state/home_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final jsonRepository = JsonRepositoryImpl();

    return ChangeNotifierProvider<HomeViewmodel>(
      create: (context) => HomeViewmodel(jsonRepository: jsonRepository),
      child: MaterialApp(
        title: 'Flutter JSON Getter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
