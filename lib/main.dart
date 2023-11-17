import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled6/data-layer/db/init_db.dart';
import 'package:untitled6/ui/screens/home-page.dart';
import 'package:untitled6/utils/app_router.dart';
import 'package:untitled6/utils/constants.dart';
import 'package:untitled6/utils/material-theme/color_schemes.g.dart';
import 'package:untitled6/utils/typography.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
main()async{
  WidgetsFlutterBinding.ensureInitialized();

  await initDB();
  runApp(const MyAPP());
}
class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable:Hive.box(settingsKey).listenable() ,
      builder: (_,box,__) {
        final isDark=Hive.box(settingsKey).get(isDarkKey , defaultValue: false);
        final String lang=Hive.box(settingsKey).get(language , defaultValue: defaultLang);
        return Sizer(
          builder: (context, orientation , deviceType) {
            return MaterialApp.router(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(lang),
              title:
              "app title",
              theme: ThemeData(
                colorScheme: lightColorScheme,
                useMaterial3: true,
                textTheme: textTheme,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme,
                    useMaterial3: true,

              ),
              themeMode:isDark? ThemeMode.dark  : ThemeMode.light,
              routerConfig: router(),
            );
          }
        );
      }
    );
  }
}
