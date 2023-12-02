import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:untitled6/utils/constants.dart';

import '../../data-layer/models/rover.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final Rover rover= Hive.box<Rover>(roverDetailsKey)
    .get(roverDetails)!;
class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(

      appBar: AppBar(
        title:  Text(strings.appTitle),
      ),
      body:  Column(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
        children: [
          const SizedBox(width: double.infinity,),
          FilledButton(onPressed: (){
            context.push(home);
          },

              child: const Text("Latest Photos")),


          FilledButton(onPressed:  () async {
    DateTime? date = await showDatePicker(
    context: context,
    initialDate:
       rover .maxDate,
    firstDate: rover
        .landingDate,
    lastDate: rover
        .maxDate).then((date) {
          if(date != null){
            context.push(home );
          }
    });

    },

              child: const Text("Date Photos"))
        ],
      ),
    );
  }
}
