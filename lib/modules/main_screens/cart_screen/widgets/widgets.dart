import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/models/cart_model/cart_model.dart';
import 'package:shop_app/shared/componants.dart';

Widget buildCartProductsList({
  required CartItems model,
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
                      maxLines: 2,
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
                          ],
                        ),
                        if(model.product!.discount != 0)
                          buildDiscountText(
                            text: "${model.product!.oldPrice!.round()}",
                            maxLines: 1,
                          ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context).updateCart(
                                   model.id!,
                                    model.quantity = model.quantity! + 1,
                                );
                              },
                              icon: const CircleAvatar(
                                radius: 15.0,
                                child: Icon(
                                  Icons.add,
                                  size: 14.0,
                                ),
                              ),
                            ),
                            buildBodyText(
                                text: "${model.quantity}",
                                fontSize: 20.0
                            ),

                            IconButton(
                              onPressed: () {
                                if(model.quantity! != 1) {
                                  AppCubit.get(context).updateCart(
                                    model.id!,
                                    model.quantity = model.quantity! - 1,
                                  );
                                } else {
                                  AppCubit.get(context).changeCartItem(model.product!.id!);
                                }

                              },
                              icon: const CircleAvatar(
                                radius: 15.0,
                                child: Icon(
                                  Icons.remove,
                                  size: 14.0,
                                ),
                              ),
                            ),
                          ],
                        )
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

Widget buildCartBill({
  required BillData billData,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBodyText(
            text: "Bill",
          fontSize: 20,
          textColor: Colors.black
        ),
        Container(
          width: double.infinity,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBodyText(
                        text: "Sub-Total",
                        fontSize: 20,
                        //textColor: Colors.black
                    ),
                    buildBodyText(
                        text: "${billData.subTotal.round()} LE",
                        fontSize: 20,
                        textColor: Colors.black
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBodyText(
                        text: "Total",
                        fontSize: 20,
                        //textColor: Colors.black
                    ),
                    buildBodyText(
                        text: "${billData.total.round()} LE",
                        fontSize: 20,
                        textColor: Colors.black
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                //const Spacer(),
                buildAppButton(
                    onTap: (){
                      //toDo
                    },
                    titleButton: "Pay Via Card - ${billData.total.round()} LE"
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}