import 'package:flutter/material.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class ErrorHandler {
  static String getMessage(BuildContext context, Failure failure) {
    if (failure is CacheFailure) {
      if (failure.message == 'unknown error') {
        return context.l10n.unknownError;
      }
      return failure.message;
    }
    
    return context.l10n.unexpectedError;
  }
}
