import "dart:async";
import "dart:io";
import "dart:math" as math;

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:intl/intl.dart";
import "package:currency_clean_architecture/app_options.dart";
import "package:currency_clean_architecture/core/l10n/app_localizations_setup.dart";
import "package:currency_clean_architecture/core/theme/themes.dart";
import "package:currency_clean_architecture/injector_container.dart";
import "package:currency_clean_architecture/router/app_routes.dart";

part "box_extensions.dart";

part "build_context_extension.dart";

part "date_parse_extension.dart";

part "money_format_extension.dart";

part "size_extension.dart";

part "sliver_count_extension.dart";

part "version_extension.dart";

part "utils_extension.dart";
