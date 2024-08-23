import "package:flutter/cupertino.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";

class DateOfBirthSheet extends StatelessWidget {
  const DateOfBirthSheet({super.key, this.dateTime});

  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    DateTime date =
        dateTime ?? DateTime.now().subtract(const Duration(days: 365 * 18));
    return CupertinoActionSheet(
      actions: <Widget>[
        SizedBox(
          height: 240,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime d) {
              date = d;
            },
            initialDateTime: date,
            maximumYear: DateTime.now().year - 16,
            minimumYear: DateTime.now().year - 100,
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          context.tr("choose"),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.tertiary,
          ),
        ),
        onPressed: () {
          Navigator.pop(context, date);
        },
      ),
    );
  }
}

Future<T?> customCupertinoModalPopup<T>(
  BuildContext context, {
  DateTime? dateTime,
}) async =>
    showCupertinoModalPopup(
      context: context,
      builder: (_) => DateOfBirthSheet(dateTime: dateTime),
    );
