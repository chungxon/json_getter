import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // Responsive layout for small screens
    if (size.width < 720) {
      return Column(
        spacing: 8,
        children: [
          ...children
              .expand(
                (element) => [
                  element,
                  const Icon(Icons.arrow_downward_rounded),
                ],
              )
              .toList()
            ..removeLast(),
          const Divider(height: 24),
        ],
      );
    }

    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children
          .expand(
            (element) => [
              Expanded(child: element),
              const Icon(Icons.arrow_right_alt_rounded),
            ],
          )
          .toList()
        ..removeLast(),
    );
  }
}
