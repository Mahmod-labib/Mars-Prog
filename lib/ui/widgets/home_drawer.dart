import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data-layer/db/init_db.dart';
import '../../utils/constants.dart';


class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key
  });


  @override
  Widget build(BuildContext context) {
    final strings =AppLocalizations.of(context)!;
    return Drawer (
        child: ListView(
            shrinkWrap: true,
            children:  [
              ListTile(
                  title:  Text(strings.theme),
                  trailing: ValueListenableBuilder(
                      valueListenable:settingsBox.listenable() ,
                      builder: (_,box,__) {
                        return Switch(
                          value: box.get(isDarkKey , defaultValue: false),
                          onChanged:(v)=>settingsBox.put(isDarkKey , v) ,
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
                      settingsBox.put(language, v!);

                    },
                  )),

            ]));
  }
}
