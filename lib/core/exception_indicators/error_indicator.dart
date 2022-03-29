import 'package:flutter/material.dart';
import 'package:flutter_base/core/exception_indicators/something_went_wrong.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';

import '../error/exceptions.dart';
import 'empty_list_indicator.dart';
import 'exception_indicator.dart';
import 'generic_error_indicator.dart';
import 'no_connection_indicator.dart';

/// Based on the received error, displays either a [NoConnectionIndicator] or
/// a [GenericErrorIndicator].
class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    required this.error,
    this.onTryAgain,
    Key? key,
  })  : assert(error != null),
        super(key: key);

  final dynamic error;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    print(error is NetworkConnectionException);
    print(error);
    if (error is NetworkConnectionException) {
      return NoConnectionIndicator(
        onTryAgain: onTryAgain,
      );
    } else if (error is EmptyListException) {
      return ExceptionIndicator(
        onTryAgain: onTryAgain,
        //assetName: AppIcons.emptyIcon,
        title: 'no data found',
      );
    } else {
      return GenericErrorIndicator(
        onTryAgain: onTryAgain,
      );
    }
  }
}
