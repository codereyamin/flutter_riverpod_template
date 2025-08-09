import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/main_app_entry.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/app_snack_bar.dart';
import 'package:flutter_riverpod_template/utils/gap.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> userImagePicker({required Function(List<String>) callBack}) async {
  try {
    List<XFile> pickedMedia = [];
    List<String> localImagePaths = [];

    bool permissionGranted = false;

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
          final requestResult = await Permission.photos.request();
          if (requestResult.isGranted || requestResult.isLimited) {
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
          final storageStatus = await Permission.storage.status;
          if (storageStatus.isGranted || storageStatus.isLimited) {
            permissionGranted = true;
          }
        } else {
          return;
        }
      }
    } else if (Platform.isAndroid) {
      final storageStatus = await Permission.mediaLibrary.status;
      if (storageStatus.isGranted || storageStatus.isLimited) {
        permissionGranted = true;
      }

      if (storageStatus.isDenied) {
        var response = await askFirst(
          acceptButton: "Continue",
          title: "Allow Access to Photos and Media",
          content: """Allow Access to Photos and Media

We need access to your device's media library so you can select photos, videos, or files, like updating your profile picture or uploading documents.

Your data is never shared and stays on your device unless you choose to upload it.""",
        );
        if (response) {
          final requestResult = await Permission.mediaLibrary.request();
          if (requestResult.isGranted || requestResult.isLimited) {
            permissionGranted = true;
          }
        }
      }

      if (storageStatus.isPermanentlyDenied) {
        var response = await getCallAgainPermission(
          acceptButton: "Open Settings",
          title: "Allow Access to Photos and Media",
          content: """Allow Access to Photos and Media

We need access to your device's media library so you can select photos, videos, or files, like updating your profile picture or uploading documents.

Your data is never shared and stays on your device unless you choose to upload it.""",
        );
        if (response) {
          final storageStatus = await Permission.mediaLibrary.status;
          if (storageStatus.isGranted || storageStatus.isLimited) {
            permissionGranted = true;
          }
        } else {
          return;
        }
      }
    }

    if (permissionGranted) {
      pickedMedia = await ImagePicker().pickMultipleMedia(limit: 10);

      if (pickedMedia.isEmpty) {
        return;
      }

      localImagePaths = pickedMedia.map((xfile) => File(xfile.path).path).toList();

      callBack(localImagePaths);
    }
  } catch (e) {
    AppSnackBar.instance.error("Something went wrong: ${e.toString()}");
  }
}

Future<bool> askFirst({
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
  String acceptButton = "",
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
