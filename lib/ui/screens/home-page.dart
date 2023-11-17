import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data-layer/repo/repo.dart';
import '../../utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings =AppLocalizations.of(context)!;
    return  Scaffold(
      appBar:AppBar(
        title:  Text(strings.appTitle , style:Theme.of(context).textTheme.titleMedium ,),
      ) ,
      body:
      Center(child:FilledButton(
        onPressed: (){
          context.push(settingsPath);
        },
        child: const Text(settingsKey),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         // Repo().fetchLatestPhotos();
          Repo().fetchDatePhotos(DateTime(2022,10,10));

        } ,child: const Icon(Icons.add),),
      drawer:Drawer (
        child: ListView(
          shrinkWrap: true,
          children:  [
            ListTile(
              title:  Text(strings.theme),
              trailing: ValueListenableBuilder(
                  valueListenable:Hive.box(settingsKey).listenable() ,
                  builder: (_,box,__) {
                  return Switch(
                    value: box.get(isDarkKey , defaultValue: false),
             onChanged:(v)=>Hive.box(settingsKey).put(isDarkKey , v) ,
            );
                }
              )
            ),
      ListTile(
          title:  Text(strings.language),
          trailing: DropdownButton(
            items: <String>["en", "ar"]
                .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
                .toList(),
            onChanged: (v) {
              Hive.box(settingsKey).put(language, v!);

            },
          )),

      ])),

    );
  }
}
