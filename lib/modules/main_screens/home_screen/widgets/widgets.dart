import 'package:banner_carousel/banner_carousel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/models/home_model/category_model.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/shared/componants.dart';
import '../../../../models/home_model/home_model.dart';

Widget buildHomeBanners(HomeModel model) {
  return BannerCarousel(
    height: 200,
    banners: model.data?.banners?.map((e) =>
            BannerModel(
              imagePath: "${e.image}",
              id: "${e.id}",
            )
        ).toList(),
    onTap: ((id) => print(id)),
  );
}

Widget buildCategoryHomeListItem({
  required CategoryData model,
  required void Function()? categoryOnTap,
}) {
  return InkWell(
    onTap: categoryOnTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
            image: CachedNetworkImageProvider(
              model.image!,
            ),
          ),
        ),
        child: Center(
          child: buildBodyText(
              text: model.name ?? "",
                  textColor: Colors.white,
            fontSize: 14.0,
            maxLines: 1
          ),
        )
      ),
    ),
  );
}

Widget buildProductGrid({
  required NewProducts model,
  required BuildContext context,
  void Function()? newProductOnTap
}) {
  return Container(
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
      onTap: newProductOnTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                CachedNetworkImage(imageUrl: "${model.image}",height: 200,width: double.infinity),
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
            buildBodyText(
                text: "${model.description}",
              textColor: Colors.black,
              maxLines: 2,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBodyText(
                      text: "${model.price.round()}  L.E",
                      textColor: Colors.black,
                      maxLines: 2,
                    ),
                    if(model.discount != 0)
                      buildDiscountText(
                        text: "${model.oldPrice.round()}",
                        maxLines: 1,
                      ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    HomeLayoutCubit.get(context).changeFavourite(model.id!);
                  },
                  icon:  CircleAvatar(
                    backgroundColor: HomeLayoutCubit.get(context).favourites[model.id!] == false ?
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
            BlocConsumer<AppCubit,AppStates>(
              listener: (context,state) {
                if(state is ChangeCartSuccessState) {
                  state.changeCartModel.status == false ?
                  buildToast(
                      msg: state.changeCartModel.message??"",
                      states: ToastStates.ERROR
                  ) : buildToast(
                      msg: state.changeCartModel.message ?? "",
                      states: ToastStates.SUCCESS
                  );
                }
              },
              builder: (context,state) {
                return SizedBox(
                  height: 35,
                  child: buildCartButton(
                    onTap: (){
                      AppCubit.get(context).changeCartItem(model.id!);
                    },
                    titleButton: AppCubit.get(context).cart[model.id!] == false ?
                    "Add To Cart" : "delete From Cart",
                    btnColor: AppCubit.get(context).cart[model.id!] == false ?
                    Colors.indigo :
                    Colors.red,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}