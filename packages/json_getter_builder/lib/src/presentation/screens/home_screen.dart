import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_getter/json_getter.dart';
import 'package:provider/provider.dart';

import '../state/home_viewmodel.dart';
import 'widgets/json_getter_section.dart';
import 'widgets/json_initialization_section.dart';
import 'widgets/quick_preview_section.dart';

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
          final disableAddNewFilter = model.isLoadingJson ||
              model.rawJson.isEmpty ||
              (model.filters.filters.isNotEmpty &&
                  !TypeUtils.isJson(
                    model.filterJsons.entries.lastOrNull?.value ?? '',
                  ));

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  const JsonInitializationSection(),
                  for (var i = 0; i < model.filters.filters.length; i++)
                    JsonGetterSection(
                      index: i,
                      filter: model.filters.filters[i],
                      rawJson: i == 0
                          ? model.rawJson
                          : model.filterJsons[i - 1] ?? '',
                      outputJson: model.filterJsons[i],
                      onFilterChanged: (filter, json) {
                        model.updateFilters(i, filter, json);
                      },
                    ),
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.icon(
                        onPressed:
                            disableAddNewFilter ? null : model.addNewFilter,
                        label: const Text('Add Filter'),
                        icon: const Icon(Icons.add_rounded),
                      ),
                      FilledButton.icon(
                        onPressed: model.filters.filters.isEmpty
                            ? null
                            : model.removeLastFilter,
                        label: const Text('Remove Last Filter'),
                        icon: const Icon(Icons.remove_rounded),
                      ),
                    ],
                  ),
                  const Divider(),
                  QuickPreviewSection(
                    rawJson: model.rawJson,
                    filterJson: model.filters.toJson(),
                  ),
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.icon(
                        onPressed: () {
                          Clipboard.getData('text/plain').then((value) {
                            if (value == null) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Your clipboard data is invalid.'),
                                  ),
                                );
                                return;
                              }
                            }
                            final filters = value?.text ?? '';
                            model.setFilters(
                              FiltersMapper.fromJson(filters),
                            );
                          });
                        },
                        label: const Text('Import Filter'),
                        icon: const Icon(Icons.input_rounded),
                      ),
                      FilledButton.icon(
                        onPressed: () {
                          final filters = model.filters.toJson();
                          Clipboard.setData(
                            ClipboardData(text: filters),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Filters copied to clipboard.'),
                            ),
                          );
                        },
                        label: const Text('Export Filter'),
                        icon: const Icon(Icons.output_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
