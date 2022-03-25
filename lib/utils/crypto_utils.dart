import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

String generateSecureNonce() => generateNonce();

class CryptoNonce {
  CryptoNonce() {
    rawNonce = generateSecureNonce();
    nonce = sha256ofString(rawNonce);
  }

  late final String nonce;
  late final String rawNonce;
}
