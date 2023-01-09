import 'package:flutter/services.dart';
import 'package:loono/constants.dart';

final accountChannel = AccountChannel();

class AccountChannel {
  final MethodChannel _channel = const MethodChannel(LoonoStrings.platformSpecificAccountChannel);

  void loggedIn() {
    setIsLoggedIn(true);
  }

  void loggedOut() {
    setIsLoggedIn(false);
  }

  void setIsLoggedIn(bool loggedIn) {
    _channel.invokeMethod<void>(LoonoStrings.platformSpecificAccountChannelLoggedIn, loggedIn);
  }
}
