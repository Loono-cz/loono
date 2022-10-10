import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/social_login_account.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/submit_account.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/onboarding/app_bar.dart';
import 'package:loono/ui/widgets/settings/checkbox.dart';
import 'package:loono/utils/registry.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsletterAndGDPRScreen extends StatefulWidget {
  const NewsletterAndGDPRScreen({
    required this.socialLoginAccount,
    Key? key,
  }) : super(key: key);

  final SocialLoginAccount? socialLoginAccount;

  @override
  State createState() => NewsletterAndGDPRScreenState();
}

class NewsletterAndGDPRScreenState extends State<NewsletterAndGDPRScreen> {
  SocialLoginAccount? get socialLoginAccount => widget.socialLoginAccount;

  var newsletter = true;
  var gdpr = true;

  final _usersDao = registry.get<DatabaseService>().users;

  final _apiService = registry.get<ApiService>();
  final _authService = registry.get<AuthService>();
  final _examinationQuestionnairesDao = registry.get<DatabaseService>().examinationQuestionnaires;
  final _userRepository = registry.get<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAccountAppBar(context, step: 3),
      backgroundColor: null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              _buildNewsletter(context),
              const SizedBox(
                height: 50,
              ),
              _buildGDPR(context),
              const SizedBox(
                height: 70,
              ),
              AsyncLoonoButton(
                text: context.l10n.create_new_account,
                asyncCallback: () async {
                  await submitAccount(
                    context,
                    socialLoginAccount,
                    _authService,
                    _usersDao,
                    _examinationQuestionnairesDao,
                    _apiService,
                    _userRepository,
                    newsletter,
                  );
                  return null;
                },
                onSuccess: () {},
                onError: () {},
                enabled: gdpr,
              ),
              const SizedBox(height: 18.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsletter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context.l10n.fallback_account_newsletter_title),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: CheckboxCustom(
                text: '',
                isChecked: newsletter,
                whatIsChecked: (checked) => setState(() {
                  newsletter = checked;
                }),
                paddingLeft: 0,
              ),
            ),
            Expanded(
              child: _buildDescription(
                context.l10n.fallback_account_newsletter_desc,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGDPR(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context.l10n.fallback_account_gdpr_title),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: CheckboxCustom(
                text: '',
                isChecked: gdpr,
                whatIsChecked: (checked) => setState(() {
                  gdpr = checked;
                }),
                paddingLeft: 0,
              ),
            ),
            Expanded(
              child: _buildGDPRDescription(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGDPRDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 4.0),
      child: RichText(
        softWrap: true,
        text: TextSpan(
          text: context.l10n.fallback_account_gdpr_desc1,
          style: const TextStyle(
            color: LoonoColors.black,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
          children: <TextSpan>[
            _buildLink(
              context.l10n.fallback_account_gdpr_terms,
              LoonoStrings.termsUrl,
            ),
            const TextSpan(text: ', '),
            _buildLink(
              context.l10n.fallback_account_gdpr_privacy,
              LoonoStrings.privacyUrl,
            ),
            const TextSpan(text: ' '),
            TextSpan(text: context.l10n.fallback_account_gdpr_desc2),
          ],
        ),
      ),
    );
  }

  TextSpan _buildLink(String text, String url) {
    return TextSpan(
      text: text,
      style: const TextStyle(
        decoration: TextDecoration.underline,
        color: LoonoColors.primary,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          if (await canLaunchUrlString(url)) {
            await launchUrlString(url);
          }
        },
    );
  }

  Widget _buildTitle(String text) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: LoonoColors.black, fontSize: 16.0),
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 4.0),
      child: Text(
        description,
        //textAlign: TextAlign.justify,
        style: const TextStyle(
          color: LoonoColors.black,
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
