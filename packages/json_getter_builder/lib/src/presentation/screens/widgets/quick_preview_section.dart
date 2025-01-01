import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_getter/json_getter.dart';

import '../../widgets/container_widget.dart';
import '../../widgets/json_previewer_widget.dart';
import '../../widgets/section_widget.dart';
import '../../widgets/title_widget.dart';

class QuickPreviewSection extends StatelessWidget {
  const QuickPreviewSection({
    super.key,
    required this.rawJson,
    required this.filterJson,
  });

  final String rawJson;
  final String filterJson;

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      children: [
        Column(
          spacing: 8,
          children: [
            const TitleWidget('Raw Data'),
            ContainerWidget(
              child: JsonPreviewerWidget(
                rawJson: rawJson,
              ),
            ),
          ],
        ),
        Column(
          spacing: 8,
          children: [
            const TitleWidget('Filters'),
            ContainerWidget(
              child: JsonPreviewerWidget(
                rawJson: filterJson,
              ),
            ),
          ],
        ),
        Column(
          spacing: 8,
          children: [
            const TitleWidget('Output Data'),
            ContainerWidget(
              child: JsonPreviewerWidget(
                rawJson: jsonEncode(
                  JsonGetter.get(
                    filters: FiltersMapper.fromJson(filterJson),
                    json: rawJson,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
