enum AppFlavor { prod, dev }

extension AppFlavorExt on AppFlavor {
  T map<T>({required T Function() prod, required T Function() dev}) {
    switch (this) {
      case AppFlavor.prod:
        return prod();
      case AppFlavor.dev:
        return dev();
    }
  }

  String get prettyString {
    return toString().split('.').last;
  }
}
