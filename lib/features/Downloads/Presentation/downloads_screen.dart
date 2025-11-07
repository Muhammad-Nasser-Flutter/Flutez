import 'package:flutez/core/widgets/back.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/features/Downloads/Bloc/cubit/downloaded_tracks_cubit.dart';
import 'package:flutez/features/Downloads/models/downloaded_track_model.dart';
import 'package:flutez/features/Track/presentation/widgets/playingTrack.dart';
import 'package:flutez/features/home/presentation/widgets/downloaded_tracks_widgets/downloaded_track_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({
    super.key,
    this.fromMain = true,
  });
  final bool fromMain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: fromMain ? null : const Back(),
        title: Text24(
          text: "Downloads",
          textColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              BlocBuilder<DownloadedTracksCubit, List<DownloadedTrackModel>>(
                builder: (context, state) {
                  if (state.isEmpty) {
                    return SizedBox(
                      height: 400.h,
                      child: Center(child: Text18(text: "No downloads available !")),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return DownloadedTrackWidget(downloadedTrackModel: state[index], index: index);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const PlayingTrack(),
    );
  }
}
