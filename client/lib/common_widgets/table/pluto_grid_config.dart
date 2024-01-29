import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

final plutoGridConfig = PlutoGridConfiguration(
  columnSize: const PlutoGridColumnSizeConfig(
    autoSizeMode: PlutoAutoSizeMode.scale,
  ),
  style: const PlutoGridStyleConfig(
    gridBorderRadius: BorderRadius.all(Radius.circular(4)),
    evenRowColor: Color.fromARGB(8, 0, 0, 0),
  ),
  columnFilter: PlutoGridColumnFilterConfig(
    debounceMilliseconds: 0,
    filters: [
      ...FilterHelper.defaultFilters,
    ],
    resolveDefaultColumnFilter: (column, resolver) {
      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
    },
  ),
);
