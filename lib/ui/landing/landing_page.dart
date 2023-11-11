import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/ui/home/home_screen.dart';
import 'package:memee/ui/home/widgets/bottom_navigation_bar.dart';
import 'package:memee/ui/home/widgets/location_appbar.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final IndexCubit indexCubit = locator.get<IndexCubit>();
  final IndexCubit carousel = locator.get<IndexCubit>();

  final List<Widget> screens = [
    HomeScreen(),
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
    Container(
      height: 100,
      width: 200,
      color: Colors.amberAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LocationAppbar(),
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