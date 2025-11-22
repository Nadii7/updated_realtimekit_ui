import 'package:realtimekit_ui/realtimekit_ui.dart';
import 'package:flutter/rendering.dart';

Key generateKeyForParticipant(
  RtkMeetingParticipant participant, {
  String pageName = 'RtkGridView',
}) {
  return Key(
      'RtkParticipant: ${participant.id}${participant.videoEnabled}Page:$pageName');
}

Key generateAudioKeyForParticipant(
  RtkMeetingParticipant participant, {
  String pageName = 'RtkGridView',
}) {
  return Key(
      'RtkParticipant: ${participant.id}${participant.audioEnabled}Page:$pageName');
}

Key generateVideoKeyForParticipant(RtkMeetingParticipant participant,
    {String pageName = 'RtkGridView'}) {
  return Key(
      'RtkParticipant: ${participant.id}${participant.videoEnabled}Page:$pageName');
}
