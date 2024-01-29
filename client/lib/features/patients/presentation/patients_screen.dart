import 'package:client/common_widgets/async_value_builder.dart';
import 'package:client/common_widgets/table/table_view.dart';
import 'package:client/extensions/date_extensions.dart';
import 'package:client/extensions/t_extensions.dart';
import 'package:client/features/patients/domain/patient_model.dart';
import 'package:client/features/patients/presentation/patients_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientsScreen extends ConsumerWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(patientsControllerProvider);
    final notifier = ref.read(patientsControllerProvider.notifier);

    return AsyncValueBuilder(
      fakeValue: PatientModel.serverResponseData.firstOrNull?.makeList() ?? [],
      value: controller.patients,
      data: (patients) {
        return TableView<PatientModel>(
          isLoading: controller.updatePatient.isLoading,
          title: "Patients",
          subtitle: "All patients",
          list: patients,
          columnsNames: const [
            "ID",
            "Full Name",
            "Phone Number",
            "Email",
            "Address",
            "Birth Date",
          ],
          buildCell: (object) => {
            "ID": object.id.toString(),
            "Full Name": object.fullName,
            "Phone Number": object.phoneNumber,
            "Email": object.email,
            "Address": object.address,
            "Birth Date": object.birthDate.formatDMY(),
          },
        );
      },
    );
  }
}
