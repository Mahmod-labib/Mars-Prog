import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled6/data-layer/api/api.dart';
import 'package:untitled6/data-layer/models/mars_photo.dart';
import 'package:untitled6/logic/mars/mars_cubit.dart';
import 'package:untitled6/ui/widgets/mars_photo_card.dart';

import '../../data-layer/models/rover.dart';
import '../../data-layer/repo/repo.dart';
import '../../utils/constants.dart';
import '../widgets/home_drawer.dart';

bool dataReady = false;
List<MarsPhoto> marsPhotos = [];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.appTitle,
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
      ),
      body:  BlocBuilder<MarsCubit, MarsState>(
        buildWhen:(previous , current)=> previous is RoverDataLoading && current is RoverDataLoaded,
        builder: (context, state) {
          return ConditionalBuilder(condition: state is! RoverDataLoading,
              builder: (context)=>Column(
                children: [
                  ListTile(
                    title: Text(strings.date),
                    trailing: const Icon(Icons.calendar_month_rounded),
                    onTap: () async {
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
                              .maxDate);
                      marsPhotos = await Repo().fetchDatePhotos(date ??
                          Hive.box<Rover>(roverDetailsKey)
                              .get(roverDetails)!
                              .maxDate);
                    },
                  ),
                  Expanded(child: BlocBuilder<MarsCubit, MarsState>(
                    builder: (context, state) {
                      //   final MarsCubit cubit=context.read<MarsCubit>();
                      // final MarsCubit cubit=MarsCubit.get(context);
                      if (state is RoverDataLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return BlocBuilder<MarsCubit, MarsState>(
                          builder: (context, state) {
                            return ListView.builder(
                              itemCount: marsPhotos.length,
                              itemBuilder: (_, i) {
                                return const SizedBox();
                              },
                            );
                          },
                        );
                      }
                    },
                  )),
                ],
              ),  fallback: (context)=>const Center(child: CircularProgressIndicator()));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Repo().fetchLatestPhotos();
          //Repo().fetchDatePhotos(DateTime(2022,10,10));
          Repo().fetchCuriosityData();
        },
        child: const Icon(Icons.add),
      ),
      drawer: const HomeDrawer(),
    );
  }
}
