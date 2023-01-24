import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/simple_health_care_provider_helper.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class SearchDoctorCard extends StatelessWidget {
  const SearchDoctorCard({
    Key? key,
    required this.onTap,
    required this.item,
  }) : super(key: key);

  final Function() onTap;
  final SimpleHealthcareProvider item;

  @override
  Widget build(BuildContext context) {
    final specialization = item.specialization;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 165.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                LoonoColors.greenLight,
              ],
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (specialization != null)
                          Expanded(
                            child: Text(
                              specialization.toUpperCase(),
                              style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        FutureBuilder(
                          future: registry.get<ApiService>().postProviderDetail(
                            providersIds: [
                              HealthcareProviderId((p) {
                                p
                                  ..institutionId = item.institutionId
                                  ..locationId = item.locationId;
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

                              return Row(
                                children: [
                                  if (hasPhoneNumber) ...[
                                    const SizedBox(width: 8),
                                    SvgPicture.asset(
                                      'assets/icons/telephone.svg',
                                      color: LoonoColors.grey,
                                    ),
                                  ],
                                  if (hasEmail) ...[
                                    const SizedBox(width: 8),
                                    SvgPicture.asset(
                                      'assets/icons/at.svg',
                                      color: LoonoColors.grey,
                                    ),
                                  ],
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text(context.l10n.doctor_contact_error);
                            } else {
                              return const Flexible(
                                child: Center(child: CircularProgressIndicator.adaptive()),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        item.title,
                        style: LoonoFonts.cardTitle.copyWith(color: LoonoColors.secondaryFont),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${item.getStreet()} ${item.houseNumber}',
                      style: LoonoFonts.cardAddress,
                    ),
                    Text(
                      '${item.city}, ${item.getFormattedPostalCode()}',
                      style: LoonoFonts.cardAddress,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
