import 'package:client/features/users/domain/user_model.dart';
import 'package:client/utils/timout_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final usersControllerProvider =
    StateNotifierProvider<UsersController, UsersState>(
  (ref) => UsersController(),
);

class UsersController extends StateNotifier<UsersState> {
  UsersController()
      : super(
          const UsersState(
            users: AsyncLoading(),
            updateUser: AsyncData(null),
          ),
        ) {
    getUsers();
  }

  Future<void> getUsers() async {
    state = state.setUsers(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.setUsers(AsyncData(UserModel.serverResponseData));
  }

  Future<void> acceptUser(int id) async {
    state = state.setUpdateUser(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.copyWith(
      users: AsyncData(
        (state.users.asData?.value ?? []).where((e) => e.id != id).toList(),
      ),
      updateUser: const AsyncData(null),
    );
  }

  Future<void> rejectUser(int id) async {
    state = state.setUpdateUser(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.copyWith(
      users: AsyncData(
        (state.users.asData?.value ?? []).where((e) => e.id != id).toList(),
      ),
      updateUser: const AsyncData(null),
    );
  }
}

class UsersState extends Equatable {
  final AsyncValue<List<UserModel>> users;
  final AsyncValue updateUser;

  const UsersState({
    required this.users,
    required this.updateUser,
  });

  UsersState copyWith({
    AsyncValue<List<UserModel>>? users,
    AsyncValue? updateUser,
  }) {
    return UsersState(
      users: users ?? this.users,
      updateUser: updateUser ?? this.updateUser,
    );
  }

  UsersState setUsers(AsyncValue<List<UserModel>> users) {
    return copyWith(users: users);
  }

  UsersState setUpdateUser(AsyncValue updateUser) {
    return copyWith(updateUser: updateUser);
  }

  @override
  List<Object?> get props => [
        users,
        updateUser,
      ];

  @override
  bool get stringify => true;
}
