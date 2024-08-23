import "dart:async";

import "package:flutter/material.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";

class TimerTextButton extends StatefulWidget {
  const TimerTextButton({
    super.key,
    this.duration = const Duration(minutes: 1),
    this.onPressed,
  });

  final Duration duration;
  final void Function()? onPressed;

  @override
  State<TimerTextButton> createState() => _TimerTextButtonState();
}

class _TimerTextButtonState extends State<TimerTextButton> {
  Timer? timer;
  late ValueNotifier<Duration> notifier = ValueNotifier<Duration>(
    widget.duration,
  );

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (notifier.value.inSeconds != 0) {
          notifier.value = Duration(seconds: notifier.value.inSeconds - 1);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<Duration>(
        valueListenable: notifier,
        builder: (_, Duration duration, __) => TextButton(
          key: const Key("timer_text_button"),
          onPressed: () {
            if (duration.inSeconds == 0) {
              widget.onPressed?.call();
              notifier.value = widget.duration;
              setState(() {});
            }
          },
          child: Text("${context.tr("resend_new_code")} ${duration.toDuration}"),
        ),
      );

  @override
  void dispose() {
    notifier.dispose();
    timer?.cancel();
    timer = null;
    super.dispose();
  }
}
