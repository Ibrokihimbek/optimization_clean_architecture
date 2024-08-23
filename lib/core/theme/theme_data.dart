part of "themes.dart";

const SystemUiOverlayStyle systemDarkUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Color.fromRGBO(28, 30, 33, 0.95),
  // ios
  statusBarBrightness: Brightness.dark,
  // android
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.light,
);

const SystemUiOverlayStyle systemLightUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Colors.white,
  // ios
  statusBarBrightness: Brightness.light,
  // android
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Montserrat",
  applyElevationOverlayColor: true,
  extensions: const <ThemeExtension<dynamic>>[
    ThemeColors.light,
    ThemeGradients.light,
    ThemeTextStyles.light,
    ThemeCustomShapes.light,
  ],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  splashFactory:
      Platform.isAndroid ? InkRipple.splashFactory : NoSplash.splashFactory,
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  primaryColor: colorLightScheme.primary,
  colorScheme: colorLightScheme,
  dialogBackgroundColor: colorLightScheme.surface,
  scaffoldBackgroundColor: ThemeColors.light.background,
  cardColor: colorLightScheme.surface,
  canvasColor: colorLightScheme.surface,
  shadowColor: const Color(0xFF343434),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorLightScheme.onPrimary;
        }
        return ThemeColors.light.secondaryText;
      },
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorLightScheme.primary;
        }
        return ThemeColors.light.background;
      },
    ),
    trackOutlineColor: WidgetStateProperty.resolveWith(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorLightScheme.primary;
        }
        return ThemeColors.light.background;
      },
    ),
  ),
  cardTheme: CardTheme(
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    color: ThemeColors.light.background,
  ),
  scrollbarTheme: const ScrollbarThemeData(
    radius: AppUtils.kRadius12,
    interactive: true,
    thickness: WidgetStatePropertyAll<double>(4),
    thumbVisibility: WidgetStatePropertyAll<bool>(false),
    trackVisibility: WidgetStatePropertyAll<bool>(false),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: colorLightScheme.primary,
    linearMinHeight: 3,
    linearTrackColor: Colors.white,
    circularTrackColor: Colors.white,
  ),
  dividerColor: const Color(0xFFEAECF0),
  dividerTheme: const DividerThemeData(
    thickness: 1,
    color: Color(0xFFEAECF0),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: colorLightScheme.surface,
    surfaceTintColor: colorLightScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    elevation: 1,
    color: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Color(0xFFE6E9EF),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    side: BorderSide(color: colorLightScheme.outline),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF32B141),
    foregroundColor: Colors.white,
    elevation: 0,
    focusElevation: 0,
    hoverElevation: 0,
    highlightElevation: 0,
    shape: CircleBorder(),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return ThemeColors.light.secondaryText;
          }
          return colorLightScheme.onPrimary;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return ThemeColors.light.background;
          }
          return colorLightScheme.primary;
        },
      ),
      textStyle: WidgetStatePropertyAll<TextStyle>(
        ThemeTextStyles.light.buttonStyle,
      ),
      elevation: const WidgetStatePropertyAll<double>(0),
      shape: const WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
      fixedSize: const WidgetStatePropertyAll<Size>(Size.fromHeight(52)),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 12),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => colorLightScheme.primary,
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => colorLightScheme.onPrimary,
      ),
      side: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => BorderSide(
          color: colorLightScheme.primary,
        ),
      ),
      textStyle: WidgetStatePropertyAll<TextStyle>(
        ThemeTextStyles.light.buttonStyle,
      ),
      elevation: const WidgetStatePropertyAll<double>(0),
      shape: const WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
      fixedSize: const WidgetStatePropertyAll<Size>(Size.fromHeight(52)),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 12),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => colorLightScheme.onSurface,
      ),
      backgroundColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
      textStyle: WidgetStatePropertyAll<TextStyle>(
        ThemeTextStyles.light.buttonStyle,
      ),
      elevation: const WidgetStatePropertyAll<double>(0),
      shape: const WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
      fixedSize: const WidgetStatePropertyAll<Size>(Size.fromHeight(52)),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    border: const OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: Color(0xFFD0D5DD)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: Color(0xFFD0D5DD)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: colorLightScheme.primary),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: colorLightScheme.error),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: Color(0xFFEEF0F2)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: colorLightScheme.error),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    elevation: 0,
    showDragHandle: true,
    dragHandleColor: Color(0xFFE7E5F0),
    dragHandleSize: Size(48, 4),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: colorLightScheme.surface,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    selectedLabelStyle: const TextStyle(
      fontSize: 11,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 11,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
    ),
    unselectedItemColor: const Color(0xFF667085),
    selectedItemColor: colorLightScheme.primary,
    selectedIconTheme: IconThemeData(color: colorLightScheme.primary),
  ),
  tabBarTheme: TabBarTheme(
    tabAlignment: TabAlignment.fill,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: colorLightScheme.primary,
    labelColor: ThemeColors.light.primaryText,
    unselectedLabelColor: const Color(0xFF98A2B3),
    dividerColor: Colors.transparent,
    overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
    labelStyle: const TextStyle(
      fontSize: 15,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 15,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
    ),
    indicator: BoxDecoration(
      color: colorLightScheme.surface,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          blurRadius: 5,
          color: Colors.black.withOpacity(0.07),
        ),
      ],
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    height: kToolbarHeight,
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (Set<WidgetState> states) => const IconThemeData(
        color: Colors.black,
      ),
    ),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (Set<WidgetState> states) => ThemeTextStyles.light.appBarTitle,
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    systemOverlayStyle: systemLightUiOverlayStyle,
    iconTheme: const IconThemeData(color: Colors.black),
    shadowColor: Colors.black45,
    titleTextStyle: const TextStyle(
      fontSize: 17,
      height: 22 / 17,
      color: Colors.black,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
    ),
    toolbarTextStyle: ThemeTextStyles.light.appBarTitle,
    backgroundColor: colorLightScheme.surface,
    surfaceTintColor: colorLightScheme.surface,
  ),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (BuildContext context) => IconButton(
      onPressed: () => Navigator.maybePop(context),
      icon: Platform.isAndroid
          ? const Icon(Icons.arrow_back_rounded)
          : const Icon(Icons.arrow_back_ios_new_rounded),
    ),
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 14,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),
    subtitleTextStyle: TextStyle(
      fontSize: 14,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.secondaryText,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),

    /// text field title style
    titleMedium: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),
    titleSmall: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),

    /// list tile title style
    bodyLarge: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: ThemeColors.light.primaryText,
    ),

    /// list tile subtitle style
    bodyMedium: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: ThemeColors.light.primaryText,
    ),
    bodySmall: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: ThemeColors.light.primaryText,
    ),

    /// display text style
    displayLarge: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: ThemeColors.light.primaryText,
    ),
    displayMedium: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),
    displaySmall: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),

    /// headline text style
    headlineLarge: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: ThemeColors.light.primaryText,
    ),
    headlineMedium: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),
    headlineSmall: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),
  ),
  primaryTextTheme: TextTheme(
    titleLarge: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),

    /// text field title style
    titleMedium: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),
    titleSmall: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),

    /// list tile title style
    bodyLarge: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: ThemeColors.light.primaryText,
    ),

    /// list tile subtitle style
    bodyMedium: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: ThemeColors.light.primaryText,
    ),
    bodySmall: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: ThemeColors.light.primaryText,
    ),

    /// display text style
    displayLarge: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: ThemeColors.light.primaryText,
    ),

    /// display text style
    displayMedium: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ThemeColors.light.primaryText,
    ),
    displaySmall: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),

    /// headline text style
    headlineLarge: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: ThemeColors.light.primaryText,
    ),

    /// headline text style
    headlineMedium: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),
    headlineSmall: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: ThemeColors.light.primaryText,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Montserrat",
  applyElevationOverlayColor: true,
  extensions: const <ThemeExtension<dynamic>>[
    ThemeColors.dark,
    ThemeGradients.dark,
    ThemeTextStyles.dark,
    ThemeCustomShapes.dark,
  ],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  splashFactory:
      Platform.isAndroid ? InkRipple.splashFactory : NoSplash.splashFactory,
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  primaryColor: colorDarkScheme.primary,
  colorScheme: colorDarkScheme,
  dialogBackgroundColor: colorDarkScheme.surface,
  scaffoldBackgroundColor: ThemeColors.dark.background,
  cardColor: colorDarkScheme.surface,
  canvasColor: colorDarkScheme.surface,
  shadowColor: const Color(0xFF343434),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
    linearMinHeight: 2,
    linearTrackColor: Colors.transparent,
    circularTrackColor: Colors.transparent,
  ),
  dividerTheme: const DividerThemeData(
    thickness: 1,
    color: Color.fromRGBO(126, 95, 166, 0.07),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: colorDarkScheme.surface,
    surfaceTintColor: colorDarkScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
    ),
  ),
  scrollbarTheme: ScrollbarThemeData(
    interactive: true,
    thumbColor: WidgetStatePropertyAll<Color>(
      ThemeColors.light.main,
    ),
    thickness: const WidgetStatePropertyAll<double>(5),
    minThumbLength: 100,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    elevation: 1,
    color: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Color(0xFFE6E9EF),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF32B141),
    foregroundColor: Colors.white,
    elevation: 0,
    focusElevation: 0,
    hoverElevation: 0,
    highlightElevation: 0,
    shape: CircleBorder(),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => Colors.white,
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return colorDarkScheme.primary.withOpacity(0.4);
          }
          return colorDarkScheme.primary;
        },
      ),
      textStyle:
          WidgetStatePropertyAll<TextStyle>(ThemeTextStyles.dark.buttonStyle),
      elevation: const WidgetStatePropertyAll<double>(0),
      shape: const WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      fixedSize: const WidgetStatePropertyAll<Size>(Size.fromHeight(48)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => Colors.black,
      ),
      textStyle: WidgetStatePropertyAll<TextStyle>(
        ThemeTextStyles.dark.buttonStyle,
      ),
      elevation: const WidgetStatePropertyAll<double>(0),
      shape: const WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      fixedSize: const WidgetStatePropertyAll<Size>(Size.fromHeight(48)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    border: const OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: Color(0xFFEEF0F2)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: Color(0xFFEEF0F2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: colorDarkScheme.primary),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: colorDarkScheme.error),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: Color(0xFFEEF0F2)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppUtils.kBorderRadius8,
      borderSide: BorderSide(color: colorDarkScheme.error),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    elevation: 0,
    showDragHandle: true,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: const Color.fromRGBO(28, 30, 33, 0.95),
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    selectedLabelStyle: const TextStyle(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 12,
      color: Color(0xFF909090),
      fontWeight: FontWeight.w500,
    ),
    unselectedItemColor: const Color(0xFF909090),
    selectedItemColor: colorDarkScheme.onPrimary,
    selectedIconTheme: IconThemeData(color: colorDarkScheme.primary),
  ),
  tabBarTheme: TabBarTheme(
    indicatorColor: colorDarkScheme.primary,
    labelColor: Colors.white,
    dividerHeight: 0,
    unselectedLabelColor: const Color(0xFFBFBFBF),
    tabAlignment: TabAlignment.start,
    labelPadding: AppUtils.kPaddingHor6,
    dividerColor: Colors.transparent,
    overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
    labelStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    indicator: TabBarIndicator(
      color: colorDarkScheme.primary,
      radius: 3,
    ),
    indicatorSize: TabBarIndicatorSize.label,
  ),
  navigationBarTheme: NavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    height: kToolbarHeight,
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (Set<WidgetState> states) => const IconThemeData(
        color: Colors.black,
      ),
    ),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (Set<WidgetState> states) => ThemeTextStyles.dark.appBarTitle,
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: systemDarkUiOverlayStyle,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
      fontSize: 15,
      height: 20 / 15,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    shape: ThemeCustomShapes.dark.bottomRectangleBorder,
    toolbarTextStyle: ThemeTextStyles.dark.appBarTitle,
    backgroundColor: const Color.fromRGBO(28, 30, 33, 0.95),
    surfaceTintColor: const Color.fromRGBO(28, 30, 33, 0.95),
  ),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (BuildContext context) => IconButton(
      onPressed: () => Navigator.maybePop(context),
      icon: Platform.isAndroid
          ? const Icon(Icons.arrow_back)
          : const Icon(Icons.arrow_back_ios_new_rounded),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    minVerticalPadding: 0,
    horizontalTitleGap: 10,
    contentPadding: AppUtils.kPaddingHor10,
    tileColor: Color(0xFF27292C),
    style: ListTileStyle.list,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    titleTextStyle: TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 34,
    ),

    /// text field title style
    titleMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),

    /// list tile title style
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

    /// list tile subtitle style
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
    displayLarge: TextStyle(
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
    ),
  ),
);
