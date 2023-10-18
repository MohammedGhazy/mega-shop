import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/main_screens/categories_screen/widgets/widgets.dart';
import 'package:shop_app/modules/main_screens/category_product_screen/ui/category_products_screen.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/states.dart';
import 'package:shop_app/shared/componants.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return state is HomeLoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state is CategoryFailureState
                ? Center(
                    child: buildTitleText(text: state.failure),
                  )
                : cubit.categoryModel != null
                    ? cubit.categoryModel!.data!.data!.isEmpty
                        ? Center(
                            child: buildBodyText(text: "No Data"),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    cubit.categoryModel?.data?.data?.length,
                                itemBuilder: (context, index) {
                                  return buildCategoryListItem(
                                      model: cubit
                                          .categoryModel!.data!.data![index],
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          CategoryProductsScreen(
                                            categoryData: cubit.categoryModel!
                                                .data!.data![index],
                                          ),
                                        );
                                      });
                                }),
                          )
                    : Container();
      },
    );
  }
}
