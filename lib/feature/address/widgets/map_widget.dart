import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/map_cubit/map_cubit.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:shimmer/shimmer.dart';

class MapWidget extends StatelessWidget {
  MapWidget({super.key});

  final mapCubit = locator.get<MapCubit>();

  //final controller = MapController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.r,
        ),
        color: Colors.amberAccent,
      ),
      child: BlocProvider<MapCubit>(
        create: (context) => mapCubit.determinePosition(),
        child: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            if (state is MapLoading) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                    color: Colors.amberAccent,
                  ),
                ),
              );
            } else if (state is MapSuccess) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
                child: Container(),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    ).gapBottom(
      24.h,
    );
  }
}
