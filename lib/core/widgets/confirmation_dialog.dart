import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/extensions/widget_extensions.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title, buttonLabel1, buttonLabel2, description;
  final VoidCallback? positiveBtn;
  final VoidCallback? negativeBtn;

  const ConfirmationDialog({
    super.key,
    this.title,
    this.buttonLabel1,
    this.buttonLabel2,
    this.description,
    this.positiveBtn,
    this.negativeBtn,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title ?? AppStrings.confirmationDialog,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ).gapBottom(8.h),
      content: Text(
        description ?? '',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: negativeBtn,
          child: Text(
            buttonLabel1 ?? AppStrings.confirm,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
        if (buttonLabel2 != null)
          CupertinoDialogAction(
            onPressed: positiveBtn,
            child: Text(
              buttonLabel2 ?? AppStrings.cancel,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
      ],
    );
  }
}
