import 'package:client/common_widgets/async_value_builder.dart';
import 'package:client/common_widgets/primary_button.dart';
import 'package:client/common_widgets/table/table_view.dart';
import 'package:client/features/requests/domain/request_model.dart';
import 'package:client/features/requests/presentation/requests_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RequestsScreen extends ConsumerWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(requestsControllerProvider);
    final notifier = ref.read(requestsControllerProvider.notifier);

    return AsyncValueBuilder(
      fakeValue: RequestModel.serverResponseData,
      value: controller.requests,
      data: (requests) {
        return TableView<RequestModel>(
          isLoading: controller.updateRequest.isLoading,
          title: "Requests",
          subtitle: "All requests",
          list: requests,
          columnsNames: const [
            "ID",
            "Patient ID",
            "Date",
            "Patient Status",
            "Request Status",
            "Message",
            "Actions",
          ],
          buildCell: (object) => {
            "ID": object.id.toString(),
            "Patient ID": object.patientId.toString(),
            "Date": object.date.toString(),
            "Patient Status": object.patientStatus,
            "Request Status": object.requestStatus,
            "Message": object.message,
            "Actions": "",
          },
          buildCellRenderer: {
            "Actions": (object) {
              return Skeleton.ignore(
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        PrimaryButton(
                          onPressed: () => notifier.acceptRequest(object.id),
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.check),
                        ),
                        const SizedBox(width: 8),
                        PrimaryButton(
                          onPressed: () => notifier.rejectRequest(object.id),
                          backgroundColor: Colors.red,
                          child: const Icon(Icons.close),
                        ),
                      ],
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
