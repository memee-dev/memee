import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/initializer/app_router.dart';
import 'package:memee/ui/home/home_widget.dart';
import 'package:memee/ui/home/widgets/bottom_navigation_bar.dart';
import 'package:memee/ui/home/widgets/location_appbar.dart';
import 'package:memee/ui/profile/profile_widget.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final IndexCubit indexCubit = locator.get<IndexCubit>();
  final IndexCubit carousel = locator.get<IndexCubit>();

  final List<Widget> screens = [
    HomeWidget(),
    Container(
      height: 100,
      width: 200,
      color: Colors.orange,
    ),
    Container(
      height: 100,
      width: 200,
      color: Colors.teal,
    ),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LocationAppbar(
        indexCubit: indexCubit,
        onTap: () => Routes.appGoRouter(context, Routes.savedAddress),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
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
