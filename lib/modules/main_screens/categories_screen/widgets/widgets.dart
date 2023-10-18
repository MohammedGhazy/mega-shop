import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/home_model/category_model.dart';
import 'package:shop_app/shared/componants.dart';

Widget buildCategoryListItem({
  required CategoryData model,
  required void Function()? onTap

}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 150,
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
                fontSize: 20.0,
                maxLines: 1
            ),
          )
      ),
    ),
  );
}