
import 'package:go_router/go_router.dart';
import 'package:untitled6/ui/screens/Photos_view.dart';
import 'package:untitled6/ui/screens/home-page.dart';
import 'package:untitled6/ui/screens/settings.dart';
import 'package:untitled6/utils/constants.dart';

GoRouter router (){

  return GoRouter(
      routes: [
        GoRoute(path: intialRoute , builder:(context , state)=>const HomePage() ),
        GoRoute(path: settingsPath , builder:(context , state)=>const Settings() ),
        GoRoute(path: "/photoPath" , builder:(context , state)=> PhotosView() ),


      ]);
}