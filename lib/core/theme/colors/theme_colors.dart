part of "package:pizza_hut_client_mobile/core/theme/themes.dart";

/// A set of colors for the entire app.
const ColorScheme colorLightScheme = ColorScheme(
  brightness: Brightness.light,

  /// primary
  primary: Color(0xFFDA1A32),
  onPrimary: Colors.white,
  primaryContainer: Color(0xFFFFF1F3),

  surface: Colors.white,
  onSurface: Color(0xFF222222),
  surfaceContainerHighest: Color(0xFFF5F5F5),

  secondary: Color(0xFF43A250),
  onSecondary: Colors.white,
  secondaryContainer: Color(0xFF343434),

  tertiary: Color(0xFF1570EF),
  onTertiary: Colors.white,
  tertiaryContainer: Color.fromRGBO(126, 95, 166, 0.35),

  error: Color(0xFFFF543E),
  onError: Colors.white,
  errorContainer: Color(0xFFFFFBFA),

  outline: Color(0xFFD0D5DD),
  shadow: Color.fromRGBO(0, 0, 0, 0.05),
);

///
const ColorScheme colorDarkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF2277F6),
  onPrimary: Colors.white,
  surface: Color(0xFF27292C),
  onSurface: Colors.white,
  secondary: Color(0xFF69D7C7),
  onSecondary: Color(0xFF020000),
  error: Color(0xFFFF6C6C),
  onError: Colors.white,
  surfaceContainerHighest: Color(0xFFF5F5F5),
  secondaryContainer: Color(0xFF343434),
);

class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.background,
    required this.onBackground,
    required this.main,
    required this.green,
    required this.primaryText,
    required this.secondaryText,
    required this.orange,
    required this.sunburnOuch,
    required this.purple,
    required this.blueWood,
  });

  final Color background;
  final Color onBackground;
  final Color primaryText;
  final Color secondaryText;
  final Color main;
  final Color green;
  final Color orange;
  final Color sunburnOuch;
  final Color purple;
  final Color blueWood;

  static const ThemeColors light = ThemeColors(
    background: Color(0xFFF2F4F7),
    onBackground: Color(0xFF222222),
    main: Color(0xFF27292C),
    green: Color(0xFF32B141),
    primaryText: Color(0xFF222222),
    secondaryText: Color(0xFF667085),
    orange: Color(0xFFFFC500),
    sunburnOuch: Color(0xFFEB5A26),
    purple: Color(0xFF7E5FA6),
    blueWood: Color(0xFF344054),
  );

  static const ThemeColors dark = ThemeColors(
    background: Color(0xFF1C1E21),
    onBackground: Color(0xFF909090),
    main: Color(0xFF27292C),
    green: Color(0xFF32B141),
    primaryText: Color(0xFF101828),
    secondaryText: Color(0xFF909090),
    orange: Color(0xFFFFC500),
    sunburnOuch: Color(0xFFEB5A26),
    purple: Color(0xFF7E5FA6),
    blueWood: Color(0xFF344054),
  );

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? background,
    Color? onBackground,
    Color? main,
    Color? green,
    Color? primaryText,
    Color? secondaryText,
    Color? orange,
    Color? sunburnOuch,
    Color? purple,
    Color? blueWood,
  }) =>
      ThemeColors(
        primaryText: primaryText ?? this.primaryText,
        secondaryText: secondaryText ?? this.secondaryText,
        background: background ?? this.background,
        onBackground: onBackground ?? this.onBackground,
        green: green ?? this.green,
        main: main ?? this.main,
        orange: orange ?? this.orange,
        sunburnOuch: sunburnOuch ?? this.sunburnOuch,
        purple: purple ?? this.purple,
        blueWood: blueWood ?? this.blueWood,
      );

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }
    return ThemeColors(
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      green: Color.lerp(green, other.green, t)!,
      main: Color.lerp(main, other.main, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      sunburnOuch: Color.lerp(sunburnOuch, other.sunburnOuch, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      blueWood: Color.lerp(blueWood, other.blueWood, t)!,
    );
  }
}
