import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_getter/json_getter.dart';

import '../../widgets/container_widget.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/dropdown_menu_widget.dart';
import '../../widgets/json_previewer_widget.dart';
import '../../widgets/section_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/title_widget.dart';

class JsonGetterSection extends StatefulWidget {
  const JsonGetterSection({
    super.key,
    required this.index,
    required this.filter,
    required this.rawJson,
    this.outputJson,
    required this.onFilterChanged,
  });

  final int index;
  final Filter? filter;
  final String rawJson;
  final String? outputJson;
  final void Function(Filter filter, String? json) onFilterChanged;

  @override
  State<JsonGetterSection> createState() => _JsonGetterSectionState();
}

class _JsonGetterSectionState extends State<JsonGetterSection> {
  // Json source, could be map or list
  dynamic get jsonSource => TypeUtils.tryParseJson(widget.rawJson);

  // Selector type
  List<SelectorType> get _availableSelectorTypes =>
      SelectorType.getSupportSelectorTypes(jsonSource);
  final ValueNotifier<SelectorType?> _selectedTypeNotifier =
      ValueNotifier(null);

  final TextEditingController keyController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  // Filter
  Filter filter = const Filter();

  // Json output
  dynamic jsonOutput;

  @override
  void initState() {
    super.initState();
    if (widget.filter != null) {
      filter = widget.filter!;
      _selectedTypeNotifier.value = filter.selectorType;
      keyController.text = filter.key ?? '';
      valueController.text = filter.value ?? '';
      jsonOutput = widget.outputJson;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _selectedTypeNotifier.dispose();
    keyController.dispose();
    valueController.dispose();
    super.dispose();
  }

  void _onChangeSelectorType(SelectorType? type) {
    _selectedTypeNotifier.value = type;

    switch (type) {
      case SelectorType.getValueByKey:
        filter = Filter(selectorType: type);
        jsonOutput = null;
        widget.onFilterChanged(filter, jsonOutput);
      case SelectorType.getAllKeys:
        filter = Filter(selectorType: type);
        jsonOutput = jsonEncode(JsonTools.getAllKeys(jsonSource));
        widget.onFilterChanged(filter, jsonOutput);
      case SelectorType.getAllValues:
        filter = Filter(selectorType: type);
        jsonOutput = jsonEncode(JsonTools.getAllValues(jsonSource));
        widget.onFilterChanged(filter, jsonOutput);
      case SelectorType.getLength:
        filter = Filter(selectorType: type);
        jsonOutput = jsonEncode(JsonTools.getLength(jsonSource));
        widget.onFilterChanged(filter, jsonOutput);
      case SelectorType.getValueFromWhere:
        if (jsonSource is List) {
          filter = Filter(selectorType: type, filterBy: FilterBy.value);
        } else if (jsonSource is Map) {
          filter = Filter(selectorType: type, filterBy: FilterBy.key);
        } else {
          filter = Filter(selectorType: type);
        }
        jsonOutput = null;
        widget.onFilterChanged(filter, jsonOutput);
      case SelectorType.getValueAt:
        filter = Filter(selectorType: type);
        jsonOutput = null;
        widget.onFilterChanged(filter, jsonOutput);
      case SelectorType.getValueFirst:
        filter = Filter(selectorType: type);
        jsonOutput = jsonEncode(JsonTools.getValueFirst(jsonSource));
        widget.onFilterChanged(filter, jsonOutput);
      case SelectorType.getValueLast:
        filter = Filter(selectorType: type);
        jsonOutput = jsonEncode(JsonTools.getValueLast(jsonSource));
        widget.onFilterChanged(filter, jsonOutput);
      case SelectorType.join:
        filter = Filter(selectorType: type);
        jsonOutput = null;
        widget.onFilterChanged(filter, jsonOutput);
      case SelectorType.getItemsFromWhere:
        filter = Filter(selectorType: type);
        jsonOutput = null;
        widget.onFilterChanged(filter, jsonOutput);
      default:
        filter = Filter(selectorType: type);
        jsonOutput = null;
        widget.onFilterChanged(filter, jsonOutput);
    }
  }

  Widget _buildSelector({
    required SelectorType? selectedType,
  }) {
    if (selectedType == null) {
      return const SizedBox();
    }
    switch (selectedType) {
      case SelectorType.getValueByKey:
        return DropdownMenuWidget(
          titleWidget: const TitleWidget('Key'),
          controller: keyController,
          initialSelection: filter.key,
          hintText: 'Key',
          dropdownMenuEntries: JsonTools.getAllKeys(jsonSource)
              .map(
                (e) => DropdownMenuEntry(
                  value: e,
                  label: e,
                ),
              )
              .toList(),
          onSelected: (value) {
            filter = filter.copyWith(key: value);
            jsonOutput = jsonEncode(JsonTools.getValueByKey(jsonSource, value));
            widget.onFilterChanged(filter, jsonOutput);
            setState(() {});
          },
        );
      case SelectorType.getAllKeys:
      case SelectorType.getAllValues:
      case SelectorType.getLength:
        return const SizedBox();
      case SelectorType.getValueFromWhere:
        if (TypeUtils.isList<String>(jsonSource)) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              DropdownButtonWidget<Operator>(
                titleWidget: const TitleWidget('Operator'),
                hintText: 'Operator',
                value: filter.operator,
                items: Operator.getSupportOperators(
                  (filter.filterBy == FilterBy.key)
                      ? JsonTools.getAllKeys(jsonSource)
                      : JsonTools.getValueByKey(jsonSource, keyController.text),
                  filter.filterBy,
                )
                    .map(
                      (e) => DropdownMenuItem<Operator>(
                        value: e,
                        child: Text(
                          e.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  filter = filter.copyWith(
                    filterBy: FilterBy.value,
                    operator: value,
                  );
                  jsonOutput = null;
                  widget.onFilterChanged(filter, jsonOutput);
                  setState(() {});
                },
              ),
              if (filter.operator?.isNeedValue ?? false)
                TextFieldWidget(
                  titleWidget: const TitleWidget('Key'),
                  controller: keyController,
                  enable: filter.operator != null,
                  onChanged: (value) {
                    filter = filter.copyWith(key: value);
                    jsonOutput = jsonEncode(
                      JsonTools.getValueFromWhere(
                        jsonSource,
                        filter,
                      ),
                    );
                    widget.onFilterChanged(filter, jsonOutput);
                    setState(() {});
                  },
                ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            if (jsonSource is Map)
              DropdownButtonWidget<FilterBy>(
                titleWidget: const TitleWidget('Filter By'),
                hintText: 'Filter By',
                value: filter.filterBy,
                items: FilterBy.values
                    .map(
                      (e) => DropdownMenuItem<FilterBy>(
                        value: e,
                        child: Text(
                          e.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  filter = filter.copyWith(filterBy: value, operator: null);
                  widget.onFilterChanged(filter, jsonOutput);
                  setState(() {});
                },
              ),
            if (filter.filterBy != FilterBy.key)
              DropdownMenuWidget(
                titleWidget: const TitleWidget('Key'),
                controller: keyController,
                initialSelection: filter.key,
                hintText: 'Key',
                dropdownMenuEntries: JsonTools.getAllKeys(jsonSource)
                    .map(
                      (e) => DropdownMenuEntry(
                        value: e,
                        label: e.toString(),
                      ),
                    )
                    .toList(),
                onSelected: (value) {
                  filter = filter.copyWith(key: value);
                  jsonOutput =
                      jsonEncode(JsonTools.getValueByKey(jsonSource, value));
                  widget.onFilterChanged(filter, jsonOutput);
                  setState(() {});
                },
              ),
            DropdownButtonWidget<Operator>(
              titleWidget: const TitleWidget('Operator'),
              hintText: 'Operator',
              enable: (filter.filterBy == FilterBy.key) ||
                  (filter.key?.isNotEmpty ?? false),
              value: filter.operator,
              items: Operator.getSupportOperators(
                (filter.filterBy == FilterBy.key)
                    ? JsonTools.getAllKeys(jsonSource)
                    : JsonTools.getValueByKey(jsonSource, keyController.text),
                filter.filterBy,
              )
                  .map(
                    (e) => DropdownMenuItem<Operator>(
                      value: e,
                      child: Text(
                        e.title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                filter = filter.copyWith(operator: value);
                jsonOutput = jsonEncode(
                  JsonTools.getValueFromWhere(
                    jsonSource,
                    filter,
                  ),
                );
                widget.onFilterChanged(filter, jsonOutput);
                setState(() {});
              },
            ),
            if ((filter.operator?.isNeedValue ?? false) &&
                (filter.filterBy != FilterBy.key))
              TextFieldWidget(
                titleWidget: const TitleWidget('Value'),
                controller: valueController,
                enable: filter.operator != null,
                onChanged: (value) {
                  filter = filter.copyWith(value: value);
                  jsonOutput = jsonEncode(
                    JsonTools.getValueFromWhere(
                      jsonSource,
                      filter,
                    ),
                  );
                  widget.onFilterChanged(filter, jsonOutput);
                  setState(() {});
                },
              )
            else if ((filter.operator?.isNeedValue ?? false) &&
                (filter.filterBy == FilterBy.key))
              TextFieldWidget(
                titleWidget: const TitleWidget('Key'),
                controller: keyController,
                enable: filter.operator != null,
                onChanged: (value) {
                  filter = filter.copyWith(key: value);
                  jsonOutput = jsonEncode(
                    JsonTools.getValueFromWhere(
                      jsonSource,
                      filter,
                    ),
                  );
                  widget.onFilterChanged(filter, jsonOutput);
                  setState(() {});
                },
              ),
          ],
        );
      case SelectorType.getValueAt:
        return TextFieldWidget(
          titleWidget: const TitleWidget('Index'),
          hintText: 'Index',
          helperText: 'Index start from 0',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+$')),
          ],
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final index = int.tryParse(value);
            if (index == null || index < 0) {
              jsonOutput = null;
              setState(() {});
              return;
            }

            filter = filter.copyWith(value: index);
            jsonOutput = jsonEncode(JsonTools.getValueAt(jsonSource, index));
            widget.onFilterChanged(filter, jsonOutput);
            setState(() {});
          },
        );
      case SelectorType.getValueFirst:
      case SelectorType.getValueLast:
        return const SizedBox();
      case SelectorType.join:
        return TextFieldWidget(
          titleWidget: const TitleWidget('Value'),
          controller: valueController,
          onChanged: (value) {
            filter = filter.copyWith(value: value);
            jsonOutput = jsonEncode(
              TypeUtils.joinList(
                jsonSource,
                value,
              ),
            );
            widget.onFilterChanged(filter, jsonOutput);
            setState(() {});
          },
        );
      case SelectorType.getItemsFromWhere:
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            DropdownButtonWidget<FilterBy>(
              titleWidget: const TitleWidget('Filter By'),
              hintText: 'Filter By',
              value: filter.filterBy,
              items: FilterBy.values
                  .map(
                    (e) => DropdownMenuItem<FilterBy>(
                      value: e,
                      child: Text(
                        e.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                filter = filter.copyWith(filterBy: value, operator: null);
                widget.onFilterChanged(filter, jsonOutput);
                setState(() {});
              },
            ),
            if (filter.filterBy == FilterBy.value)
              DropdownMenuWidget(
                titleWidget: const TitleWidget('Key'),
                controller: keyController,
                initialSelection: filter.key,
                hintText: 'Key',
                dropdownMenuEntries: JsonTools.getAllKeys(jsonSource)
                    .map(
                      (e) => DropdownMenuEntry(
                        value: e,
                        label: e.toString(),
                      ),
                    )
                    .toList(),
                onSelected: (value) {
                  filter = filter.copyWith(key: value);
                  widget.onFilterChanged(filter, jsonOutput);
                  setState(() {});
                },
              ),
            DropdownButtonWidget<Operator>(
              titleWidget: const TitleWidget('Operator'),
              hintText: 'Operator',
              enable: (filter.filterBy == FilterBy.key) ||
                  (filter.key?.isNotEmpty ?? false),
              value: filter.operator,
              items: Operator.getSupportOperators(
                (filter.filterBy == FilterBy.key)
                    ? JsonTools.getAllKeys(jsonSource)
                    : JsonTools.getValueByKey(jsonSource, keyController.text),
                filter.filterBy,
              )
                  .map(
                    (e) => DropdownMenuItem<Operator>(
                      value: e,
                      child: Text(
                        e.title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                filter = filter.copyWith(operator: value);
                jsonOutput = jsonEncode(
                  JsonTools.getItemsFromWhere(
                    jsonSource,
                    filter,
                  ),
                );
                widget.onFilterChanged(filter, jsonOutput);
                setState(() {});
              },
            ),
            if ((filter.operator?.isNeedValue ?? false) &&
                (filter.filterBy != FilterBy.key))
              TextFieldWidget(
                titleWidget: const TitleWidget('Value'),
                controller: valueController,
                enable: filter.operator != null,
                onChanged: (value) {
                  filter = filter.copyWith(value: value);
                  jsonOutput = jsonEncode(
                    JsonTools.getItemsFromWhere(
                      jsonSource,
                      filter,
                    ),
                  );
                  widget.onFilterChanged(filter, jsonOutput);
                  setState(() {});
                },
              )
            else if ((filter.operator?.isNeedValue ?? false) &&
                (filter.filterBy == FilterBy.key))
              TextFieldWidget(
                titleWidget: const TitleWidget('Key'),
                controller: keyController,
                enable: filter.operator != null,
                onChanged: (value) {
                  filter = filter.copyWith(key: value);
                  jsonOutput = jsonEncode(
                    JsonTools.getItemsFromWhere(
                      jsonSource,
                      filter,
                    ),
                  );
                  widget.onFilterChanged(filter, jsonOutput);
                  setState(() {});
                },
              ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedTypeNotifier,
      builder: (context, type, child) {
        return SectionWidget(
          children: [
            ContainerWidget(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TitleWidget('Selector type: '),
                        const SizedBox(height: 8),
                        DropdownButton(
                          value: type,
                          hint: const Text('Selector type'),
                          onChanged: _onChangeSelectorType,
                          items: _availableSelectorTypes
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.title,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    _buildSelector(selectedType: type),
                  ],
                ),
              ),
            ),
            ContainerWidget(
              child: JsonPreviewerWidget(
                rawJson: jsonOutput,
              ),
            ),
          ],
        );
      },
    );
  }
}
