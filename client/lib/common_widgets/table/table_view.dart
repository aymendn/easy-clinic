import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'no_items.dart';

class TableView<T> extends ConsumerWidget {
  const TableView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.list,
    required this.columnsNames,
    required this.buildCell,
    this.buildCellRenderer = const {},
    this.onTap,
    this.noRowsWidget = const NoItems(),
    this.actions = const [],
    this.onLoaded,
    this.pdfTitle,
    this.enterKeyAction,
    this.isLoading = false,
  });

  final String title;
  final String subtitle;
  final List<Widget> actions;
  final List<String> columnsNames;
  final Map<String, String> Function(T object) buildCell;
  // renderer
  final Map<String, Widget Function(T object)> buildCellRenderer;
  final List<T> list;
  final void Function(int index, PlutoGridOnSelectedEvent event)? onTap;
  final Widget? noRowsWidget;
  final void Function(PlutoGridOnLoadedEvent)? onLoaded;
  final String? pdfTitle;
  final VoidCallback? enterKeyAction;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PlutoCell getCell(String columnName, T object) {
      return PlutoCell(value: buildCell(object)[columnName]);
    }

    final columns = [
      for (final columnName in columnsNames)
        PlutoColumn(
          title: columnName,
          field: columnName,
          type: PlutoColumnType.text(),
          textAlign: PlutoColumnTextAlign.center,
          titleSpan: TextSpan(
            children: [
              TextSpan(
                text: columnName,
                style: TextStyle(
                  fontSize: getFontSize(columnName.length),
                ),
              ),
            ],
          ),
          renderer: (rendererContext) {
            final rowIndex = rendererContext.rowIdx;
            final columnName = rendererContext.column.field;
            final object = list[rowIndex];

            if (buildCellRenderer.containsKey(columnName)) {
              return buildCellRenderer[columnName]!(object);
            }

            final cellTextContent = buildCell(object)[columnName] ?? '';
            return Text(
              cellTextContent,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getFontSize(cellTextContent.length),
              ),
            );
          },
        ),
    ];

    final rows = [
      for (final object in list)
        PlutoRow(
          cells: {
            for (final columnName in columnsNames)
              columnName: getCell(columnName, object),
          },
        ),
    ];

    final content = Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              const Spacer(),
              if (actions.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: actions,
                ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 20),
            child: PlutoGrid(
              key: ValueKey("$list"),
              mode: PlutoGridMode.select,
              columns: columns,
              rows: rows,
              onLoaded: (event) {
                event.stateManager.setSelectingMode(PlutoGridSelectingMode.row);
                onLoaded?.call(event);
              },
              noRowsWidget: noRowsWidget,
              onSelected: (event) {
                final currentIndex = event.row?.sortIdx;

                if (currentIndex != null) {
                  onTap?.call(currentIndex, event);
                }
              },
              configuration: PlutoGridConfiguration(
                shortcut: enterKeyAction == null
                    ? const PlutoGridShortcut()
                    : PlutoGridShortcut(
                        actions: {
                          // This is a Map with basic shortcut keys and actions set.
                          ...PlutoGridShortcut.defaultActions,
                          // You can override the enter key behavior as below.
                          LogicalKeySet(LogicalKeyboardKey.enter):
                              CustomEnterKeyAction(enterKeyAction!),
                        },
                      ),
                columnSize: const PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.scale,
                ),
                style: const PlutoGridStyleConfig(
                  gridBorderRadius: BorderRadius.all(Radius.circular(4)),
                  defaultCellPadding: EdgeInsets.zero,
                  activatedBorderColor: Color.fromARGB(50, 0, 0, 0),
                  borderColor: Color.fromARGB(50, 0, 0, 0),
                ),
                columnFilter: PlutoGridColumnFilterConfig(
                  debounceMilliseconds: 0,
                  filters: [
                    ...FilterHelper.defaultFilters,
                  ],
                  resolveDefaultColumnFilter: (column, resolver) {
                    return resolver<PlutoFilterTypeContains>()
                        as PlutoFilterType;
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Stack(
      children: [
        AnimatedOpacity(
          opacity: isLoading ? 0.4 : 1,
          duration: const Duration(milliseconds: 260),
          child: IgnorePointer(
            ignoring: isLoading,
            child: content,
          ),
        ),
        AnimatedOpacity(
          opacity: isLoading ? 1 : 0,
          duration: const Duration(milliseconds: 260),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

double getFontSize(int lenght) {
  if (lenght > 10) return 12;
  if (lenght > 8) return 13;
  return 14;
}

// Create a new class that inherits from PlutoGridShortcutAction
// If the execute method is implemented,
// the implemented method is executed when the enter key is pressed.
class CustomEnterKeyAction extends PlutoGridShortcutAction {
  final VoidCallback action;

  CustomEnterKeyAction(this.action);

  @override
  void execute({
    required PlutoKeyManagerEvent keyEvent,
    required PlutoGridStateManager stateManager,
  }) {
    action();
  }
}
