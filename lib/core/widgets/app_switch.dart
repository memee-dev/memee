import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/widget_extensions.dart';

import '../blocs/refresh_cubit.dart';
import '../utils/app_di.dart';

class AppSwitch extends StatelessWidget {
  final String? label;
  final bool value;
  final Function(bool) onTap;
  final bool enableEdit;
  final bool showConfirmationDailog;

  const AppSwitch({
    super.key,
    required this.value,
    this.label,
    required this.onTap,
    this.enableEdit = true,
    this.showConfirmationDailog = true,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = locator.get<RefreshCubit>();
    return BlocBuilder<RefreshCubit, bool>(
      bloc: cubit..initialValue(value),
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (label != null) Text(label!).gapRight(4.w),
            Switch(
              value: state,
              onChanged: (value) async {
                if (enableEdit) {
                  if (showConfirmationDailog) {
                    Navigator.pop(context);
                    _setSwitch(cubit, state);
                  } else {
                    cubit.change();
                    onTap(!state);
                    _setSwitch(cubit, state);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _setSwitch(RefreshCubit cubit, bool state) {
    cubit.change();
    onTap(!state);
  }
}
