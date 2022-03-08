import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/method_channel/method_channel_firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers/method_channels_handlers.dart';

const firebaseAuthChannel = MethodChannelFirebaseAuth.channel;

Future<FirebaseAuth> mockFirebaseAuth() async {
  await Firebase.initializeApp();

  const username = 'Adam tester';
  const providerId = 'provider-id';

  final defaultUserData = <String, dynamic>{
    'user': <String, dynamic>{
      'uid': '12345abcde',
      'email': 'test@loono.cz',
    },
    'additionalUserInfo': <String, dynamic>{
      'profile': <String, dynamic>{
        'foo': 'bar',
      },
      'isNewUser': true,
      'providerId': 'info$providerId',
      'username': 'info$username',
    },
    'authCredential': <String, dynamic>{
      'providerId': 'auth$providerId',
      'signInMethod': 'google',
    },
  };

  final kDefaultFirebaseAuthResponses = <String, dynamic>{
    'Auth#fetchSignInMethodsForEmail': <dynamic, dynamic>{
      'providers': <String>['google'],
    },
    'Auth#registerAuthStateListener': () => 'idTokenChannel',
    'Auth#registerIdTokenListener': () => 'authStateChannel',
    'Auth#signInWithCredential': defaultUserData,
  };

  final firebaseAuthResponses = Map<String, dynamic>.from(kDefaultFirebaseAuthResponses);
  firebaseAuthChannel.setMockMethodCallHandler((MethodCall methodCall) {
    final dynamic response = firebaseAuthResponses[methodCall.method];
    // todo: find better way of handling event channels
    if (response is String Function()) {
      final eventChannelName = response();
      handleEventChannel(eventChannelName);
      return Future<String>.value(eventChannelName);
    }
    return Future<dynamic>.value(response);
  });

  return FirebaseAuth.instance;
}
