import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/main_screens/favourite_screen/widgets/widgets.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';

import '../../../../shared/componants.dart';
import '../../home_layout/cubit/states.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit , HomeLayoutStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          body: state is FavouriteLoadingState ?
            const Center(
            child:  CircularProgressIndicator(),
        )
        : state is FavouriteFailureState ?
            Center(child: buildBodyText(text: state.failure),)
        : cubit.favouriteModel != null ?
          cubit.favouriteModel!.data!.data!.isEmpty ?
          buildEmptyCartOrFavourite(msg: 'there is no products in favourites...')
          : ListView.builder(
            physics: const BouncingScrollPhysics(),
              itemCount: cubit.favouriteModel!.data!.data!.length,
              itemBuilder: (context , index) {
              return  buildFavouriteList(
                  model: cubit.favouriteModel!.data!.data![index],
                  context: context
              );
            }
          ): Container()
        );
    },
    );
  }
}
