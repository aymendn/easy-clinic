import 'package:client/features/patients/domain/patient_model.dart';
import 'package:client/utils/timout_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final patientsControllerProvider =
    StateNotifierProvider<PatientsController, PatientsState>(
  (ref) => PatientsController(),
);

class PatientsController extends StateNotifier<PatientsState> {
  PatientsController()
      : super(
          const PatientsState(
            patients: AsyncLoading(),
            updatePatient: AsyncData(null),
          ),
        ) {
    getPatients();
  }

  Future<void> getPatients() async {
    state = state.setPatients(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.setPatients(AsyncData(PatientModel.serverResponseData));
  }

  Future<void> acceptPatient(int id) async {
    state = state.setUpdatePatient(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.copyWith(
      patients: AsyncData(
        (state.patients.asData?.value ?? []).where((e) => e.id != id).toList(),
      ),
      updatePatient: const AsyncData(null),
    );
  }

  Future<void> rejectPatient(int id) async {
    state = state.setUpdatePatient(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.copyWith(
      patients: AsyncData(
        (state.patients.asData?.value ?? []).where((e) => e.id != id).toList(),
      ),
      updatePatient: const AsyncData(null),
    );
  }
}

class PatientsState extends Equatable {
  final AsyncValue<List<PatientModel>> patients;
  final AsyncValue updatePatient;

  const PatientsState({
    required this.patients,
    required this.updatePatient,
  });

  PatientsState copyWith({
    AsyncValue<List<PatientModel>>? patients,
    AsyncValue? updatePatient,
  }) {
    return PatientsState(
      patients: patients ?? this.patients,
      updatePatient: updatePatient ?? this.updatePatient,
    );
  }

  PatientsState setPatients(AsyncValue<List<PatientModel>> patients) {
    return copyWith(patients: patients);
  }

  PatientsState setUpdatePatient(AsyncValue updatePatient) {
    return copyWith(updatePatient: updatePatient);
  }

  @override
  List<Object?> get props => [
        patients,
        updatePatient,
      ];

  @override
  bool get stringify => true;
}
