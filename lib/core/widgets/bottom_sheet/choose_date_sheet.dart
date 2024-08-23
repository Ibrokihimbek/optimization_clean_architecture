import "package:flutter/cupertino.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";

class ChooseDateSheet extends StatelessWidget {
  const ChooseDateSheet({
    super.key,
    this.dateTime,
    this.minimumDate,
    this.onDateTimeChanged,
  });

  final DateTime? dateTime;
  final DateTime? minimumDate;
  final ValueChanged<DateTime>? onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    DateTime date = dateTime ?? minimumDate ?? DateTime.now();
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
            maximumDate: DateTime.now().add(const Duration(days: 14)),
            minimumDate: (minimumDate ?? DateTime.now())
                .subtract(const Duration(minutes: 1)),
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
          onDateTimeChanged?.call(date);
          Navigator.pop(context);
        },
      ),
    );
  }
}
