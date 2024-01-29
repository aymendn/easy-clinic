import 'package:client/features/appointments/domain/appointment_model.dart';
import 'package:client/utils/timout_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apppointmentsControllerProvider =
    StateNotifierProvider<ApppointmentsController, ApppointmentsState>(
  (ref) => ApppointmentsController(),
);

class ApppointmentsController extends StateNotifier<ApppointmentsState> {
  ApppointmentsController()
      : super(
          const ApppointmentsState(
            apppointments: AsyncLoading(),
            updateAppointment: AsyncData(null),
          ),
        ) {
    getApppointments();
  }

  Future<void> getApppointments() async {
    state = state.setApppointments(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state =
        state.setApppointments(AsyncData(AppointmentModel.serverResponseData));
  }

  Future<void> acceptAppointment(int id) async {
    state = state.setUpdateAppointment(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.copyWith(
      apppointments: AsyncData(
        (state.apppointments.asData?.value ?? [])
            .where((e) => e.id != id)
            .toList(),
      ),
      updateAppointment: const AsyncData(null),
    );
  }

  Future<void> rejectAppointment(int id) async {
    state = state.setUpdateAppointment(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.copyWith(
      apppointments: AsyncData(
        (state.apppointments.asData?.value ?? [])
            .where((e) => e.id != id)
            .toList(),
      ),
      updateAppointment: const AsyncData(null),
    );
  }
}

class ApppointmentsState extends Equatable {
  final AsyncValue<List<AppointmentModel>> apppointments;
  final AsyncValue updateAppointment;

  const ApppointmentsState({
    required this.apppointments,
    required this.updateAppointment,
  });

  ApppointmentsState copyWith({
    AsyncValue<List<AppointmentModel>>? apppointments,
    AsyncValue? updateAppointment,
  }) {
    return ApppointmentsState(
      apppointments: apppointments ?? this.apppointments,
      updateAppointment: updateAppointment ?? this.updateAppointment,
    );
  }

  ApppointmentsState setApppointments(
      AsyncValue<List<AppointmentModel>> apppointments) {
    return copyWith(apppointments: apppointments);
  }

  ApppointmentsState setUpdateAppointment(AsyncValue updateAppointment) {
    return copyWith(updateAppointment: updateAppointment);
  }

  @override
  List<Object?> get props => [
        apppointments,
        updateAppointment,
      ];

  @override
  bool get stringify => true;
}
