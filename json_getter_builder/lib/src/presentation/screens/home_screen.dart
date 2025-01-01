import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/home_viewmodel.dart';
import 'widgets/json_initialization_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewmodel get model => context.read<HomeViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter JSON Getter'),
      ),
      body: Consumer<HomeViewmodel>(
        builder: (context, model, child) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  JsonInitializationSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
