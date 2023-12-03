
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled6/data-layer/repo/repo.dart';
import 'package:untitled6/logic/mars/mars_cubit.dart';
import 'package:untitled6/ui/screens/Photos_view.dart';
import 'package:untitled6/ui/screens/home_page.dart';
import 'package:untitled6/ui/screens/landing_pages.dart';
import 'package:untitled6/ui/screens/settings.dart';
import 'package:untitled6/utils/constants.dart';

GoRouter router (){
final MarsCubit marsCubit=MarsCubit(repo:  Repo());
  return GoRouter(
      routes: [
        GoRoute(
            path: intialRoute ,
            builder:(context , state)=>BlocProvider<MarsCubit >.value(
              value:marsCubit ,
              child:  const Landing(),
            ) ),
        GoRoute(
            path: home ,
            builder:(context , state)=>BlocProvider<MarsCubit >.value(
              value:marsCubit ,
              child:  HomePage(earthDate: state.extra as DateTime?,),
            ), ),
        GoRoute(path: settingsPath ,
            builder:(context , state)=>BlocProvider<MarsCubit >.value(
              value:marsCubit ,
              child:const Settings(),
            ) ),        GoRoute(path: "/photoPath" , builder:(context , state)=> PhotosView() ),


      ]);
}