part of "extension.dart";

extension ParseString on DateTime {
  String get formatDate => DateFormat("dd.MM.yyyy").format(this);

  String get formatDateTime =>
      DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(this);

  String get toDate => DateFormat("yyyy-MM-dd").format(this);

  String get toDateTime => DateFormat("yyyy-MM-dd HH:mm").format(this);

  String get toFutureDate => DateFormat("dd.MM.yyyy").format(this);

  String get toFutureTime => DateFormat("HH:mm").format(this);

  String get toFutureDateTime => DateFormat("dd MMMM HH:mm").format(this);

  String timeZone() {
    String date = toIso8601String().split(".")[0];
    if (timeZoneOffset.isNegative) {
      date += "-";
    } else {
      date += "+";
    }
    final List<String> timeZoneSplit = timeZoneOffset.toString().split(":");

    final int hour = int.parse(timeZoneSplit[0]);
    if (hour < 10) {
      date += "0${timeZoneSplit[0]}";
    }
    return date += ":${timeZoneSplit[1]}";
  }
}

extension ParseExtension on String {
  String get parseDate =>
      DateFormat("MMMM dd, yyyy", localSource.locale).format(
        DateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z (z)").tryParse(this) ??
            DateTime.now(),
      );

  String get parseDateOfBirth => isEmpty
      ? ""
      : DateFormat("dd.MM.yyyy", localSource.locale).format(
          DateFormat("yyyy-MM-dd").parse(this),
        );

  String Function() get date => () {
        if (isEmpty) {
          return "";
        }
        final int duration = DateTime.now().hour - DateTime.now().toUtc().hour;
        final DateTime date = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(this);
        return DateFormat("dd.MM.yyyy").format(
          date.add(Duration(hours: duration)),
        );
      };

  String get notificationDate {
    if (isEmpty) {
      return "";
    }
    final int duration = DateTime.now().hour - DateTime.now().toUtc().hour;
    final DateTime date = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(this);
    return DateFormat("dd MMMM yyyy", localSource.locale).format(
      date.add(Duration(hours: duration)),
    );
  }

  String Function() get dateTime => () {
        if (isEmpty) {
          return "";
        }
        final int duration = DateTime.now().hour - DateTime.now().toUtc().hour;
        final DateTime date = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(this);
        return DateFormat("dd.MM.yyyy HH:mm").format(
          date.add(Duration(hours: duration)),
        );
      };

  String orderDateTime({bool isOrderDetail = false}) {
    if (isEmpty) {
      return "";
    }
    final int duration = DateTime.now().hour - DateTime.now().toUtc().hour;
    final DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this);
    return DateFormat(
      isOrderDetail ? "dd.MM.yyyy - HH:mm" : "dd.MM.yyyy | HH:mm",
    ).format(
      date.add(Duration(hours: duration)),
    );
  }

  String reviewDate() {
    if (isEmpty) {
      return "";
    }
    final DateTime dateTime =
        DateFormat("EEE MMM dd yyyy HH:mm:ss").parse(this, true).toLocal();
    final DateFormat formatter = DateFormat("d MMMM, yyyy'y'");
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  String dateTime2() {
    if (isEmpty) {
      return "";
    }
    final int duration = DateTime.now().hour - DateTime.now().toUtc().hour;
    final DateTime date = DateFormat("MM.dd.yyyy").parse(this);
    return DateFormat("yyyy-MM-dd").format(
      date.add(Duration(hours: duration)),
    );
  }

  String time1() {
    if (isEmpty) {
      return "";
    }
    final int duration = DateTime.now().hour - DateTime.now().toUtc().hour;
    final DateTime date = DateFormat("HH:mm").parse(this);
    return DateFormat("HH:mm").format(
      date.add(Duration(hours: duration)),
    );
  }

  String time() {
    if (isEmpty) {
      return "";
    }
    final int duration = DateTime.now().hour - DateTime.now().toUtc().hour;
    final DateTime date = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(this);
    return DateFormat("HH:mm").format(
      date.add(Duration(hours: duration)),
    );
  }

  DateTime? get toDateTime => DateFormat("dd.MM.yyyy").tryParse(this);

  String get htmlToText => Bidi.stripHtmlIfNeeded(this);
}

extension DurationX on Duration {
  String get toDuration {
    final String hours = inHours.toString().padLeft(2, "0");
    final String minutes = inMinutes.remainder(60).toString().padLeft(2, "0");
    final String seconds = inSeconds.remainder(60).toString().padLeft(2, "0");
    if (hours == "00") {
      return "$minutes:$seconds";
    }
    return "$hours:$minutes:$seconds";
  }
}
