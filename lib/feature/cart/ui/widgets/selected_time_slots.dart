import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/utility/utility_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/add_edit_icon_button.dart';

class SelectedTimeSlots extends StatelessWidget {
  const SelectedTimeSlots({super.key});

  @override
  Widget build(BuildContext context) {
    final _slots = locator.get<UtilityCubit>();
    return BlocBuilder<UtilityCubit, UtilityState>(
      bloc: _slots,
      builder: (context, state) {
        return Column(
          children: [
            InkWell(
              onTap: ()=> _slots.reset(),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Change',
                  style: Theme.of(context).textTheme.textSMSemibold,
                ),
              ).paddingS(v: 4.h),
            ),
            Row(
              children: [
                if (_slots.selectedTime == null)
                  Expanded(
                    child: InkWell(
                      onTap: () => _slots.setInstantDelivery(),
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
                            ),
                          ],
                          color: _slots.instantDelivery
                              ? AppColors.errorColor
                              : AppColors.bgColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.h, vertical: 14.h),
                        child: Text(
                          AppStrings.instantDelivery + (_slots.instantDelivery ? '\t(90 Mins)': ''),
                          style:
                              Theme.of(context).textTheme.textMDMedium.copyWith(
                                    color: _slots.instantDelivery
                                        ? AppColors.bgColor
                                        : AppColors.displayColor,
                                  ),
                        ).paddingH(),
                      ),
                    ),
                  ),
                SizedBox(width: 4.w),
                if (!_slots.instantDelivery)
                  Expanded(
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
                          ),
                        ],
                        color: AppColors.bgColor,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              (_slots.selectedTime ?? '').isNotEmpty
                                  ? (_slots.selectedTime ?? '')
                                  : 'Time slot',
                              style: Theme.of(context).textTheme.textMDMedium,
                            ).paddingH(),
                          ),
                          AddEditIcon(
                            onTap: () {
                              _slots.compareCurrentTimeWithTimeSlots();
                              showCupertinoModalPopup(
                                context: context,
                                barrierDismissible: true,
                                builder: (_) {
                                  return CupertinoActionSheet(
                                    title: Text(
                                      'Tap to select slots',
                                      style: Theme.of(context)
                                          .textTheme
                                          .textMDSemibold,
                                    ).paddingV(),
                                    message: _slots.slotError.isNotEmpty
                                        ? Text(
                                            _slots.slotError,
                                            style: Theme.of(context)
                                                .textTheme
                                                .textMDMedium
                                                .copyWith(
                                                  color: AppColors.errorColor,
                                                ),
                                          )
                                        : null,
                                    actions: _slots.availableSlots
                                        .map(
                                          (e) => CupertinoActionSheetAction(
                                            onPressed: () {
                                              _slots.setSelectedTime(e.time);
                                              Routes.pop(context);
                                            },
                                            child: Text(
                                              e.time,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .textSMMedium
                                                  .copyWith(
                                                    color:
                                                        AppColors.displayColor,
                                                  ),
                                            ),
                                          ).paddingS(v: 4.h),
                                        )
                                        .toList(),
                                  );
                                },
                              );
                            },
                            addIcon: (_slots.selectedTime ?? '').isEmpty,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ).gapBottom(8.h),
          ],
        );
      },
    );
  }
}
