import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/feature/home/widgets/product_item.dart';

class FavouriteWidget extends StatelessWidget {
  const FavouriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = locator.get<UserCubit>();
    return BlocBuilder<UserCubit, UserState>(
      bloc: _user,
      builder: (context, state) {
        if (state == UserState.success) {
          return (_user.currentUser?.favourites ?? []).isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    final e = _user.currentUser?.favourites?[i];
                    return HomeProductItem(
                      product: _user.currentUser!.favourites![i],
                      width: MediaQuery.of(context).size.width.w,
                      onTap: () {
                        Routes.push(
                          context,
                          Routes.productDetails,
                          extra: e,
                        );
                      },
                    ).gapBottom(16.h);
                  },
                  itemCount: (_user.currentUser?.favourites ?? []).length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 8.h,
                  ),
                ).paddingS()
              : Container();
        }

        return const SizedBox.shrink();
      },
    );
  }
}
