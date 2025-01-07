import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../domain/enums/json_source_enum.dart';
import '../../state/home_viewmodel.dart';
import '../../widgets/container_widget.dart';
import '../../widgets/json_previewer_widget.dart';
import '../../widgets/section_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/title_widget.dart';

class JsonInitializationSection extends StatefulWidget {
  const JsonInitializationSection({super.key});

  @override
  State<JsonInitializationSection> createState() =>
      _JsonInitializationSectionState();
}

class _JsonInitializationSectionState extends State<JsonInitializationSection> {
  HomeViewmodel get model => context.read<HomeViewmodel>();

  final TextEditingController urlController = TextEditingController();

  final TextEditingController jsonController = TextEditingController();

  void _onChangeUrl(String url) {
    EasyDebounce.debounce('url-change', const Duration(milliseconds: 200), () {
      urlController.text = url;
      jsonController.clear();
      model.getJsonFromUrl(url);
    });
  }

  void _onChangeJson(String json) {
    EasyDebounce.debounce('json-change', const Duration(milliseconds: 200), () {
      jsonController.text = json;
      urlController.clear();
      model.setRawJson(json);
    });
  }

  @override
  void dispose() {
    urlController.dispose();
    jsonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewmodel>(
      builder: (context, model, child) {
        return SectionWidget(
          children: [
            ContainerWidget(
              child: Column(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const TitleWidget('JSON Source:'),
                      Wrap(
                        spacing: 8,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<JsonSource>(
                                value: JsonSource.rawJson,
                                groupValue: model.jsonSource,
                                onChanged: (value) => model
                                    .setJsonSource(value ?? JsonSource.rawJson),
                              ),
                              Text(
                                'Raw JSON',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<JsonSource>(
                                value: JsonSource.url,
                                groupValue: model.jsonSource,
                                onChanged: (value) => model
                                    .setJsonSource(value ?? JsonSource.url),
                              ),
                              Text(
                                'URL',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (model.jsonSource == JsonSource.url)
                    TextFieldWidget(
                      titleWidget: Row(
                        children: [
                          const Expanded(
                            child: TitleWidget('URL'),
                          ),
                          // Paste button
                          InkWell(
                            child: const Icon(
                              CupertinoIcons.doc_on_doc,
                              size: 16,
                            ),
                            onTap: () async {
                              // Get text from clipboard
                              final data =
                                  await Clipboard.getData('text/plain');
                              final text = data?.text;
                              if (text == null || text.isEmpty) {
                                return;
                              }

                              _onChangeUrl(text);
                            },
                          ),
                        ],
                      ),
                      controller: urlController,
                      hintText: 'Add your URL here',
                      helperText: 'Only support HTTP GET method',
                      onChanged: _onChangeUrl,
                      minLines: 2,
                      maxLines: 4,
                    )
                  else
                    TextFieldWidget(
                      titleWidget: Row(
                        children: [
                          const Expanded(
                            child: TitleWidget('JSON Data'),
                          ),
                          // Paste button
                          InkWell(
                            child: const Icon(
                              CupertinoIcons.doc_on_doc,
                              size: 16,
                            ),
                            onTap: () async {
                              // Get text from clipboard
                              final data =
                                  await Clipboard.getData('text/plain');
                              final text = data?.text;
                              if (text == null || text.isEmpty) {
                                return;
                              }

                              _onChangeJson(text);
                            },
                          ),
                        ],
                      ),
                      controller: jsonController,
                      hintText: 'Add your JSON here',
                      onChanged: _onChangeJson,
                      minLines: 4,
                      maxLines: 8,
                    ),
                ],
              ),
            ),
            ContainerWidget(
              child: JsonPreviewerWidget(
                rawJson: model.rawJson,
                isLoading: model.isLoadingJson,
              ),
            ),
          ],
        );
      },
    );
  }
}
