part of "package:pizza_hut_client_mobile/core/theme/themes.dart";

class ThemeGradients extends ThemeExtension<ThemeGradients> {
  const ThemeGradients({
    required this.buttonLinearGradient,
    required this.shadowDecoration,
  });

  final LinearGradient buttonLinearGradient;
  final BoxDecoration shadowDecoration;

  static const ThemeGradients light = ThemeGradients(
    buttonLinearGradient: LinearGradient(
      colors: <Color>[Color(0xFF2277F6), Color(0xFF1364DD)],
      stops: <double>[0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    shadowDecoration: BoxDecoration(
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          blurRadius: 40,
          offset: Offset(0, -1),
          color: Color.fromRGBO(0, 0, 0, 0.05),
        ),
      ],
    ),
  );
  static const ThemeGradients dark = ThemeGradients(
    buttonLinearGradient: LinearGradient(
      colors: <Color>[Color(0xFF2277F6), Color(0xFF1364DD)],
      stops: <double>[0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    shadowDecoration: BoxDecoration(
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          blurRadius: 40,
          offset: Offset(0, -1),
          color: Color.fromRGBO(0, 0, 0, 0.05),
        ),
      ],
    ),
  );

  @override
  ThemeExtension<ThemeGradients> copyWith({
    LinearGradient? buttonLinearGradient,
    BoxDecoration? shadowDecoration,
  }) =>
      ThemeGradients(
        shadowDecoration: shadowDecoration ?? this.shadowDecoration,
        buttonLinearGradient: buttonLinearGradient ?? this.buttonLinearGradient,
      );

  @override
  ThemeExtension<ThemeGradients> lerp(
    ThemeExtension<ThemeGradients>? other,
    double t,
  ) {
    if (other is! ThemeGradients) {
      return this;
    }
    return ThemeGradients(
      shadowDecoration: BoxDecoration.lerp(
        shadowDecoration,
        other.shadowDecoration,
        t,
      )!,
      buttonLinearGradient: LinearGradient.lerp(
        buttonLinearGradient,
        other.buttonLinearGradient,
        t,
      )!,
    );
  }
}

extension BuildContextZ on BuildContext {
  ThemeGradients get gradients => Theme.of(this).extension<ThemeGradients>()!;
}
