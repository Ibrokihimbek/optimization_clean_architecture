part of "top_snack_bar.dart";

/// Popup widget that you can use by default to show some information
class CustomSnackBar extends StatefulWidget {
  const CustomSnackBar.success({
    super.key,
    required this.message,
    this.messagePadding = const EdgeInsets.all(16),
    this.textStyle = const TextStyle(
      fontSize: 15,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    this.maxLines = 2,
    this.backgroundColor = const Color(0xFF43A250),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaler = TextScaler.noScaling,
    this.textAlign = TextAlign.center,
    required this.title,
    this.titleTextStyle = const TextStyle(
      fontSize: 17,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  });

  const CustomSnackBar.info({
    super.key,
    required this.message,
    this.messagePadding = const EdgeInsets.all(16),
    this.textStyle = const TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    this.maxLines = 2,
    this.backgroundColor = const Color(0xff2196F3),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaler = TextScaler.noScaling,
    this.textAlign = TextAlign.center,
    required this.title,
    this.titleTextStyle = const TextStyle(
      fontFamily: "Montserrat",
      fontSize: 17,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  });

  const CustomSnackBar.error({
    super.key,
    required this.message,
    this.messagePadding = const EdgeInsets.all(16),
    this.maxLines = 3,
    this.backgroundColor = const Color(0xFFFF543E),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaler = TextScaler.noScaling,
    this.textAlign = TextAlign.start,
    required this.title,
    this.textStyle = const TextStyle(
      fontFamily: "Montserrat",
      fontSize: 15,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    this.titleTextStyle = const TextStyle(
      fontFamily: "Montserrat",
      fontSize: 17,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  });

  final String title;
  final TextStyle titleTextStyle;
  final String message;
  final Color backgroundColor;
  final TextStyle textStyle;
  final int maxLines;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry messagePadding;
  final TextScaler textScaler;
  final TextAlign textAlign;

  @override
  CustomSnackBarState createState() => CustomSnackBarState();
}

class CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
      ),
      padding: widget.messagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.title,
            style: widget.titleTextStyle.merge(theme.textTheme.bodyLarge).copyWith(
              color: Colors.white,
            ),
            textAlign: widget.textAlign,
            overflow: TextOverflow.ellipsis,
            maxLines: widget.maxLines,
            textScaler: widget.textScaler,
          ),
          AppUtils.kGap4,
          Text(
            widget.message,
            style: theme.textTheme.bodyMedium?.merge(widget.textStyle),
            textAlign: widget.textAlign,
            overflow: TextOverflow.ellipsis,
            maxLines: widget.maxLines,
            textScaler: widget.textScaler,
          ),
        ],
      ),
    );
  }
}

const List<BoxShadow> kDefaultBoxShadow = <BoxShadow>[
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 8),
    spreadRadius: 1,
    blurRadius: 30,
  ),
];

const BorderRadius kDefaultBorderRadius = BorderRadius.all(Radius.circular(16));
