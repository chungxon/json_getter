import 'package:flutter/material.dart';

class DropdownButtonWidget<T> extends StatelessWidget {
  const DropdownButtonWidget({
    super.key,
    this.hintText,
    this.onChanged,
    this.titleWidget,
    required this.items,
    this.enable = true,
    this.value,
  });

  final String? hintText;
  final ValueChanged<T?>? onChanged;
  final Widget? titleWidget;
  final List<DropdownMenuItem<T>>? items;
  final bool enable;
  final T? value;

  @override
  Widget build(BuildContext context) {
    final child = InputDecorator(
      decoration: const InputDecoration(
        contentPadding: EdgeInsetsDirectional.all(8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          items: items,
          onChanged: enable ? onChanged : null,
          value: value,
          isDense: true,
          isExpanded: true,
          hint: hintText?.isNotEmpty ?? false
              ? Text(
                  hintText ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                )
              : null,
        ),
      ),
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
