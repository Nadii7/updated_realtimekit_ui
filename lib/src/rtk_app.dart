import 'package:flutter/material.dart';
import 'package:realtimekit_ui/src/di/di.dart';
import 'package:realtimekit_ui/src/strings.dart';
import 'package:realtimekit_ui/src/pages/app.dart';
import 'package:realtimekit_ui/realtimekit_ui.dart';
import 'package:realtimekit_ui/src/tokens/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtimekit_ui/src/data/provider_logger.dart';
import 'package:realtimekit_ui/src/tokens/size/size_config.dart';

class RealtimeKitUIInfo {
  final RtkMeetingInfo meetingInfo;
  final RtkDesignTokens _designToken;

  RtkDesignTokens get designToken => _designToken;

  RealtimeKitUIInfo(
    this.meetingInfo, {
    RtkDesignTokens? designToken,
  }) : _designToken = designToken ?? RtkDesignTokens();
}

class RtkConfig {
  bool skipSetupScreen = false;
}

class RealtimeKitUIBuilder {
  final RealtimeKitUIInfo uiKitInfo;

  RealtimeKitUIBuilder._(this.uiKitInfo, this.arbPath);
  final String? arbPath;

  static RealtimeKitUI build({
    required RealtimeKitUIInfo uiKitInfo,
    String? arbPath,
    RealtimekitClient? meeting,
    bool skipSetupPage = false,
    required bool canExit,
    required Function()? onExit,
    required Function()? onClose,
    required String remainingTime,
  }) {
    if (arbPath != null) {
      RtkStrings(arbPath: arbPath).init();
    }
    if (!getIt.isRegistered<RtkDesignTokens>()) {
      RtkDependencyHandler.setupDependencies(uiKitInfo, meeting);
    }
    return RealtimeKitUI(
      uiKitInfo,
      skipSetupPage: skipSetupPage,
      onExit: onExit,
      canExit: canExit,
      onClose: onClose,
      remainingTime: remainingTime,
    );
  }

  static void dispose() {
    RtkDependencyHandler.tearDownDependencies();
  }
}

class RealtimeKitUI extends StatelessWidget {
  final RealtimeKitUIInfo _uiKitInfo;
  final bool skipSetupPage;
  final bool canExit;
  final Function()? onExit;
  final Function()? onClose;
  final String remainingTime;

  const RealtimeKitUI(
    this._uiKitInfo, {
    this.skipSetupPage = false,
    super.key,
    required this.onExit,
    required this.canExit,
    required this.onClose,
    required this.remainingTime,
  });
  RealtimeKitUIInfo get uikitInfo => _uiKitInfo;
  RealtimekitClient get meeting => rtkMeeting;

  Widget _app() {
    rtkConfig.skipSetupScreen = skipSetupPage;
    return RtkApp(
      onExit: onExit,
      canExit: canExit,
      onClose: onClose,
      uikitInfo.meetingInfo,
      remainingTime: remainingTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RtkProvider(
      observers: [Logger()],
      meeting: rtkMeeting,
      uiKitInfo: uikitInfo,
      child: PopScope(canPop: false, child: _app()),
    );
  }
}

class RtkProvider extends StatefulWidget {
  const RtkProvider({
    Key? key,
    required this.child,
    required this.meeting,
    required this.uiKitInfo,
    this.observers,
  }) : super(key: key);

  final List<ProviderObserver>? observers;
  final Widget child;
  final RealtimekitClient meeting;
  final RealtimeKitUIInfo uiKitInfo;

  @override
  State<RtkProvider> createState() => _RtkProviderState();
}

class _RtkProviderState extends State<RtkProvider> {
  @override
  void initState() {
    if (!getIt.isRegistered<RtkDesignTokens>()) {
      RtkDependencyHandler.setupDependencies(
        widget.uiKitInfo,
        widget.meeting,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(globalDesignToken.colorToken);
    return OrientationBuilder(
      builder: (context, orientation) {
        SizeConfig().init(context);
        return ProviderScope(
          observers: widget.observers,
          child: Theme(
            data: appTheme.theme,
            child: widget.child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    RtkDependencyHandler.tearDownDependencies();
    super.dispose();
  }
}
