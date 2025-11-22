import 'package:dyte_icons/dyte_icons.dart';
import 'package:realtimekit_ui/realtimekit_ui.dart';
import 'package:realtimekit_ui/src/data/notifiers/audio_notifier.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:realtimekit_ui/src/tokens/theme.dart';
import 'package:realtimekit_ui/src/utils/generate_key.dart';
import 'package:flutter/material.dart';

class RtkAudioIndicatorIconWidget extends StatefulWidget {
  final RtkMeetingParticipant participant;
  final double? iconSize;
  RtkAudioIndicatorIconWidget({
    super.key,
    required this.participant,
    this.iconSize,
  })  : isLocalUser = participant.id == rtkMeeting.localUser.id,
        localUserAudioNotifier = participant.id == rtkMeeting.localUser.id
            ? LocalUserAudioNotifier()
            : null,
        audioNotifier = participant.id != rtkMeeting.localUser.id
            ? AudioNotifier(participant)
            : null {
    if (isLocalUser) {
      rtkMeeting.addSelfEventListener(localUserAudioNotifier!);
    } else {
      rtkMeeting.addParticipantsEventListener(audioNotifier!);
    }
  }

  final LocalUserAudioNotifier? localUserAudioNotifier;
  final AudioNotifier? audioNotifier;

  final bool isLocalUser;

  @override
  State<RtkAudioIndicatorIconWidget> createState() => _AudioIconState();
}

class _AudioIconState extends State<RtkAudioIndicatorIconWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme(globalDesignToken.colorToken).theme;
    if (widget.localUserAudioNotifier != null) {
      return ValueListenableBuilder(
        valueListenable: widget.localUserAudioNotifier!,
        builder: (context, bool audioEnabled, child) {
          return Icon(
            audioEnabled ? DyteIcons.mic_on : DyteIcons.mic_off,
            key: generateAudioKeyForParticipant(
              widget.participant,
              pageName: 'AudioIcon',
            ),
            size: widget.iconSize ?? 24,
            color: audioEnabled
                ? theme.colorScheme.onSecondary
                : theme.colorScheme.error,
          );
        },
      );
    } else {
      return ValueListenableBuilder(
        valueListenable: widget.audioNotifier!,
        builder: (context, bool audioEnabled, child) {
          return Icon(
            audioEnabled ? DyteIcons.mic_on : DyteIcons.mic_off,
            key: generateAudioKeyForParticipant(
              widget.participant,
              pageName: 'AudioIcon',
            ),
            size: widget.iconSize ?? 24,
            color: audioEnabled
                ? theme.colorScheme.onSecondary
                : theme.colorScheme.error,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    if (widget.localUserAudioNotifier != null) {
      rtkMeeting.removeSelfEventListener(widget.localUserAudioNotifier!);
    } else if (widget.audioNotifier != null) {
      rtkMeeting.removeParticipantsEventListener(widget.audioNotifier!);
    }
    super.dispose();
  }
}
