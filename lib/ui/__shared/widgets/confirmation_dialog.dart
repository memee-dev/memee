import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/shared/app_strings.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title, buttonLabel1, buttonLabel2, description;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    super.key,
    this.title,
    this.buttonLabel1,
    this.buttonLabel2,
    this.description,
    this.onConfirm,
    this.onCancel,
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
          onPressed: onConfirm,
          child: Text(
            buttonLabel1 ?? AppStrings.confirm,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: onCancel,
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
