import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_colors.dart';

class AddEditIcon extends StatelessWidget {
  final bool addIcon;
  final GestureTapCallback? onTap;

  const AddEditIcon({
    super.key,
    required this.addIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16.r,
              blurStyle: BlurStyle.outer,
            )
          ],
          color: AppColors.bgColor,
        ),
        padding: EdgeInsets.all(8.r),
        child: Icon(
          addIcon ? Icons.add_box_outlined : Icons.edit,
        ),
      ),
    );
  }
}
