import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model/category_model.dart';
import 'package:shop_app/modules/main_screens/category_product_screen/cubit/cubit.dart';
import 'package:shop_app/modules/main_screens/category_product_screen/cubit/states.dart';
import 'package:shop_app/modules/main_screens/category_product_screen/widgets/widgets.dart';
import 'package:shop_app/modules/main_screens/detail_screen/ui/detail_screen.dart';
import 'package:shop_app/shared/componants.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key, this.categoryData});

  final CategoryData? categoryData;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryProductCubit>(context, listen: false)
        .getCategoryProductsData(categoryData!.id!, context);
    return BlocConsumer<CategoryProductCubit, CategoryProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CategoryProductCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: buildBodyText(
                text: "Products",
                textColor: Colors.black,
              ),
              centerTitle: false,
            ),
            body: state is ProductLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is ProductFailureState
                    ? Center(
                        child: buildTitleText(text: state.failure),
                      )
                    : cubit.categoryProductsModel != null
                        ? cubit.categoryProductsModel!.data!.data!.isEmpty
                            ? Center(
                                child: buildBodyText(text: "No Data"),
                              )
                            : ListView.builder(
                                itemCount: cubit
                                    .categoryProductsModel!.data!.data!.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return buildCategoryProductsList(
                                      model: cubit.categoryProductsModel!.data!
                                          .data![index],
                                      context: context,
                                      index: index,
                                      productOnTap: () {
                                        navigateTo(
                                            context,
                                            DetailScreen(
                                                productId:
                                                    CategoryProductCubit.get(
                                                            context)
                                                        .categoryProductsModel!
                                                        .data!
                                                        .data![index]
                                                        .id));
                                      });
                                })
                        : Container());
      },
    );
  }
}
