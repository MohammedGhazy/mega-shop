import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/main_screens/detail_screen/cubit/cubit.dart';
import 'package:shop_app/modules/main_screens/detail_screen/cubit/states.dart';
import 'package:shop_app/modules/main_screens/detail_screen/widgets/widgets.dart';
import 'package:shop_app/shared/componants.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key,this.productId});
  final int? productId;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsDetailsCubit>(context, listen: false).getProductDetailData(productId!);
    return BlocConsumer<ProductsDetailsCubit,ProductDetailsStates> (
      listener: (context , state) {},
      builder: (context,state) {
        var cubit = ProductsDetailsCubit.get(context);
         return Scaffold(
            body: state is DetailLoadingState ? const Center(child: CircularProgressIndicator(),) :
            state is DetailFailureState ?
             Center(child: buildBodyText(text: state.error)) :
                cubit.productDetailModel != null ?
             ListView(
              children: [
                buildDetailsBannerItems(
                    productDetailData: cubit.productDetailModel!.data!,
                    context: context
                ),
                const SizedBox(height: 20,),
                buildDetailItems(
                    productDetailData: cubit.productDetailModel!.data!,
                    context: context
                )
              ],
            ): Container()
          );
        }
    );
  }
}