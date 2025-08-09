import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_explorer/json_explorer.dart';
import 'package:json_getter/json_getter.dart';
import 'package:provider/provider.dart';

class JsonPreviewerWidget extends StatefulWidget {
  const JsonPreviewerWidget({
    super.key,
    this.rawJson,
    this.isLoading = false,
  });

  final String? rawJson;
  final bool isLoading;

  @override
  State<JsonPreviewerWidget> createState() => _JsonPreviewerWidgetState();
}

class _JsonPreviewerWidgetState extends State<JsonPreviewerWidget> {
  final JsonExplorerStore store = JsonExplorerStore();

  @override
  void initState() {
    _updateJsonData(widget.rawJson);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant JsonPreviewerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rawJson != oldWidget.rawJson) {
      _updateJsonData(widget.rawJson);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: store,
      child: Consumer<JsonExplorerStore>(
        builder: (context, state, child) {
          return Stack(
            children: [
              ListView.builder(
                // shrinkWrap: true,
                itemCount: state.displayNodes.length,
                itemBuilder: (context, index) => JsonAttribute(
                  node: state.displayNodes.elementAt(index),

                  itemSpacing: 4,
                  maxRootNodeWidth: 200,

                  /// Builds a widget after each root node displaying the
                  /// number of children nodes that it has. Displays `{x}`
                  /// if it is a class or `[x]` in case of arrays.
                  rootInformationBuilder: (context, node) => DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color(0x80E1E1E1),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: Text(
                        node.isClass
                            ? '<Map>{${node.childrenCount} ${node.childrenCount == 1 ? 'item' : 'items'}}'
                            : '<List>[${node.childrenCount} ${node.childrenCount == 1 ? 'item' : 'items'}]',
                        style: GoogleFonts.inconsolata(
                          fontSize: 12,
                          color: const Color(0xFF6F6F6F),
                        ),
                      ),
                    ),
                  ),

                  /// Build an animated collapse/expand indicator. Implicitly
                  /// animates the indicator when
                  /// [NodeViewModelState.isCollapsed] changes.
                  collapsableToggleBuilder: (context, node) => AnimatedRotation(
                    turns: node.isCollapsed ? -0.25 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.arrow_drop_down),
                  ),

                  /// Creates a custom format for classes and array names.
                  rootNameFormatter: (name) => '"$name"',

                  /// Creates a custom format for property names
                  propertyNameFormatter: (name) => '"$name"',

                  valueFormatter: (value) {
                    if (value is String) {
                      return '"$value"';
                    }
                    return value.toString();
                  },

                  /// Dynamically changes the property value style and
                  /// interaction when an URL is detected.
                  valueStyleBuilder: (value, style) {
                    if (value is num) {
                      return PropertyOverrides(
                        style: style.copyWith(
                          color: Colors.blue,
                        ),
                      );
                    }
                    if (value is bool) {
                      return PropertyOverrides(
                        style: style.copyWith(
                          color: Colors.deepOrangeAccent,
                        ),
                      );
                    }
                    if (_valueIsUrl(value)) {
                      return PropertyOverrides(
                        style: style.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      );
                    }
                    if (value == null) {
                      return PropertyOverrides(
                        style: style.copyWith(
                          color: Colors.grey,
                        ),
                      );
                    }
                    return PropertyOverrides(
                      style: style,
                    );
                  },

                  /// Theme definitions of the json explorer
                  theme: JsonExplorerTheme(
                    rootKeyTextStyle: GoogleFonts.inconsolata(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    propertyKeyTextStyle: GoogleFonts.inconsolata(
                      color: Colors.black.withAlpha(180),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    keySearchHighlightTextStyle: GoogleFonts.inconsolata(
                      color: Colors.black,
                      backgroundColor: const Color(0xFFFFEDAD),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedKeySearchHighlightTextStyle: GoogleFonts.inconsolata(
                      color: Colors.black,
                      backgroundColor: const Color(0xFFF29D0B),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    valueTextStyle: GoogleFonts.inconsolata(
                      color: const Color(0xFFCA442C),
                      fontSize: 16,
                    ),
                    valueSearchHighlightTextStyle: GoogleFonts.inconsolata(
                      color: const Color(0xFFCA442C),
                      backgroundColor: const Color(0xFFFFEDAD),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedValueSearchHighlightTextStyle:
                        GoogleFonts.inconsolata(
                      color: Colors.black,
                      backgroundColor: const Color(0xFFF29D0B),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    indentationLineColor: const Color(0xFFE1E1E1),
                    highlightColor: const Color(0xFFF1F1F1),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: IconButton.filled(
                    iconSize: 16,
                    onPressed: state.areAllExpanded()
                        ? state.collapseAll
                        : state.expandAll,
                    icon: Icon(
                      state.areAllExpanded()
                          ? Icons.close_fullscreen_rounded
                          : Icons.open_in_full_rounded,
                    ),
                    tooltip:
                        state.areAllExpanded() ? 'Collapse All' : 'Expand All',
                  ),
                ),
              ),
              if (widget.isLoading)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Colors.black12,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  bool _valueIsUrl(dynamic value) {
    if (value is String) {
      return Uri.tryParse(value)?.hasAbsolutePath ?? false;
    }
    return false;
  }

  Future _updateJsonData(String? data) async {
    final dynamic decoded = TypeUtils.tryParseJson(data);
    await store.buildNodes(decoded);
  }
}
