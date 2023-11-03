import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings =AppLocalizations.of(context)!;
    return  Scaffold(
      appBar:AppBar(
        title:  Text(strings.appTitle , style:Theme.of(context).textTheme.titleMedium ,),
      ) ,
      body:  Center(child: Container(
          padding: const EdgeInsets.all(15),
          color: Theme.of(context).colorScheme.error,
          child:  Text(strings.appTitle)),),
      drawer:Drawer (
        child: ListView(
          shrinkWrap: true,
          children:  [
            ListTile(
              title:  Text(strings.theme),
              trailing: ValueListenableBuilder(
                  valueListenable:Hive.box('Settings').listenable() ,
                  builder: (_,box,__) {
                  return Switch(
                    value: box.get("isDark" , defaultValue: false),
             onChanged:(v)=>Hive.box('Settings').put("isDark" , v) ,
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
              Hive.box("Settings").put("lang", v!);
            },
          )),

      ])),

    );
  }
}
