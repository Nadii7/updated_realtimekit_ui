import 'dart:io' show Platform;

import 'package:file_picker/file_picker.dart';

/// - iOS prefers file path/URL strings.
/// - Android prefers content:// URIs when available, falling back to path.
String resolveShareUri(PlatformFile file) {
  if (Platform.isIOS) {
    return file.path ?? file.uri.toString();
  }
  if (file.uri.scheme == 'content') {
    return file.uri.toString();
  }
  return file.path ?? file.uri.toString();
}
