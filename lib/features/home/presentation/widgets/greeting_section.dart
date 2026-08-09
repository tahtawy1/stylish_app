import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/utils/greeting_helper.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:stylish_app/features/home/presentation/widgets/notification_button.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key, this.onNotificationTap});

  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getGreeting(context),
              style: context.textStyle.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final isLoading = state.status == HomeStatus.loading;
                return Skeletonizer(
                  enabled: isLoading,
                  child: Text(
                    state.userName,
                    style: context.textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.onSurface,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        NotificationButton(onTap: onNotificationTap),
      ],
    );
  }
}
