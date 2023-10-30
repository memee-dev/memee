import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/initializer/app_di.dart';

import '../../blocs/prayer_time/prayer_time_cubit.dart';
import 'widgets/namaz_time_widget.dart';

class HomeWidget extends StatelessWidget {
  //final PageController _pageController = PageController();

  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrayerTimeCubit>(
      create: (context) => locator.get<PrayerTimeCubit>()..fetchStudentData(),
      child: BlocConsumer<PrayerTimeCubit, PrayerTimeState>(
        listener: (_, state) {},
        builder: (_, state) {
          if (state is PrayerTimeLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is PrayerTimeFailure) {
            return Text(state.message);
          } else if (state is PrayerTimeSuccess) {
            return NamazTimeWidget(
              prayerTimeEntity: state.prayerTimeEntity,
              showBack: false,
              showNext: false,
              onBackTap: () {},
              onNextTap: () {},
            );

            // const int namazTimeDaysCount = 30;

            // return PageView(
            //   controller: _pageController,
            //   children: List.generate(
            //     namazTimeDaysCount,
            //     (index) => NamazTimeWidget(
            //       showBack: index > 0,
            //       showNext: index < namazTimeDaysCount - 1,
            //       onBackTap: () {
            //         _pageController.animateToPage(
            //           index - 1,
            //           duration: const Duration(milliseconds: 400),
            //           curve: Curves.easeInOut,
            //         );
            //       },
            //       onNextTap: () {
            //         _pageController.animateToPage(
            //           index + 1,
            //           duration: const Duration(milliseconds: 400),
            //           curve: Curves.easeInOut,
            //         );
            //       },
            //     ),
            //   ),
            // );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
