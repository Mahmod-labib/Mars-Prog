import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:untitled6/data-layer/models/mars_photo.dart';
import 'package:untitled6/logic/mars/mars_cubit.dart';
import 'package:untitled6/ui/widgets/mars_photo_card.dart';

import '../widgets/home_drawer.dart';


bool dataReady = false;
List<MarsPhoto> marsPhotos = [];

class HomePage extends StatelessWidget {
  final DateTime? earthDate;
  const HomePage({super.key,required this.earthDate});
@override
  Widget build(BuildContext context) {
    final MarsCubit cubit = context.read<MarsCubit>();
    cubit.resetHomePage();
    cubit.fetchMarsPhotos(earthDate);
    cubit.scrollController.addListener(()=>cubit.checkScrollPosition(earthDate!));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          earthDate==null? "LatestPhotos" :DateFormat.yMMMd().format(earthDate!),
          style: Theme
              .of(context)
              .textTheme
              .titleSmall,
        ),
      ),
      drawer: const HomeDrawer(),

      body:  BlocBuilder<MarsCubit, MarsState>(
        builder: (context, state) {
          return ConditionalBuilder(condition: cubit.isPhotosLoaded,
              builder: (context)=> ListView.builder(
                          controller:cubit.scrollController ,
                          itemCount: cubit.photosList.length,
                          itemBuilder: (_, i)=> MarsPhotoCard(marsPhoto: cubit.photosList[i]),
                        ),
    fallback: (context)=>const Center(child: CircularProgressIndicator()));
                      },
                    ),

    );
    }


  }

