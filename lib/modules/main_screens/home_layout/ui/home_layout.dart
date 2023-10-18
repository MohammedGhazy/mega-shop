import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/modules/auth_screens/login_screen/ui/login_screen.dart';
import 'package:shop_app/modules/main_screens/cart_screen/ui/cart_screen.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/states.dart';
import 'package:shop_app/shared/componants.dart';
import 'package:badges/badges.dart' as badges;

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          drawer: buildDrawer(context),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Builder(
              builder: (context) => IconButton(
                icon: Image.asset(
                  "assets/images/drawer.png",
                  height: 30,
                  width: 30,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            centerTitle: false,
            actions: [
              BlocConsumer<AppCubit, AppStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      badges.Badge(
                        position: badges.BadgePosition.topEnd(top: 0, end: 3),
                        badgeAnimation: const badges.BadgeAnimation.slide(),
                        showBadge: true,
                        badgeStyle: const badges.BadgeStyle(
                          badgeColor: Colors.red,
                        ),
                        badgeContent: Center(
                          child: Text(
                            "${AppCubit.get(context).cartProductsNumber}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        child: IconButton(
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 20,
                            ),
                            onPressed: () {
                              BlocProvider.of<AppCubit>(context, listen: false)
                                  .getCartData();
                              navigateTo(context, const CartScreen());
                            }),
                      ),
                    ],
                  );
                },
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: DotNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeScreenIndex(index),
            items: cubit.bottomNavigationItems,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
