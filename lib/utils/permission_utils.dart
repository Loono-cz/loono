import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> getPermissionStatus(Permission permission) async {
  final status = await permission.status;
  switch (status) {
    case PermissionStatus.granted:
      return PermissionStatus.granted;
    case PermissionStatus.denied:
      final newStatus = await permission.request();
      if (newStatus == PermissionStatus.granted) {
        // Either the permission was already granted before or the user just granted it
        return PermissionStatus.granted;
      }
      // See https://github.com/Baseflow/flutter-permission-handler/wiki/Changes-in-6.0.0#breaking-changes
      if (newStatus == PermissionStatus.permanentlyDenied) {
        return PermissionStatus.permanentlyDenied;
      }
      return PermissionStatus.denied;
    case PermissionStatus.permanentlyDenied:
      return PermissionStatus.permanentlyDenied;
    case PermissionStatus.restricted:
    case PermissionStatus.limited:
      // The OS restricts access, for example because of parental controls (only supported on iOS)
      return PermissionStatus.limited;
  }
}
