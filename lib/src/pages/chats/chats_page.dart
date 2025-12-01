import '../../routes/router.dart';
import 'package:flutter/material.dart';
import 'package:dyte_icons/dyte_icons.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:realtimekit_ui/src/strings.dart';
import 'package:realtimekit_ui/src/widgets/atoms/rtk_text.dart';
import 'package:realtimekit_ui/src/widgets/atoms/rtk_app_bar.dart';
import 'package:realtimekit_ui/src/pages/chats/widgets/chat_list_widget.dart';
import 'package:realtimekit_ui/src/pages/chats/widgets/input_bar_widget.dart';

class ChatsPage extends StatelessWidget {
  final String remainingTime;
  const ChatsPage({super.key, required this.remainingTime});

  @override
  Widget build(BuildContext context) {
    final chatPermissions = rtkMeeting.permissions.chat;
    return Scaffold(
      body: const SafeArea(child: ChatListWidget()),
      bottomNavigationBar:
          chatPermissions.canSendFiles || chatPermissions.canSendText
              ? const InputBarWidget()
              : null,
      appBar: RtkAppBar(
        remainingTime: remainingTime,
        title: RtkText(RtkStrings.chat),
        leadingIcon: const Icon(DyteIcons.dismiss),
        onPressed: () => RtkRouter.of(context).pop(),
      ),
    );
  }
}
