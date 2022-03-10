import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

final googleSignInMethodChannel = MethodChannelGoogleSignIn().channel;

void mockGoogleSignIn() {
  const defaultUserData = <String, dynamic>{
    'email': 'adam.test@loono.cz',
    'id': '6283551361657636368615',
    'photoUrl': null,
    'displayName': 'Adam Novák',
    'serverAuthCode': '789'
  };

  const defaultSignInResponse = <String, dynamic>{
    'init': null,
    'signIn': defaultUserData,
    'signOut': null,
    'disconnect': null,
    'isSignedIn': true,
    'getTokens': <dynamic, dynamic>{
      'idToken': '123abc',
      'accessToken': '456def',
    },
  };

  final googleSignInResponses = Map<String, dynamic>.from(defaultSignInResponse);
  googleSignInMethodChannel.setMockMethodCallHandler((MethodCall methodCall) {
    return Future<dynamic>.value(googleSignInResponses[methodCall.method]);
  });
}

void tearDownGoogleSignIn() {
  googleSignInMethodChannel.setMockMethodCallHandler((MethodCall methodCall) {
    return null;
  });
}
