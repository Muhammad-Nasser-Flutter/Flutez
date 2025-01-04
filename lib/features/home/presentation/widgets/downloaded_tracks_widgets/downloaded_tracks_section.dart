import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/features/Downloads/Bloc/cubit/downloaded_tracks_cubit.dart';
import 'package:flutez/features/Downloads/models/downloaded_track_model.dart';
import 'package:flutez/features/Recommended/Bloc/recommended_cubit.dart';
import 'package:flutez/features/Recommended/Bloc/recommended_states.dart';
import 'package:flutez/features/Track/presentation/Shimmers/recommended_shimmer.dart';
import 'package:flutez/features/Recommended/Presentation/widgets/recommended_item_widget.dart';
import 'package:flutez/features/home/presentation/widgets/downloaded_tracks_widgets/downloaded_track_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadedTracksSection extends StatelessWidget {
  const DownloadedTracksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text24(
          text: "Downloads",
          weight: FontWeight.w700,
        ),
        SizedBox(
          height: 250.h,
          child: BlocBuilder<DownloadedTracksCubit, List<DownloadedTrackModel>>(
            builder: (context, downloadedTracks) {
              if (downloadedTracks.isNotEmpty) {
                return ListView.separated(
                  padding: EdgeInsets.only(top: 20.h),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return DownloadedTrackWidget(
                      downloadedTrackModel: downloadedTracks[index],
                      index: index,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 15.w,
                    );
                  },
                  itemCount: downloadedTracks.length,
                );
              } else {
                return Center(child: Text16(text: "No Downloads available"));
              }
            },
          ),
        ),
      ],
    );
  }
}
