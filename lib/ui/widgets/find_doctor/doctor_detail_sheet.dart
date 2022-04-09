import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/simple_health_care_provider_helper.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/ui/widgets/find_doctor/contact_button.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailSheet extends StatelessWidget {
  const DoctorDetailSheet({
    Key? key,
    required this.doctor,
    required this.closeDetail,
  }) : super(key: key);
  final SimpleHealthcareProvider doctor;
  final VoidCallback closeDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (doctor.specialization != null)
                Expanded(
                  child: Text(
                    '${doctor.specialization?.toUpperCase()}',
                    style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: false,
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.close, size: 37),
                onPressed: closeDetail,
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  doctor.title,
                  style: LoonoFonts.cardTitle.copyWith(color: LoonoColors.secondaryFont),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  '${doctor.getStreet()} ${doctor.houseNumber}\n${doctor.city}, ${doctor.getFormattedPostalCode()}',
                  style: const TextStyle(color: LoonoColors.grey, height: 1.6),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: registry.get<ApiService>().postProviderDetail(
              providersIds: [
                HealthcareProviderId((p) {
                  p
                    ..institutionId = doctor.institutionId
                    ..locationId = doctor.locationId;
                })
              ],
            ),
            builder: (
              BuildContext context,
              AsyncSnapshot<ApiResponse<HealthcareProviderDetailList>> snapshot,
            ) {
              if (snapshot.hasData) {
                HealthcareProviderDetail? detail;
                snapshot.data?.map(
                  success: (res) {
                    detail = res.data.healthcareProvidersDetails.first;
                  },
                  failure: (err) {},
                );
                final hasPhoneNumber =
                    detail?.phoneNumber != null && detail!.phoneNumber!.isNotEmpty;
                final hasEmail = detail?.email != null && detail!.email!.isNotEmpty;

                /// sometimes there is list of contacts so here we take only the first one
                final firstEmail = detail?.email?.split(',').first;
                final firstPhoneNumber = detail?.phoneNumber?.split(',').first;

                return Expanded(
                  child: Column(
                    children: [
                      if (hasPhoneNumber)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: ContactButton(
                            text: '$firstPhoneNumber',
                            iconPath: 'assets/icons/prevention/phone.svg',
                            action: () async {
                              final phoneLaunchUri = Uri(
                                scheme: 'tel',
                                path: firstPhoneNumber,
                              );
                              if (await canLaunch(phoneLaunchUri.toString())) {
                                await launch(phoneLaunchUri.toString());
                                await registry
                                    .get<FirebaseAnalytics>()
                                    .logEvent(name: 'ContactDoctorPhoneAction');
                              }
                            },
                          ),
                        ),
                      if (hasEmail)
                        ContactButton(
                          text: '$firstEmail',
                          iconPath: 'assets/icons/prevention/email.svg',
                          action: () async {
                            final emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: firstEmail,
                            );
                            if (await canLaunch(emailLaunchUri.toString())) {
                              await launch(emailLaunchUri.toString());
                              await registry
                                  .get<FirebaseAnalytics>()
                                  .logEvent(name: 'ContactDoctorEmailAction');
                            }
                          },
                        ),
                      if (!hasPhoneNumber && !hasEmail)
                        Flexible(
                          child: Column(
                            children: [
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: LoonoColors.primaryWashed,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 54,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(context.l10n.doctor_no_contact),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(context.l10n.doctor_contact_error);
              } else {
                return const Flexible(
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
