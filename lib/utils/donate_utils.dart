import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/models/donate_user_info.dart';
import 'package:loono/services/secure_storage_service.dart';
import 'package:loono/ui/widgets/donate/donate_bottom_sheet.dart';
import 'package:loono/utils/registry.dart';

///Function to show donate page
///[context] BuildContetxt
///[mounted] mounted property is set default to true, just for case you want to use
/// funciton in stateless widgets, and is used for lint helper.

Future<void> checkAndShowDonatePage(
  BuildContext context, {
  bool mounted = true,
}) async {
  final secureStorageRegistry = registry.get<SecureStorageService>();
  final donateInfo = await secureStorageRegistry.getDonateInfoData();

  final donateuserInfo = DonateUserInfo(lastOpened: DateTime.now(), showNotification: true);
  var showModal = false;

  if (donateInfo == null) {
    await secureStorageRegistry.storeDonateInfoData(donateuserInfo);
    showModal = true;
  } else if (DateTime.now().isAfter(
          donateInfo.lastOpened.add(const Duration(days: LoonoStrings.donateDelayInterval))) &&
      donateInfo.showNotification == true) {
    await secureStorageRegistry.storeDonateInfoData(
      donateuserInfo,
    );
    showModal = true;
  }

  if (!mounted || !showModal) return;
  await showDelayDonatePage(context);
}

Future<void> showDelayDonatePage(
  BuildContext context, [
  bool mounted = true,
]) async {
  await Future<void>.delayed(const Duration(seconds: 5));
  if (!mounted) return;
  showDonateBottomSheet(context);
}
