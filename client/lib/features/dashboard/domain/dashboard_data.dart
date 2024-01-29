import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DashboardData extends Equatable {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final int index;

  const DashboardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color = Colors.blue,
    required this.index,
  });

  static List<DashboardData> get dashboardData {
    return [
      const DashboardData(
        title: 'Patients',
        subtitle: 'You have 1 patients',
        icon: Icons.people,
        color: Colors.blue,
        index: 2,
      ),
      const DashboardData(
        title: 'Requests',
        subtitle: 'You have 2 requests',
        icon: Icons.request_page,
        color: Colors.red,
        index: 1,
      ),
      const DashboardData(
        title: 'Appointments',
        subtitle: 'You have 0 appointments',
        icon: Icons.approval,
        color: Colors.green,
        index: 3,
      ),
      const DashboardData(
        title: 'Accounts',
        subtitle: 'You have 2 accounts',
        icon: Icons.account_circle,
        color: Colors.orange,
        index: 4,
      ),
    ];
  }

  @override
  List<Object?> get props => [
        title,
        subtitle,
        icon,
      ];

  @override
  bool get stringify => true;
}
