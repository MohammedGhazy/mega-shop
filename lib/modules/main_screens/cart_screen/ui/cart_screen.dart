import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/modules/main_screens/cart_screen/widgets/widgets.dart';
import 'package:shop_app/shared/componants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: buildBodyText(
                  text: "My Cart", fontSize: 20.0, textColor: Colors.black),
              centerTitle: false,
            ),
            body: state is CartLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is CartFailureState
                    ? Center(
                        child: buildTitleText(text: state.failure),
                      )
                    : cubit.cartModel != null
                        ? cubit.cartModel!.data!.cartItems!.isEmpty
                            ? buildEmptyCartOrFavourite(
                                msg: 'there is no products in Cart...')
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: cubit.cartModel!.data!
                                              .cartItems!.length,
                                          itemBuilder: (context, index) {
                                            return buildCartProductsList(
                                                model: cubit.cartModel!.data!
                                                    .cartItems![index],
                                                context: context,
                                                index: index,
                                                productOnTap: () {});
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    buildCartBill(
                                      billData: cubit.cartModel!.data!,
                                    )
                                  ],
                                ),
                              )
                        : Container());
      },
    );
  }
}
