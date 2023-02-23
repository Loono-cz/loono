import 'package:flutter/material.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/newsletter/newsletter_bottom_sheet.dart';
import 'package:loono/utils/registry.dart';

///Function to show newsletter page
///[context] BuildContetxt
///[mounted] mounted property is set default to true, just for case you want to use
/// funciton in stateless widgets, and is used for lint helper.

Future<void> checkAndShowNewsletterPage(
  BuildContext context, {
  bool mounted = true,
}) async {
  final user = registry.get<DatabaseService>().users.user;
  final newsletterNotificationShown = user!.newsletterNotificationShown;

  final account = await registry.get<ApiService>().getAccount();
  var newsletterOptIn = false;
  account.map(
    success: (data) {
      newsletterOptIn = data.data.newsletterOptIn;
    },
    failure: (err) {},
  );

  final createdAtString = user.createdAt;

  var showModal = false;
  final dateNewOnBoarding = DateTime.utc(2022, 10, 11);

  if (createdAtString != null) {
    final createdAtDate = DateTime.tryParse(createdAtString)!;
    if (!newsletterNotificationShown &&
        createdAtDate.isBefore(dateNewOnBoarding) &&
        !newsletterOptIn) {
      showModal = true;
      //nastavit newsletternotificationShown na true
    }
  } else {
    if (!newsletterNotificationShown && !newsletterOptIn) {
      showModal = true;
      //nastavit newsletternotificationShown na true
    }
  }

  if (!mounted || !showModal) return;
  Future.delayed(
    const Duration(seconds: 30),
    () => showDelayNewsletterPage(context),
  );
}

Future<void> showDelayNewsletterPage(
  BuildContext context, [
  bool mounted = true,
]) async {
  if (!mounted) return;
  showNewsletterBottomSheet(context);
}
