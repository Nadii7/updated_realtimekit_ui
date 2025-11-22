import 'package:dyte_icons/dyte_icons.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:realtimekit_ui/src/di/riverpod_di.dart';
import 'package:realtimekit_ui/src/pages/chats/chats_page.dart';
import 'package:realtimekit_ui/src/routes/route_names.dart';
import 'package:realtimekit_ui/src/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RtkChatIconWidget extends ConsumerWidget {
  final String remainingTime;
  const RtkChatIconWidget({
    super.key,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(unreadChatNotifier.notifier).readAllMessages(
              ref.read(chatListNotifier).length,
            );
        RtkRouter.of(context).push(
          pageName: RouteNames.chats,
          ChatsPage(remainingTime: remainingTime),
        );
      },
      icon: Icon(
        DyteIcons.chat,
        color: globalDesignToken.colorToken.textColor.shade1000,
      ),
    );
  }
}
