import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:selene/core/constants/layout_constants.dart';

extension ResponsiveLayout on BuildContext {
  ResponsiveBreakpointsData get responsive => ResponsiveBreakpoints.of(this);

  bool get isCompact => responsive.breakpoint.name == kCompact;
  bool get isMedium => responsive.breakpoint.name == kMedium;
  bool get isExpanded => responsive.breakpoint.name == kExpanded;
  bool get isLarge => responsive.breakpoint.name == kLarge;
  bool get isExtraLarge => responsive.breakpoint.name == kExtraLarge;

  bool get atLeastCompact => responsive.largerOrEqualTo(kCompact);
  bool get atLeastMedium => responsive.largerOrEqualTo(kMedium);
  bool get atLeastExpanded => responsive.largerOrEqualTo(kExpanded);
  bool get atLeastLarge => responsive.largerOrEqualTo(kLarge);
  bool get atLeastExtraLarge => responsive.largerOrEqualTo(kExtraLarge);
}
