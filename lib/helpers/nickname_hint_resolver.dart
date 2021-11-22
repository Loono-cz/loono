import 'package:flutter/cupertino.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/models/user.dart';
import 'package:loono/services/db/database.dart';

String getHintText(BuildContext context, {required User? user}) {
  final String hintText;
  final userSex = user?.sex;
  if (userSex != null) {
    hintText = userSex.getNicknameHintLabel(context);
  } else {
    hintText = 'Ema';
  }
  return hintText;
}

String? getRealNicknameOrNull({required AuthUser? authUser}) {
  return authUser?.name?.split(' ').first;
}
