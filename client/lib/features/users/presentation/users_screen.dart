import 'package:client/common_widgets/async_value_builder.dart';
import 'package:client/common_widgets/primary_button.dart';
import 'package:client/common_widgets/table/table_view.dart';
import 'package:client/features/users/domain/user_model.dart';
import 'package:client/features/users/presentation/users_controller.dart';
import 'package:client/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

// final int id;
// final String email;
// final String password;
// final List<String> permissions;

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(usersControllerProvider);
    final notifier = ref.read(usersControllerProvider.notifier);

    void onDeletePressed(int id) async {
      final isProceed = await context
          .confirmDialog('Are you sure you want to delete this user?');
      if (isProceed) {
        notifier.rejectUser(id);
      }
    }

    return AsyncValueBuilder(
      fakeValue: UserModel.serverResponseData,
      value: controller.users,
      data: (users) {
        return TableView<UserModel>(
          isLoading: controller.updateUser.isLoading,
          title: "Users",
          subtitle: "All users",
          list: users,
          columnsNames: const [
            "ID",
            "Email",
            "Hashed Password",
            "Permissions",
            "Actions",
          ],
          buildCell: (object) => {
            "ID": object.id.toString(),
            "Email": object.email,
            "Hashed Password": object.hashedPassword,
            "Permissions": object.permissionsString,
            "Actions": "",
          },
          buildCellRenderer: {
            "Actions": (object) {
              return FittedBox(
                fit: BoxFit.scaleDown,
                child: Skeleton.ignore(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrimaryButton(
                      onPressed: () => onDeletePressed(object.id),
                      backgroundColor: Colors.red,
                      text: "Delete Account",
                      icon: Icons.person_remove,
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
