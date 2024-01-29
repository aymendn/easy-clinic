import 'package:client/features/requests/domain/request_model.dart';
import 'package:client/utils/timout_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final requestsControllerProvider =
    StateNotifierProvider<RequestsController, RequestsState>(
  (ref) => RequestsController(),
);

class RequestsController extends StateNotifier<RequestsState> {
  RequestsController()
      : super(
          const RequestsState(
            requests: AsyncLoading(),
            updateRequest: AsyncData(null),
          ),
        ) {
    getRequests();
  }

  Future<void> getRequests() async {
    state = state.setRequests(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.setRequests(AsyncData(RequestModel.serverResponseData));
  }

  Future<void> acceptRequest(int id) async {
    state = state.setUpdateRequest(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.copyWith(
      requests: AsyncData(
        (state.requests.asData?.value ?? []).where((e) => e.id != id).toList(),
      ),
      updateRequest: const AsyncData(null),
    );
  }

  Future<void> rejectRequest(int id) async {
    state = state.setUpdateRequest(const AsyncLoading());
    await TimeoutHandler.handleTimeout();
    state = state.copyWith(
      requests: AsyncData(
        (state.requests.asData?.value ?? []).where((e) => e.id != id).toList(),
      ),
      updateRequest: const AsyncData(null),
    );
  }
}

class RequestsState extends Equatable {
  final AsyncValue<List<RequestModel>> requests;
  final AsyncValue updateRequest;

  const RequestsState({
    required this.requests,
    required this.updateRequest,
  });

  RequestsState copyWith({
    AsyncValue<List<RequestModel>>? requests,
    AsyncValue? updateRequest,
  }) {
    return RequestsState(
      requests: requests ?? this.requests,
      updateRequest: updateRequest ?? this.updateRequest,
    );
  }

  RequestsState setRequests(AsyncValue<List<RequestModel>> requests) {
    return copyWith(requests: requests);
  }

  RequestsState setUpdateRequest(AsyncValue updateRequest) {
    return copyWith(updateRequest: updateRequest);
  }

  @override
  List<Object?> get props => [
        requests,
        updateRequest,
      ];

  @override
  bool get stringify => true;
}
