import 'package:flutter/material.dart';
import 'package:dyte_icons/dyte_icons.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:realtimekit_ui/src/routes/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtimekit_ui/src/routes/route_names.dart';
import 'package:realtimekit_ui/src/pages/plugins/plugin_page.dart';

class RtkPluginIconWidget extends ConsumerWidget {
  final String remainingTime;

  const RtkPluginIconWidget({
    super.key,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        RtkRouter.of(context).push(
          RtkPluginsScreen(remainingTime: remainingTime),
          pageName: RouteNames.plugins,
        );
      },
      icon: Icon(
        DyteIcons.rocket,
        color: globalDesignToken.colorToken.textColor.shade1000,
      ),
    );
  }
}
