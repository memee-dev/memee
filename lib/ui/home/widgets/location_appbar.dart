import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class LocationAppbar extends StatelessWidget implements PreferredSizeWidget {
  final IndexCubit indexCubit;

  const LocationAppbar({Key? key, required this.indexCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexCubit, int>(
      bloc: indexCubit,
      builder: (context, state) {
        return SafeArea(
          child: state == 3
              ? const Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(),
                )
              : ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.home_filled,
                        color: Theme.of(context).colorScheme.primary,
                      ).gapRight(4.w),
                      Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ).gapRight(4.w),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'No. 1, New Bangaru Naidu Colony,K.K. Nagar (West), Chennai - 600078',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall,
                  ).paddingV(
                    v: 4.h,
                  ),
                ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        48.h,
      );
}
