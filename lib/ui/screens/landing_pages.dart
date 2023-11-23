import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:untitled6/ui/widgets/home_drawer.dart';
import 'package:untitled6/utils/constants.dart';

import '../../data-layer/models/rover.dart';


class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mars Photos"),
      ),
      drawer: const HomeDrawer(),
      body:  Column(
        mainAxisAlignment:MainAxisAlignment.center ,
        children: [
          FilledButton(onPressed: (){
            context.push(home);
          },

              child: const Text("Latest Photos")),


          FilledButton(onPressed:  () async {
    DateTime? date = await showDatePicker(
    context: context,
    initialDate: Hive.box<Rover>(roverDetailsKey)
        .get(roverDetails)!
        .maxDate,
    firstDate: Hive.box<Rover>(roverDetailsKey)
        .get(roverDetails)!
        .landingDate,
    lastDate: Hive.box<Rover>(roverDetailsKey)
        .get(roverDetails)!
        .maxDate).then((date) {
          if(date != null){
            context.push(home);
          }
    });

    },

              child: const Text("Date Photos"))
        ],
      ),
    );
  }
}
