import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/main_screens/category_product_screen/ui/category_products_screen.dart';
import 'package:shop_app/modules/main_screens/detail_screen/ui/detail_screen.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/states.dart';
import 'package:shop_app/modules/main_screens/home_screen/widgets/widgets.dart';
import 'package:shop_app/shared/componants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {
      if (state is ChangeFavouriteSuccessState) {
        state.changeFavouriteModel.status == false
            ? buildToast(
                msg: state.changeFavouriteModel.message ?? "",
                states: ToastStates.ERROR)
            : buildToast(
                msg: state.changeFavouriteModel.message ?? "",
                states: ToastStates.SUCCESS);
      }
    }, builder: (context, state) {
      var cubit = HomeLayoutCubit.get(context);
      if (state is HomeLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is HomeFailureState && state is CategoryFailureState) {
        return Center(
          child: buildTitleText(text: state.error),
        );
      } else if (cubit.homeModel != null && cubit.categoryModel != null) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cubit.homeModel!.data!.banners!.isEmpty
                    ? Center(
                        child: buildBodyText(text: "no data"),
                      )
                    : buildHomeBanners(cubit.homeModel!),
                const SizedBox(
                  height: 12.0,
                ),
                buildBodyText(text: "Categories", textColor: Colors.black),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.categoryModel?.data?.data?.length,
                      itemBuilder: (context, index) {
                        return cubit.categoryModel!.data!.data!.isEmpty
                            ? Center(
                                child: buildBodyText(text: "no data"),
                              )
                            : buildCategoryHomeListItem(
                                model: cubit.categoryModel!.data!.data![index],
                                categoryOnTap: () {
                                  navigateTo(
                                    context,
                                    CategoryProductsScreen(
                                      categoryData: cubit
                                          .categoryModel!.data!.data![index],
                                    ),
                                  );
                                });
                      }),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                buildBodyText(text: "New Products", textColor: Colors.black),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  color: Colors.white,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.2,
                    mainAxisSpacing: 1.2,
                    childAspectRatio: 1 / 1.9,
                    children: List.generate(
                      cubit.homeModel?.data?.newProducts?.length ?? 0,
                      (index) => cubit.homeModel!.data!.newProducts!.isEmpty
                          ? Center(
                              child: buildBodyText(text: "no data"),
                            )
                          : buildProductGrid(
                              model: cubit.homeModel!.data!.newProducts![index],
                              context: context,
                              newProductOnTap: () {
                                navigateTo(
                                  context,
                                  DetailScreen(
                                    productId: HomeLayoutCubit.get(context)
                                        .homeModel!
                                        .data!
                                        .newProducts![index]
                                        .id,
                                  ),
                                );
                              }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator(),);
      }
    });
  }
}
