import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/order/domain/entities/order_entity.dart';
import 'package:stylish_app/features/order/domain/use_cases/get_my_orders_use_case.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  final GetMyOrdersUseCase getMyOrdersUseCase;
  final FirebaseAuth auth;

  MyOrdersCubit({
    required this.getMyOrdersUseCase,
    required this.auth,
  }) : super(const MyOrdersState());

  Future<void> fetchMyOrders() async {
    final user = auth.currentUser;
    if (user == null) {
      emit(
        state.copyWith(
          status: MyOrdersStatus.error,
          failure: const AuthFailure(
            code: 'unauthenticated',
            message: 'User is not authenticated.',
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(status: MyOrdersStatus.loading));

    final result = await getMyOrdersUseCase.call(userId: user.uid);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MyOrdersStatus.error,
          failure: failure,
        ),
      ),
      (orders) {
        if (orders.isEmpty) {
          emit(
            state.copyWith(
              status: MyOrdersStatus.empty,
              orders: const [],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: MyOrdersStatus.success,
              orders: orders,
            ),
          );
        }
      },
    );
  }
}
