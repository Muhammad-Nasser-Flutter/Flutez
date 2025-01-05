import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_button.dart';
import 'package:flutez/core/widgets/custom_text_form_field.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/features/Track/Model/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

class DesktopHomeScreen extends StatelessWidget {
  DesktopHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            showAddTrackDialog(screenContext: context, height: height, width: width);
          },
          child: Container(
            height: height * 0.5,
            width: width * 0.3,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.bigTextColor, width: 4),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Icon(
                    Icons.music_note,
                    color: AppColors.scaffoldBackground,
                    size: 150.r,
                  ),
                ),
                Text28(
                  text: "Add Track",
                  textColor: Colors.black,
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showAddTrackDialog({required BuildContext screenContext, required double height, required double width}) {
  final trackNameController = TextEditingController();
  final artistNameController = TextEditingController();
  File? imageFile;

  File? trackFile;
  // Function to pick audio file

  Future<void> pickAudioFile(StateSetter setState) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          trackFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print('Error picking audio file: $e');
    }
  }

  // Function to upload files to Firebase Storage

  Future<Map<String, String>> uploadFiles() async {
    if (trackFile == null || imageFile == null) {
      throw Exception('Please select both audio and image files');
    }

    final String trackId = const Uuid().v4();

    final storageRef = FirebaseStorage.instance.ref();

    // Upload audio file

    final String audioPath = 'Tracks/Audio/${trackFile!.path.split('/').last}';

    final audioRef = storageRef.child(audioPath);

    await audioRef.putFile(trackFile!);

    final audioUrl = await audioRef.getDownloadURL();

    // Upload image file

    final String imagePath = 'Tracks/Images/${imageFile!.path.split('/').last}';

    final imageRef = storageRef.child(imagePath);

    await imageRef.putFile(imageFile!);

    final imageUrl = await imageRef.getDownloadURL();

    return {
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
    };
  }

  // Function to save track data to Firestore

  Future<void> saveTrackData(Map<String, String> urls) async {
    try {
      await FirebaseFirestore.instance.collection('AllTracks').add(
            Track(
              trackName: trackNameController.text,
              artist: artistNameController.text,
              trackLink: urls['audioUrl'],
              image: urls['imageUrl'],
            ).toJson(),
          );
    } catch (e) {
      print('Error saving track data: $e');

      rethrow;
    }
  }

  // Function to pick image file

  Future<void> pickImageFile(StateSetter setState) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          imageFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print('Error picking image file: $e');
    }
  }

  showDialog(
    context: screenContext,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: StatefulBuilder(
          builder: (context, setState) => IntrinsicHeight(
            child: Container(
              width: width * 0.4,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text12(
                          text: "Add track",
                          textColor: Colors.black,
                          size: 8.sp,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () => context.pop(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextFormField(
                    labelText: "Track Name",
                    controller: trackNameController,
                    backgroundColor: AppColors.smallTextColor,
                    borderColor: Colors.black54,
                    textColor: Colors.black,
                    borderWidth: 1,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    labelText: "Artist Name",
                    controller: artistNameController,
                    backgroundColor: AppColors.smallTextColor,
                    borderColor: Colors.black54,
                    borderWidth: 1,
                    textColor: Colors.black,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 0.25 * height,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.smallTextColor,
                              border: Border.all(
                                color: Colors.black54,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Icon(
                                    Icons.music_note,
                                    color: AppColors.scaffoldBackground,
                                    size: 100.r,
                                  ),
                                ),
                                Text20(
                                  text: "Upload Track",
                                  textColor: Colors.black,
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.smallTextColor,
                              border: Border.all(
                                color: Colors.black54,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Icon(
                                    Icons.image,
                                    color: AppColors.scaffoldBackground,
                                    size: 100.r,
                                  ),
                                ),
                                Text20(
                                  text: "Upload Cover",
                                  textColor: Colors.black,
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomButton(
                      text: "Submit",
                      borderRadius: 15,
                      height: 55,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
