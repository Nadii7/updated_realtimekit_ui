import 'package:dyte_icons/dyte_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:realtimekit_core/realtimekit_core.dart';
import 'package:realtimekit_ui/src/di/riverpod_di.dart';
import 'package:realtimekit_ui/src/strings.dart';
import 'package:realtimekit_ui/src/tokens/theme.dart';
import 'package:realtimekit_ui/src/widgets/atoms/rtk_list_tile.dart';
import 'package:realtimekit_ui/src/widgets/atoms/rtk_text.dart';

class AttachmentsSheetWidget extends ConsumerWidget {
  const AttachmentsSheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme(globalDesignToken.colorToken).theme;

    return Material(
      color: theme.colorScheme.primaryContainer,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderToken.getRadius(BorderSize.two)),
        topRight: Radius.circular(borderToken.getRadius(BorderSize.two)),
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          children: [
            RtkListTile(
              leading: Icon(
                DyteIcons.attach,
                color: globalDesignToken.colorToken.textColor.shade1000,
              ),
              title: RtkText(RtkStrings.file),
              onTap: () async {
                Navigator.of(context).pop();
                await ref
                    .read(chatActionNotifierProvider.notifier)
                    .pickAndSendFile(context);
              },
            ),
            const Divider(height: 1),
            RtkListTile(
              leading: Icon(
                DyteIcons.image,
                color: globalDesignToken.colorToken.textColor.shade1000,
              ),
              title: RtkText(RtkStrings.image),
              onTap: () async {
                Navigator.of(context).pop();
                await ref
                    .read(chatActionNotifierProvider.notifier)
                    .pickAndSendImage(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
