import 'package:client/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class DrawerItemModel {
  final String title;
  final IconData icon;
  final AppRoute route;

  DrawerItemModel({
    required this.title,
    required this.icon,
    required this.route,
  });

  static List<DrawerItemModel> get items => [
        DrawerItemModel(
          title: 'Home',
          icon: Symbols.home_filled_rounded,
          route: AppRoute.home,
        ),
        DrawerItemModel(
          title: 'Requests',
          icon: Symbols.list,
          route: AppRoute.patients,
        ),
        DrawerItemModel(
          title: 'Patients',
          icon: Symbols.person_filled_rounded,
          route: AppRoute.patients,
        ),
        DrawerItemModel(
          title: 'Appointments',
          icon: Symbols.calendar_clock_rounded,
          route: AppRoute.appointments,
        ),
        DrawerItemModel(
          title: 'Manage Accounts',
          icon: Symbols.person_add_rounded,
          route: AppRoute.appointments,
        ),
      ];

  static List<NavigationDrawerDestination> get destinations => items
      .map(
        (item) => NavigationDrawerDestination(
          label: Text(item.title),
          icon: Icon(item.icon),
          selectedIcon: Icon(item.icon, fill: 1),
        ),
      )
      .toList();
}
