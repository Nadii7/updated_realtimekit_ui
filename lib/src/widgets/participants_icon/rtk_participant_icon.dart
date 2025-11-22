import 'package:dyte_icons/dyte_icons.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:realtimekit_ui/src/pages/participants/participants_page.dart';
import 'package:realtimekit_ui/src/routes/route_names.dart';
import 'package:realtimekit_ui/src/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RtkParticipantsIconWidget extends ConsumerWidget {
  final String remainingTime;
  const RtkParticipantsIconWidget({
    super.key,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        RtkRouter.of(context).push(
          pageName: RouteNames.participants,
          RtkParticipantsPage(remainingTime: remainingTime),
        );
      },
      icon: Icon(
        DyteIcons.participants,
        color: globalDesignToken.colorToken.textColor.shade1000,
      ),
    );
  }
}
