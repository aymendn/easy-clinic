import 'package:client/common_widgets/async_value_builder.dart';
import 'package:client/common_widgets/primary_button.dart';
import 'package:client/common_widgets/table/table_view.dart';
import 'package:client/extensions/t_extensions.dart';
import 'package:client/features/appointments/domain/appointment_model.dart';
import 'package:client/features/appointments/presentation/appointments_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

// final int id;
// final String fullName;
// final DateTime date;
// final String patientStatus;
// final int age;
// final String email;

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(apppointmentsControllerProvider);
    final notifier = ref.read(apppointmentsControllerProvider.notifier);

    return AsyncValueBuilder(
      fakeValue: AppointmentModel.serverResponseData.firstOrNull?.makeList(),
      value: controller.apppointments,
      data: (appointments) {
        return TableView<AppointmentModel>(
          isLoading: controller.updateAppointment.isLoading,
          title: "Appointments",
          subtitle: "All Appointments",
          list: appointments,
          columnsNames: const [
            "ID",
            "Full Name",
            "Date",
            "Patient Status",
            "Age",
            "Email",
            "Actions",
          ],
          buildCell: (object) => {
            "ID": object.id.toString(),
            "Full Name": object.fullName,
            "Date": object.date.toString(),
            "Patient Status": object.patientStatus,
            "Age": object.age.toString(),
            "Email": object.email,
            "Actions": "",
          },
          buildCellRenderer: {
            "Actions": (object) {
              return Skeleton.ignore(
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: PrimaryButton(
                      onPressed: () => notifier.acceptAppointment(object.id),
                      backgroundColor: Colors.blue,
                      text: "Finish",
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
