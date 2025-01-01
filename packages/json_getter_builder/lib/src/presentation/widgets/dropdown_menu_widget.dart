import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DropdownMenuWidget<T> extends StatelessWidget {
  const DropdownMenuWidget({
    super.key,
    this.controller,
    this.hintText,
    this.helperText,
    this.onSelected,
    this.titleWidget,
    this.inputFormatters,
    required this.dropdownMenuEntries,
    this.keyboardType,
    this.enable = true,
    this.initialSelection,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? helperText;
  final ValueChanged<T?>? onSelected;
  final Widget? titleWidget;
  final List<TextInputFormatter>? inputFormatters;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final TextInputType? keyboardType;
  final bool enable;
  final T? initialSelection;

  @override
  Widget build(BuildContext context) {
    final child = DropdownMenu<T>(
      expandedInsets: EdgeInsets.zero,
      hintText: hintText,
      helperText: helperText,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsetsDirectional.all(8),
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
        helperStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      enabled: enable,
      enableFilter: true,
      enableSearch: true,
      menuHeight: 200,
      controller: controller,
      dropdownMenuEntries: dropdownMenuEntries,
      onSelected: onSelected,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      initialSelection: initialSelection,
    );

    if (titleWidget == null) {
      return child;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget!,
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
