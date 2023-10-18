import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/favourites_model/favourite_model.dart';
import 'package:shop_app/modules/main_screens/detail_screen/ui/detail_screen.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/shared/componants.dart';

Widget buildFavouriteList({
  required FavouritesData model,
  required BuildContext context,
}) {
  return Container(
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
      onTap: () {
        navigateTo(
            context,
            DetailScreen(productId: model.product!.id,)
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                CachedNetworkImage(imageUrl: model.product!.image! ,height: 150,width: 100,fit: BoxFit.fill,),
                if(model.product!.discount != 0)
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
                    text: "${model.product!.name}",
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
                            text: "${model.product!.price!.round()}  L.E",
                            textColor: Colors.black,
                            maxLines: 2,
                          ),
                          IconButton(
                            onPressed: () {
                              HomeLayoutCubit.get(context).changeFavourite(model.product!.id!);
                            },
                            icon:  CircleAvatar(
                              backgroundColor: HomeLayoutCubit.get(context).favourites[model.product!.id!] == false ?
                              Colors.grey :
                              Colors.indigo,
                              radius: 15.0,
                              child: const Icon(
                                Icons.favorite_border_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),

                        ],
                      ),
                      if(model.product!.discount != 0)
                        buildDiscountText(
                          text: "${model.product!.oldPrice!.round()}",
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
  );
}