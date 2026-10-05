import 'package:flutter/foundation.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtimekit_ui/src/di/riverpod_di.dart';

class RtkListenerManager {
  final WidgetRef ref;

  RtkListenerManager._(this.ref);

  static RtkListenerManager? _instance;

  /// Replaces the stored instance (and its `ref`) on every call, and detaches
  /// whatever the previous instance had registered.
  static void init(WidgetRef ref) {
    _instance?._detach();
    _instance = RtkListenerManager._(ref);
  }

  static RtkListenerManager get instance {
    assert(
      _instance != null,
      'RtkListenerManager not initialized, please call init()',
    );
    return _instance!;
  }

  final List<void Function()> _removers = [];

  /// Adds [listener] now and remembers how to remove that same instance.
  void _track<T>(T listener, void Function(T) add, void Function(T) remove) {
    add(listener);
    _removers.add(() => remove(listener));
  }

  void registerRtkListeners() {
    // Guard against double registration without an unregister in between.
    _detach();

    // Room events
    _track(
      ref.read(routerNotifier.notifier),
      rtkMeeting.addMeetingRoomEventListener,
      rtkMeeting.removeMeetingRoomEventListener,
    );

    // Self events
    _track(
      ref.read(localUserSettingsProvider.notifier),
      rtkMeeting.addSelfEventListener,
      rtkMeeting.removeSelfEventListener,
    );
    _track(
      ref.read(routerNotifier.notifier),
      rtkMeeting.addSelfEventListener,
      rtkMeeting.removeSelfEventListener,
    );
    _track(
      ref.read(selfScreenshareProvider.notifier),
      rtkMeeting.addSelfEventListener,
      rtkMeeting.removeSelfEventListener,
    );

    // Participants events
    _track(
      ref.read(participantEventNotifier.notifier),
      rtkMeeting.addParticipantsEventListener,
      rtkMeeting.removeParticipantsEventListener,
    );
    _track(
      ref.read(gridNotifier.notifier),
      rtkMeeting.addParticipantsEventListener,
      rtkMeeting.removeParticipantsEventListener,
    );

    // Chat events
    _track(
      ref.read(chatListNotifier.notifier),
      rtkMeeting.addChatEventListener,
      rtkMeeting.removeChatEventListener,
    );
    _track(
      ref.read(unreadChatNotifier.notifier),
      rtkMeeting.addChatEventListener,
      rtkMeeting.removeChatEventListener,
    );

    // Data update events
    _track(
      ref.read(screenshareProvider.notifier),
      rtkMeeting.addDataUpdateEventListener,
      rtkMeeting.removeDataUpdateEventListener,
    );
    _track(
      ref.read(pluginProvider.notifier),
      rtkMeeting.addDataUpdateEventListener,
      rtkMeeting.removeDataUpdateEventListener,
    );

    // Recording events
    _track(
      ref.read(recordingNotifier.notifier),
      rtkMeeting.addRecordingEventListener,
      rtkMeeting.removeRecordingEventListener,
    );

    // Waitlist events
    _track(
      ref.read(waitingRoomNotifier.notifier),
      rtkMeeting.addWaitlistEventListener,
      rtkMeeting.removeWaitlistEventListener,
    );
    _track(
      ref.read(unreadWaitlistedCountNotifier.notifier),
      rtkMeeting.addWaitlistEventListener,
      rtkMeeting.removeWaitlistEventListener,
    );

    // Polls events
    _track(
      ref.read(newPollEventNotifier.notifier),
      rtkMeeting.addPollsEventListener,
      rtkMeeting.removePollsEventListener,
    );
    _track(
      ref.read(pollsListNotifier.notifier),
      rtkMeeting.addPollsEventListener,
      rtkMeeting.removePollsEventListener,
    );
    _track(
      ref.read(unreadPollsNotifier.notifier),
      rtkMeeting.addPollsEventListener,
      rtkMeeting.removePollsEventListener,
    );

    // Stage events
    _track(
      ref.read(unreadStageRequestCountNotifier.notifier),
      rtkMeeting.addStageEventListener,
      rtkMeeting.removeStageEventListener,
    );
    _track(
      ref.read(stageStatusNotifier.notifier),
      rtkMeeting.addStageEventListener,
      rtkMeeting.removeStageEventListener,
    );
    _track(
      ref.read(stageRequestsNotifier.notifier),
      rtkMeeting.addStageEventListener,
      rtkMeeting.removeStageEventListener,
    );
    _track(
      ref.read(participantsProvider.notifier),
      rtkMeeting.addStageEventListener,
      rtkMeeting.removeStageEventListener,
    );

    // For notifications across the SDK
    _track(
      ref.read(notificationProvider.notifier),
      rtkMeeting.addChatEventListener,
      rtkMeeting.removeChatEventListener,
    );
    _track(
      ref.read(notificationProvider.notifier),
      rtkMeeting.addPollsEventListener,
      rtkMeeting.removePollsEventListener,
    );
    _track(
      ref.read(notificationProvider.notifier),
      rtkMeeting.addParticipantsEventListener,
      rtkMeeting.removeParticipantsEventListener,
    );
    _track(
      ref.read(notificationProvider.notifier),
      rtkMeeting.addPluginsEventListener,
      rtkMeeting.removePluginsEventListener,
    );

    // Livestream events
    _track(
      ref.read(lvsStateNotifier.notifier),
      rtkMeeting.addLivestreamEventListener,
      rtkMeeting.removeLivestreamEventListener,
    );
  }

  /// Detaches every listener that was registered, then resets provider state.
  ///
  /// Detaching happens first, using the remembered instances, and only then
  /// are the providers invalidated.
  void unregisterRtkListeners() {
    _detach();

    ref.invalidate(localUserSettingsProvider);
    ref.invalidate(routerNotifier);
    ref.invalidate(participantEventNotifier);
    ref.invalidate(chatListNotifier);
    ref.invalidate(gridNotifier);
    ref.invalidate(screenshareProvider);
    ref.invalidate(recordingNotifier);
    ref.invalidate(pluginProvider);
    ref.invalidate(waitingRoomNotifier);
    ref.invalidate(newPollEventNotifier);
    ref.invalidate(pollsListNotifier);
    ref.invalidate(unreadPollsNotifier);
    ref.invalidate(unreadChatNotifier);
    ref.invalidate(unreadWaitlistedCountNotifier);
    ref.invalidate(unreadStageRequestCountNotifier);
    ref.invalidate(notificationProvider);
    ref.invalidate(lvsStateNotifier);
    ref.invalidate(stageStatusNotifier);
    ref.invalidate(stageRequestsNotifier);
    ref.invalidate(selfScreenshareProvider);
    ref.invalidate(participantsProvider);
  }

  void detachListeners() => _detach();

  void _detach() {
    for (final remove in _removers) {
      try {
        remove();
      } catch (e) {
        debugPrint('RtkListenerManager: failed to remove listener: $e');
      }
    }
    _removers.clear();
  }
}
