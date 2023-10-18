import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/models/category_products_model/product_detail_model.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/states.dart';
import 'package:shop_app/shared/componants.dart';

Widget buildDetailsBannerItems({
  required ProductDetailData productDetailData,
  required BuildContext context,
}) {
  return Stack(
    children: [
      FanCarouselImageSlider(
          imagesLink: productDetailData.images!,
          isAssets: false,
          autoPlay: false,
          sliderHeight: MediaQuery.of(context).size.height *0.45,
        imageFitMode: BoxFit.fill,
        indicatorActiveColor: Colors.indigo,
        ),
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon:  const CircleAvatar(
          backgroundColor: Colors.indigo,
          radius: 20.0,
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

Widget buildDetailItems({
  required ProductDetailData productDetailData,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleText(
            text: productDetailData.name!
        ),
        const SizedBox(height: 10.0,),
        RichReadMoreText.fromString(
          text: productDetailData.description!,
          textStyle: const TextStyle(color: Colors.grey),
          settings: LengthModeSettings(
            trimLength: 200,
            trimCollapsedText: 'Read more',
            trimExpandedText: ' Show Less ',
            onPressReadMore: () {
              /// specific method to be called on press to show more
            },
            onPressReadLess: () {
              /// specific method to be called on press to show less
            },
            lessStyle: const TextStyle(color: Colors.indigo),
            moreStyle: const TextStyle(color: Colors.indigo),
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBodyText(
                text: "${productDetailData.price!} LE",
              textColor: Colors.black,
              fontSize: 18
            ),
            if(productDetailData.discount != 0)
              buildDiscountText(
                  text: "${productDetailData.oldPrice!} LE",
                fontSize: 18.0
              )
          ],
        ),
        const SizedBox(height: 10.0,),
        Row(
          children: [
            BlocConsumer<AppCubit,AppStates>(
              listener: (context,state) {},
              builder: (context,state) {
                return Expanded(
                  child: buildCartButton(
                    onTap: (){
                      AppCubit.get(context).changeCartItem(productDetailData.id!);
                    },
                    titleButton:AppCubit.get(context).cart[productDetailData.id!] == false ?
                    "Add To Cart" : "delete From Cart",
                    btnColor: AppCubit.get(context).cart[productDetailData.id!] == false ?
                    Colors.indigo :
                    Colors.red,
                  ),
                );
              },
            ),
            BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
              listener: (context,state) {},
              builder: (context,state) {
                return IconButton(
                  onPressed: () {
                    HomeLayoutCubit.get(context).changeFavourite(productDetailData.id!);
                  },
                  icon:  CircleAvatar(
                    backgroundColor: HomeLayoutCubit.get(context).favourites[productDetailData.id!] == false ?
                    Colors.grey :
                    Colors.indigo,
                    radius: 15.0,
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            )
          ],
        )
      ],
    ),
  );
}