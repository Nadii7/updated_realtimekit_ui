import 'package:material_ui/material_ui.dart';

mixin UiKitElement {
  double get borderRadius;
  double get borderWidth;
  Color get fillColor;
  Color get textColor;
}

mixin UsesStatusColor {
  Color get warningColor;
  Color get errorColor;
  Color get successColor;
}
