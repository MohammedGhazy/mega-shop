import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/models/category_products_model/category_products_model.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/states.dart';
import 'package:shop_app/shared/componants.dart';

Widget buildCategoryProductsList({
  required CategoryProductDataModel model,
  required BuildContext context,
  required int index,
  required void Function() productOnTap
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xffDDDDDD),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: InkWell(
        onTap: productOnTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  CachedNetworkImage(imageUrl: model.image! ,height: 150,width: 100,fit: BoxFit.fill,),
                  if(model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: buildBodyText(
                        text: "DISCOUNT",
                        textColor: Colors.white,
                        fontSize: 10.0,
                        maxLines: 2,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 10.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBodyText(
                      text: "${model.name}",
                      textColor: Colors.black,
                      maxLines: 3,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                          children: [
                            buildBodyText(
                              text: "${model.price!.round()}  L.E",
                              textColor: Colors.black,
                              maxLines: 2,
                            ),
                            BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
                              listener: (context,state) {},
                              builder: (context,state) {
                                return IconButton(
                                  onPressed: () {
                                    HomeLayoutCubit.get(context).changeFavourite(model.id!);
                                  },
                                  icon:  CircleAvatar(
                                    backgroundColor: HomeLayoutCubit.get(context).favourites[model.id] == false ?
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
                            ),

                          ],
                        ),
                        if(model.discount != 0)
                          buildDiscountText(
                            text: "${model.oldPrice!.round()}",
                            maxLines: 1,
                          ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}