part of 'my_orders_cubit.dart';

enum MyOrdersStatus { initial, loading, success, empty, error }

class MyOrdersState {
  final MyOrdersStatus status;
  final List<OrderEntity> orders;
  final Failure? failure;

  const MyOrdersState({
    this.status = MyOrdersStatus.initial,
    this.orders = const [],
    this.failure,
  });

  bool get isLoading =>
      status == MyOrdersStatus.initial || status == MyOrdersStatus.loading;
  bool get isSuccess => status == MyOrdersStatus.success;
  bool get isEmpty => status == MyOrdersStatus.empty;
  bool get isError => status == MyOrdersStatus.error;

  MyOrdersState copyWith({
    MyOrdersStatus? status,
    List<OrderEntity>? orders,
    Failure? failure,
  }) {
    return MyOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      failure: failure ?? this.failure,
    );
  }
}
