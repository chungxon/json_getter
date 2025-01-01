import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.helperText,
    this.onChanged,
    this.minLines,
    this.maxLines,
    this.titleWidget,
    this.inputFormatters,
    this.keyboardType,
    this.enable = true,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? helperText;
  final ValueChanged<String>? onChanged;
  final int? minLines;
  final int? maxLines;
  final Widget? titleWidget;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    final child = TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsetsDirectional.all(8),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
        helperText: helperText,
        helperStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      enabled: enable,
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
