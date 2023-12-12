import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/extensions/widget_extensions.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title, buttonLabel1, buttonLabel2, description;
  final VoidCallback? positiveBtn;
  final VoidCallback? negativeBtn;
  final Color? titleTextColor;

  const ConfirmationDialog({
    super.key,
    this.title,
    this.buttonLabel1,
    this.buttonLabel2,
    this.description,
    this.positiveBtn,
    this.negativeBtn,
    this.titleTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title ?? AppStrings.confirmationDialog,
        style: Theme.of(context).textTheme.textMDBold.copyWith(
              color: titleTextColor ?? AppColors.accentDarkColor,
            ),
      ).gapBottom(8.h),
      content: Text(
        description ?? '',
        style: Theme.of(context).textTheme.textSMRegular,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: negativeBtn,
          child: Text(
            buttonLabel1 ?? AppStrings.confirm,
            style: Theme.of(context).textTheme.textSMBold.copyWith(
                  color: AppColors.displayColor.withOpacity(0.5),
                ),
          ),
        ),
        if (buttonLabel2 != null)
          CupertinoDialogAction(
            onPressed: positiveBtn,
            child: Text(
              buttonLabel2 ?? AppStrings.cancel,
              style: Theme.of(context).textTheme.textSMBold.copyWith(
                    color: AppColors.textAccentDarkColor,
                  ),
            ),
          ),
      ],
    );
  }
}
