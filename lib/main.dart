import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/modules/main_screens/home_layout/ui/home_layout.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/decoration_and_themes.dart';
import 'package:shop_app/shared/localization/app_localization_setup.dart';
import 'app_cubit/app_cubit.dart';
import 'app_cubit/app_states.dart';
import 'app_cubit/bloc_observer.dart';
import 'modules/auth_screens/login_screen/ui/login_screen.dart';
import 'modules/main_screens/category_product_screen/cubit/cubit.dart';
import 'modules/main_screens/detail_screen/cubit/cubit.dart';
import 'modules/onBoarding_screens/ui/onBoarding_screen.dart';

void main() async{

  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  bool onBoarding = CacheHelper.getData(key: "onBoarding") ?? false;

  runApp( MyApp(
    onBoarding: onBoarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool? onBoarding;
  const MyApp({
    super.key ,
    this.onBoarding
  });


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..getSavedLanguage()
        ),

        BlocProvider(
            create: (BuildContext context) => HomeLayoutCubit()..getHomeData(context)..getCategoriesData()..getFavouriteData()
        ),

        BlocProvider(
            create: (BuildContext context) => CategoryProductCubit()
        ),

        BlocProvider(
            create: (BuildContext context) => ProductsDetailsCubit()
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context , state){},
        builder: (context,state) {
          token = CacheHelper.getData(key: "token");
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'mega shop App',
                localizationsDelegates:  AppLocalizationsSetup.localizationsDelegates,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                locale: state is AppChangeLocalState ? state.locale:null,
                localeResolutionCallback: (currentLocal, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (currentLocal != null &&
                        currentLocal.languageCode == locale.languageCode) {
                      return currentLocal;
                    }
                  }
                  return supportedLocales.first;
                },
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                home: onBoarding == false ?
                const OnBoardingScreen() :
                token != null ?
                const HomeLayout() :
                const LoginScreen()
            );
        }
      )
    );
  }
}