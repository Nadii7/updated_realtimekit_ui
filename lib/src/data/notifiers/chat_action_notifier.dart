import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:realtimekit_ui/src/di/riverpod_di.dart';
import 'package:realtimekit_ui/src/utils/uri_resolver.dart';

class ChatActionNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<void> sendText(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      ref
          .read(notificationProvider.notifier)
          .showCustomNotification('Message cannot be empty');
      return;
    }
    try {
      rtkMeeting.chat.sendTextMessage(trimmed);
    } catch (e) {
      ref
          .read(notificationProvider.notifier)
          .showCustomNotification(e.toString());
    }
  }

  Future<void> pickAndSendFile(BuildContext context) async {
    try {
      final result = await FilePicker.pickFile(
        type: FileType.any,
      );
      if (result == null) return;
      final toSend = resolveShareUri(result);
      if (toSend.isEmpty) return;
      rtkMeeting.chat.sendFileMessage(toSend, (error) {
        if (error != null) {
          ref
              .read(notificationProvider.notifier)
              .showCustomNotification(error.message);
        }
      });
    } catch (e) {
      ref
          .read(notificationProvider.notifier)
          .showCustomNotification(e.toString());
    }
  }

  Future<void> pickAndSendImage(BuildContext context) async {
    try {
      final result = await FilePicker.pickFile(
        type: FileType.image,
      );
      if (result == null) return;
      final toSend = resolveShareUri(result);
      if (toSend.isEmpty) return;
      rtkMeeting.chat.sendImageMessage(toSend, (error) {
        if (error != null) {
          ref
              .read(notificationProvider.notifier)
              .showCustomNotification(error.message);
        }
      });
    } catch (e) {
      ref
          .read(notificationProvider.notifier)
          .showCustomNotification(e.toString());
    }
  }
}
