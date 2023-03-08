import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/newsletter/newsletter_bottom_sheet.dart';
import 'package:loono/utils/registry.dart';

///Function to show newsletter page
///[context] BuildContetxt
///[mounted] mounted property is set default to true, just for case you want to use
/// funciton in stateless widgets, and is used for lint helper.

Future<void> checkAndShowNewsletterPage({
  required BuildContext context,
  required bool mounted,
}) async {
  final user = registry.get<DatabaseService>().users.user;
  final newsletterNotificationShown = user?.newsletterNotificationShown ?? false;

  final account = await registry.get<ApiService>().getAccount();
  var newsletterOptIn = false;

  account.map(
    success: (data) {
      newsletterOptIn = data.data.newsletterOptIn;
    },
    failure: (err) {},
  );
  final createdAtDate = user?.createdAt;

  final dateNewOnBoarding = DateTime(2022, 10, 11);
  const endNotifTimeStamp = 1680300000000;

  if (createdAtDate != null) {
    if (!newsletterNotificationShown &&
        createdAtDate.isBefore(dateNewOnBoarding) &&
        !newsletterOptIn &&
        DateTime.now().millisecondsSinceEpoch < endNotifTimeStamp) {
      await registry.get<UserRepository>().updateNewsletterNotificationShown(true);
      if (!mounted) return;
      Future.delayed(
        const Duration(seconds: LoonoStrings.newsletterDurationDelay),
        () => showNewsletterBottomSheet(context),
      );
    }
  }
}
