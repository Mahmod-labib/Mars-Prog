import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled6/data-layer/models/mars_photo.dart';
import 'package:untitled6/logic/mars/mars_cubit.dart';
import 'package:untitled6/ui/widgets/mars_photo_card.dart';


bool dataReady = false;
List<MarsPhoto> marsPhotos = [];

class HomePage extends StatelessWidget {
  final DateTime? earthDate;
  const HomePage({super.key,required this.earthDate});
@override
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
        builder: (context, state) {
          return ConditionalBuilder(condition: state is MarsPhotosLoaded,
              builder: (context)=> ListView.builder(
                          itemCount: (state as MarsPhotosLoaded).photos.length,
                          itemBuilder: (_, i)=> MarsPhotoCard(marsPhoto: (state).photos[i]),
                        ),
    fallback: (context)=>const Center(child: CircularProgressIndicator()));
                      },
                    ),

    );
    }


  }

