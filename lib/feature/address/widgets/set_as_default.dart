import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetAsDefaultWidget extends StatelessWidget {
  final bool? isChecked;
  final ValueChanged<bool?>? onChanged;

  const SetAsDefaultWidget({super.key, this.isChecked = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              4.r,
            ),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: onChanged,
        ),
        Text(
          'Set as Default',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
