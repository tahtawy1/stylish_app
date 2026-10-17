import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/extensions/failure_extension.dart';
import 'package:stylish_app/core/widgets/app_button.dart';
import 'package:stylish_app/features/order/presentation/view_model/my_orders_cubit/my_orders_cubit.dart';
import 'package:stylish_app/features/order/presentation/widgets/order_card.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyOrdersCubit>()..fetchMyOrders(),
      child: const _MyOrdersBody(),
    );
  }
}

class _MyOrdersBody extends StatelessWidget {
  const _MyOrdersBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
          color: context.colors.onSurface,
        ),
        title: Text(
          context.l10n.myOrders,
          style: context.textStyle.titleMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.isError) {
            final message = state.failure?.toMessage(context) ??
                context.l10n.unexpectedError;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 54,
                      color: context.colors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: context.textStyle.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 140,
                      child: AppButton(
                        title: 'Retry',
                        onPressed: () =>
                            context.read<MyOrdersCubit>().fetchMyOrders(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.isEmpty || state.orders.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: context.colors.primary.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.receipt_long_rounded,
                        size: 40,
                        color: context.colors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.noOrders,
                      textAlign: TextAlign.center,
                      style: context.textStyle.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<MyOrdersCubit>().fetchMyOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              itemCount: state.orders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return OrderCard(order: order);
              },
            ),
          );
        },
      ),
    );
  }
}
