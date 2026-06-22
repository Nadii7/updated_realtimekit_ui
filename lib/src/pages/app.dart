import 'package:flutter/material.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:realtimekit_ui/src/strings.dart';
import 'package:realtimekit_ui/realtimekit_ui.dart';
import 'package:realtimekit_ui/src/tokens/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtimekit_ui/src/data/manage_listeners.dart';
import 'package:realtimekit_ui/src/pages/room_route_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class RtkApp extends ConsumerStatefulWidget {
  final bool canExit;
  final Function()? onExit;
  final Function()? onClose;
  final String remainingTime;
  final RtkMeetingInfo rtkMeetingInfo;

  const RtkApp(
    this.rtkMeetingInfo, {
    super.key,
    required this.onExit,
    required this.canExit,
    required this.onClose,
    required this.remainingTime,
  });
  @override
  ConsumerState<RtkApp> createState() => _RtkAppState();
}

class _RtkAppState extends ConsumerState<RtkApp> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    RtkListenerManager.init(ref);
    if (mounted) {
      RtkListenerManager.instance.registerRtkListeners();
    }
  }

  @override
  void didUpdateWidget(RtkApp oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if canExit changed from false to true
    if (!oldWidget.canExit && widget.canExit) {
      _handleExit();
    }
  }

  void _handleExit() {
    if (widget.onExit != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        rtkMeeting.leaveRoom();
        widget.onExit!();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(globalDesignToken.colorToken);
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [Locale(RtkStrings.locale)],
      theme: appTheme.theme,
      debugShowCheckedModeBanner: false,
      home: RoomRoutePage(
        onClose: widget.onClose,
        remainingTime: widget.remainingTime,
      ),
    );
  }

  @override
  void dispose() {
    RealtimeKitUIBuilder.dispose();
    super.dispose();
  }
}

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [RtkReleaseResourcesButton()],
      ),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
