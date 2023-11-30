import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/initializer/app_router.dart';
import 'package:memee/core/shared/app_strings.dart';
import 'package:memee/ui/__shared/widgets/confirmation_dialog.dart';
import 'package:memee/ui/cart/cart_screen.dart';
import 'package:memee/ui/home/home_widget.dart';
import 'package:memee/ui/home/widgets/bottom_navigation_bar.dart';
import 'package:memee/ui/home/widgets/location_appbar.dart';
import 'package:memee/ui/profile/profile_widget.dart';

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
      appBar: LocationAppbar(
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
        builder: (context, state) {
          return HomeBottomNavigation(
            index: state,
            onTap: (int index) => indexCubit..onIndexChange(index),
          );
        },
      ),
    );
  }
}
