import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/main_app_entry.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/app_snack_bar.dart';
import 'package:flutter_riverpod_template/utils/gap.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';

void appImageUserTake({localImagePath, required Function(String) callBack}) {
  try {
    showBottomSheet(
      context: rootScaffoldMessengerKey.currentState!.context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.all(AppSize.height(value: 20.0)),
          padding: EdgeInsets.all(AppSize.height(value: 10.0)),
          decoration: BoxDecoration(color: AppColors.instance.white500, borderRadius: BorderRadius.circular(AppSize.width(value: 12.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(rootScaffoldMessengerKey.currentState!.context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(rootScaffoldMessengerKey.currentState!.context);
                        appUserImagePic(source: ImageSource.camera, callBack: callBack);
                      },
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, size: 60, color: AppColors.instance.primary),
                          const AppText(text: "Camera", fontWeight: FontWeight.w700),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(rootScaffoldMessengerKey.currentState!.context);

                        appUserImagePic(source: ImageSource.gallery, callBack: callBack);
                      },
                      child: Column(
                        children: [
                          Icon(Icons.collections, size: 60, color: AppColors.instance.primary),
                          const AppText(text: "Gallery", fontWeight: FontWeight.w700),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(height: 20),
            ],
          ),
        );
      },
    );
  } catch (e) {
    errorLog("appImageUserTake", e);
  }
}

Future<void> appUserImagePic({required ImageSource source, required Function(String) callBack}) async {
  try {
    bool permissionGranted = false;

    if (source == ImageSource.camera) {
      final status = await Permission.camera.status;
      if (status.isGranted || status.isLimited) {
        permissionGranted = true;
      }

      if (status.isDenied) {
        var response = await askFirst(
          title: "Camera Access Required",
          content: """We need access to your camera so you can update your profile picture""",
          acceptButton: "Continue",
        );
        if (response) {
          final request = await Permission.camera.request();
          if (request.isGranted || request.isLimited) {
            permissionGranted = true;
          }
        }
      }

      if (status.isPermanentlyDenied) {
        var response = await getCallAgainPermission(
          title: "Camera Access Needed",
          content:
              """We need access to your camera so you can take or update your profile picture. We respect your privacy and only use the camera when you choose to use this feature.
\nYou can enable camera access in your device settings.""",
          acceptButton: "Open Settings",
        );
        if (response) {
          final request = await Permission.camera.request();
          if (request.isGranted || request.isLimited) {
            permissionGranted = true;
          }
        }
      }
    } else {
      // Gallery access
      if (Platform.isIOS) {
        final status = await Permission.photos.status;

        if (status.isGranted || status.isLimited) {
          permissionGranted = true;
        }
        if (status.isDenied) {
          var response = await askFirst(
            acceptButton: "Continue",
            title: "Allow Access to Photos and Media",
            content: """Allow Access to Photos and Media

We need access to your device's media library so you can select photos, videos, or files, like updating your profile picture or uploading documents.

Your data is never shared and stays on your device unless you choose to upload it.""",
          );
          if (response) {
            final request = await Permission.photos.request();

            if (request.isGranted || request.isLimited) {
              permissionGranted = true;
            }
          }
        }

        if (status.isPermanentlyDenied) {
          var response = await getCallAgainPermission(
            acceptButton: "Open Settings",
            title: "Allow Access to Photos and Media",
            content: """Allow Access to Photos and Media

We need access to your device's media library so you can select photos, videos, or files, like updating your profile picture or uploading documents.

Your data is never shared and stays on your device unless you choose to upload it.""",
          );
          if (response) {
            final request = await Permission.photos.request();
            if (request.isGranted || request.isLimited) {
              permissionGranted = true;
            }
          } else {
            return;
          }
        }
      } else if (Platform.isAndroid) {
        final status = await Permission.mediaLibrary.status;
        if (status.isGranted || status.isLimited) {
          permissionGranted = true;
        }
        if (status.isDenied) {
          var response = await askFirst(
            acceptButton: "Continue",
            title: "Allow Access to Photos and Media",
            content: """Allow Access to Photos and Media

We need access to your device's media library so you can select photos, videos, or files, like updating your profile picture or uploading documents.

Your data is never shared and stays on your device unless you choose to upload it.""",
          );
          if (response) {
            final request = await Permission.mediaLibrary.request();
            if (request.isGranted || request.isLimited) {
              permissionGranted = true;
            }
          }
        }

        if (status.isPermanentlyDenied) {
          var response = await getCallAgainPermission(
            acceptButton: "Open Settings",
            title: "Allow Access to Photos and Media",
            content: """Allow Access to Photos and Media

We need access to your device's media library so you can select photos, videos, or files, like updating your profile picture or uploading documents.

Your data is never shared and stays on your device unless you choose to upload it.""",
          );

          if (response) {
            final status = await Permission.mediaLibrary.status;
            if (status.isGranted || status.isLimited) {
              permissionGranted = true;
            }
          }
        }
      }
    }

    if (permissionGranted) {
      final picked = await ImagePicker().pickImage(source: source);
      if (picked != null) {
        callBack(picked.path);
      }
    }
  } catch (e) {
    AppSnackBar.instance.error("Something went wrong: ${e.toString()}");
  }
}

Future<bool> askFirst({
  String title = "Gallery",
  String content = "This permission is required to continue. Please enable it from settings.",
  String acceptButton = "Continue",
  String cancelButton = "Cancel",
}) async {
  bool userConfirmed = false;
  await showAdaptiveDialog<bool>(
    context: rootScaffoldMessengerKey.currentState!.context,
    builder: (context) {
      return Dialog(
        child: Column(
          children: [
            Gap(height: 10),
            AppText(text: content, textAlign: TextAlign.center),
            Gap(height: 20),
            SizedBox(
              width: AppSize.size.width * 0.4,
              child: ElevatedButton(
                onPressed: () async {
                  userConfirmed = true;
                  Navigator.pop(rootScaffoldMessengerKey.currentState!.context);
                },
                child: AppText(text: acceptButton),
              ),
            ),
            Gap(height: 10),
          ],
        ),
      );
    },
  );

  return userConfirmed;
}

Future<bool> getCallAgainPermission({
  String title = "Gallery",
  String content = "This permission is required to continue. Please enable it from settings.",
  String acceptButton = "Open Settings",
  String cancelButton = "Cancel",
}) async {
  bool userConfirmed = false;
  await showAdaptiveDialog<bool>(
    context: rootScaffoldMessengerKey.currentState!.context,
    builder: (context) {
      return Dialog(
        child: Column(
          children: [
            Gap(height: 10),
            AppText(text: content, textAlign: TextAlign.center),
            Gap(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      userConfirmed = false;
                      Navigator.pop(rootScaffoldMessengerKey.currentState!.context);
                    },
                    child: AppText(text: cancelButton),
                  ),
                ),

                Gap(width: 50),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      userConfirmed = true;
                      Navigator.pop(rootScaffoldMessengerKey.currentState!.context);
                    },
                    child: AppText(text: acceptButton),
                  ),
                ),
              ],
            ),
            Gap(height: 10),
          ],
        ),
      );
    },
  );

  if (userConfirmed) {
    await openAppSettings();
  }

  return userConfirmed;
}
