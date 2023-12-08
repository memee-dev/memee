import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/confirmation_dialog.dart';
import 'package:memee/feature/cart/ui/cart_screen.dart';
import 'package:memee/feature/home/home_widget.dart';
import 'package:memee/feature/landing/widgets/bottom_navigation_bar.dart';
import 'package:memee/feature/landing/widgets/location_appbar.dart';
import 'package:memee/feature/profile/profile_widget.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final IndexCubit indexCubit = locator.get<IndexCubit>();
  final _userCubit = locator.get<UserCubit>();

  final List<Widget> screens = [
    HomeWidget(),
    Container(
      height: 100,
      width: 200,
      color: Colors.orange,
    ),
    CartScreen(),
    const ProfileWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LocationAppBar(
        indexCubit: indexCubit,
        onTap: () => Routes.push(context, Routes.savedAddress),
      ),
      body: BlocListener<UserCubit, UserState>(
        bloc: _userCubit,
        listener: (context, state) {
          if (state is CurrentUserState) {
            if (state.user.email.isEmpty && state.user.userName.isEmpty) {
              showCupertinoDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ConfirmationDialog(
                    title: AppStrings.attention,
                    description: AppStrings.additionalInformation,
                    buttonLabel1: AppStrings.addPersonalInfo,
                    positiveBtn: () {},
                    negativeBtn: () {
                      Routes.pop(context);
                      Routes.push(
                        context,
                        Routes.addUserInfo,
                        extra: {
                          'userName': _userCubit.currentUser.userName,
                          'userEmail': _userCubit.currentUser.email,
                          'phoneNo': _userCubit.currentUser.phoneNumber,
                        },
                      );
                    },
                  );
                },
              );
            }
          }
        },
        child: BlocBuilder<IndexCubit, int>(
          bloc: indexCubit,
          builder: (context, state) {
            return screens[state];
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<IndexCubit, int>(
        bloc: indexCubit,
        builder: (_, state) {
          return HomeBottomNavigation(
            index: state,
            onTap: (i) => indexCubit..onIndexChange(i),
          );
        },
      ),
    );
  }
}
