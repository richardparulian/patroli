import 'package:flutter/material.dart';

class ScreenUtil {
  // Singleton pattern
  static final ScreenUtil _instance = ScreenUtil._internal();
  factory ScreenUtil() => _instance;
  ScreenUtil._internal();

  // Screen dimensions
  static double _screenWidth = _designWidth;
  static double _screenHeight = _designHeight;
  static double _pixelRatio = 1.0;
  static double _bottomBarHeight = 0.0;
  static double _topBarHeight = 0.0;
  static double _statusBarHeight = 0.0;
  static EdgeInsets _padding = EdgeInsets.zero;
  static EdgeInsets _viewInsets = EdgeInsets.zero;
  static bool _isInitialized = false;

  // Base design size (iPhone 12/13/14 Pro as reference)
  static const double _designWidth = 390.0;
  static const double _designHeight = 844.0;

  /// Initialize ScreenUtil with context
  /// Call this once in the root of your app
  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _topBarHeight = mediaQuery.padding.top;
    _statusBarHeight = mediaQuery.padding.top;
    _padding = mediaQuery.padding;
    _viewInsets = mediaQuery.viewInsets;
    _isInitialized = true;
  }

  // ==================== WIDTH METHODS ====================

  /// Get width percentage of screen
  static double wp(double percent) {
    if (!_initialized) return percent;
    return _screenWidth * (percent / 100);
  }

  /// Scale width from design size
  static double sw(double designWidth) {
    if (!_initialized) return designWidth;
    return (designWidth / _designWidth) * _screenWidth;
  }

  // ==================== HEIGHT METHODS ====================

  /// Get height percentage of screen
  static double hp(double percent) {
    if (!_initialized) return percent;
    return _screenHeight * (percent / 100);
  }

  /// Scale height from design size
  static double sh(double designHeight) {
    if (!_initialized) return designHeight;
    return (designHeight / _designHeight) * _screenHeight;
  }

  /// Get safe height (total height minus safe areas)
  static double get safeHeight {
    if (!_initialized) return 844.0;
    return _screenHeight - _topBarHeight - _bottomBarHeight;
  }

  /// Get safe height percentage
  static double safeHp(double percent) {
    if (!_initialized) return percent;
    return safeHeight * (percent / 100);
  }

  // ==================== FONT METHODS ====================

  /// Scale font size from design size (locked to device scale)
  /// This font will NOT change with system font settings
  static double sp(double designFontSize) {
    if (!_initialized) return designFontSize;
    final scaleFactor = _screenWidth / _designWidth;
    return designFontSize * scaleFactor;
  }

  /// Scale font size using system scale (respects system font settings)
  /// Use this if you want font to respect system accessibility settings
  static double ssp(double designFontSize, BuildContext context) {
    if (!_initialized) return designFontSize;
    final mediaQuery = MediaQuery.of(context);
    final scaleFactor = _screenWidth / _designWidth;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);
    return designFontSize * scaleFactor * textScaleFactor;
  }

  // ==================== SPACING METHODS ====================

  /// Scale spacing from design size (uses width scale)
  static double spacing(double designSpacing) {
    return sw(designSpacing);
  }

  /// Scale padding from design size
  static EdgeInsets paddingFromDesign({
    double? left,
    double? right,
    double? top,
    double? bottom,
    double? horizontal,
    double? vertical,
    double? all,
  }) {
    return EdgeInsets.only(
      left: horizontal != null ? sw(horizontal) : (all != null ? sw(all) : left != null ? sw(left) : 0),
      right: horizontal != null ? sw(horizontal) : (all != null ? sw(all) : right != null ? sw(right) : 0),
      top: vertical != null ? sh(vertical) : (all != null ? sw(all) : top != null ? sh(top) : 0),
      bottom: vertical != null ? sh(vertical) : (all != null ? sw(all) : bottom != null ? sh(bottom) : 0),
    );
  }

  // ==================== BORDER RADIUS ====================

  /// Scale border radius from design size
  static double radius(double designRadius) {
    return sw(designRadius);
  }

  /// Scale border radius for all corners
  static BorderRadius radiusAll(double designRadius) {
    return BorderRadius.circular(radius(designRadius));
  }

  /// Scale border radius for specific corners
  static BorderRadius radiusOnly({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return BorderRadius.only(
      topLeft: topLeft != null ? Radius.circular(radius(topLeft)) : Radius.zero,
      topRight: topRight != null ? Radius.circular(radius(topRight)) : Radius.zero,
      bottomLeft: bottomLeft != null ? Radius.circular(radius(bottomLeft)) : Radius.zero,
      bottomRight: bottomRight != null ? Radius.circular(radius(bottomRight)) : Radius.zero,
    );
  }

  // ==================== ICON SIZE ====================

  /// Scale icon size from design size
  static double icon(double designIconSize) {
    return sw(designIconSize);
  }

  // ==================== GETTERS ====================

  static bool get _initialized => _isInitialized;

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  static double get pixelRatio => _pixelRatio;
  static double get bottomBarHeight => _bottomBarHeight;
  static double get topBarHeight => _topBarHeight;
  static double get statusBarHeight => _statusBarHeight;
  static EdgeInsets get padding => _padding;
  static EdgeInsets get viewInsets => _viewInsets;
  static double get orientation => _screenWidth > _screenHeight ? 1 : 0; // 1 = landscape, 0 = portrait

  static bool get isPortrait => _screenWidth <= _screenHeight;
  static bool get isLandscape => _screenWidth > _screenHeight;
}

// Extension for easier access
extension ScreenUtilExtension on num {
  double get wp => ScreenUtil.wp(toDouble());
  double get hp => ScreenUtil.hp(toDouble());
  double get sw => ScreenUtil.sw(toDouble());
  double get sh => ScreenUtil.sh(toDouble());
  double get sp => ScreenUtil.sp(toDouble());
  double get spacing => ScreenUtil.spacing(toDouble());
  double get radius => ScreenUtil.radius(toDouble());
  double get icon => ScreenUtil.icon(toDouble());
}
