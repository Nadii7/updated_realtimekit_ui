import 'package:realtimekit_ui/src/di/riverpod_di.dart';
import 'package:realtimekit_ui/src/pages/room/widgets/rtk_menu_widget.dart';
import 'package:realtimekit_ui/src/tokens/theme.dart';
import 'package:realtimekit_ui/src/widgets/atoms/rtk_bottom_nav_button.dart';
import 'package:realtimekit_ui/src/widgets/atoms/rtk_text.dart';
import 'package:realtimekit_ui/src/widgets/atoms/vh_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/di.dart';

class MoreButtonWidget extends ConsumerWidget {
  final String remainingTime;
  final bool canLivestream;
  final bool showLabel;
  const MoreButtonWidget({
    super.key,
    this.canLivestream = false,
    this.showLabel = false,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: hspace12.width,
      child: Stack(
        children: [
          Center(
            child: RtkBottomNavButton(
              icon: const Icon(Icons.more_horiz_sharp),
              iconColor: textColorSwatch.shade1000,
              showLabel: showLabel,
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) => RtkMenuWidget(
                    remainingTime: remainingTime,
                    canLivestream: canLivestream,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 4,
            child: UnreadCountWidget(
              unreadNotifiers: [
                unreadChatNotifier,
                unreadPollsNotifier,
                unreadWaitlistedCountNotifier,
                unreadStageRequestCountNotifier,
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UnreadCountWidget extends ConsumerWidget {
  final List<NotifierProvider<Notifier<int>, int>> unreadNotifiers;
  const UnreadCountWidget({super.key, required this.unreadNotifiers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int totalUnread =
        unreadNotifiers.map<int>((e) => ref.watch(e)).reduce((a, b) => a + b);
    final bool isIndividualUnread = unreadNotifiers.length <= 2;
    final theme = AppTheme(globalDesignToken.colorToken).theme;
    return OrientationBuilder(builder: (context, orientation) {
      final bool isPortrait = orientation == Orientation.portrait;
      final markDiameter = isIndividualUnread
          ? vspace3.height
          : isPortrait
              ? vspace3.height!
              : hspace3.width!;
      return totalUnread > 0
          ? Container(
              height: markDiameter,
              width: markDiameter,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: RtkText(
                  (totalUnread > 99
                      ? "99+"
                      : totalUnread
                          .toString()), // (totalUnread > 99 ? "99+" : totalUnread.toString()),
                  rtkTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: totalUnread > 99
                        ? isIndividualUnread
                            ? vspace1_25.height!
                            : isPortrait
                                ? vspace1_25.height!
                                : hspace1.width!
                        : isIndividualUnread
                            ? vspace1_5.height!
                            : isPortrait
                                ? vspace1_75.height!
                                : hspace2.width!,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
