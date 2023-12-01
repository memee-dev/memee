import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/product_cubit/product_cubit.dart';
import 'package:memee/core/utils/app_di.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Products',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocProvider(
        create: (context) => locator.get<ProductCubit>()..fetchProducts(),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductSuccess) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w,
                ),
                itemBuilder: (_, i) {
                  //final e = state.products[i];
                  return Container();
                },
                itemCount: state.products.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 8.h,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
