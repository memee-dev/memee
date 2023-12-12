import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/hide/bool_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _sms = locator.get<SwitchCubit>();
    final _notification = locator.get<SwitchCubit>();
    return ScaffoldTemplate(
      title: AppStrings.settings,
      body: Column(
        children: [
          BlocBuilder<SwitchCubit, bool>(
            bloc: _sms..getSmsValue(),
            builder: (context, state) {
              return _SettingsItem(
                label: 'SMS',
                icon: Icons.sms,
                value: state,
                onChanged: (value) {
                  _sms.setSmsValue(value);
                  _sms.change();
                },
              );
            },
          ),
          BlocBuilder<SwitchCubit, bool>(
            bloc: _notification..getNotificationValue(),
            builder: (context, state) {
              return _SettingsItem(
                label: 'Notification',
                icon: Icons.notifications_active,
                value: state,
                onChanged: (value) {
                  _notification.setNotificationValue(value);
                  _notification.change();
                },
              );
            },
          ),
        ],
      ).paddingS(v: 24.h, h: 24.w),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const _SettingsItem({
    required this.label,
    required this.icon,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: Icon(
            icon,
            size: 20.r,
            color: AppColors.textAccentDarkColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: Theme.of(context).textTheme.textMDMedium,
          ),
        ),
        Expanded(
          flex: 0,
          child: Switch(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    ).gapBottom(16.h);
  }
}
