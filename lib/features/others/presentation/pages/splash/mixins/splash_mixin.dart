part of "../splash_page.dart";

mixin SplashMixin on State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1500), nextToNavigation);
  }

  void nextToNavigation() {
    if (localSource.hasLocale) {
      context.goNamed(Routes.home);
      return;
    }
    context.goNamed(Routes.chooseLanguage);
    return;
  }

  Future<void> appUpdateBottomSheet({
    required bool isForceUpdate,
  }) async {
    await customModalBottomSheet<bool>(
      context: context,
      enableDrag: false,
      builder: (_, ScrollController? controller) => AppUpdateBottomSheetWidget(
        isForceUpdate: isForceUpdate,
        onTap: () async {
          await launchUrl(
            Uri.parse(Constants.appLink),
            mode: LaunchMode.externalApplication,
          ).then(
            (bool value) async {
              if (!mounted) {
                return;
              }
              nextToNavigation();
            },
          );
        },
      ),
    );
  }
}
