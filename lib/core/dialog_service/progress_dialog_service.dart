import 'dart:async';

import 'package:flutter/material.dart';

sealed class ProgressDialogService {
  void showLoadingDialog(final BuildContext context);

  void hideLoadingDialog(final BuildContext context);
}

class ProgressDialogServiceImpl extends ProgressDialogService {
  bool _isDialogShowing = false;
  Completer<void>? _dialogCompleter;

  @override
  Future<void> showLoadingDialog(final BuildContext context) async {
    if (_isDialogShowing) {
      return;
    }

    _isDialogShowing = true;
    _dialogCompleter = Completer<void>();

    try {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            height: 60,
            width: 60,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
      _dialogCompleter?.complete();
    } catch (e) {
      _dialogCompleter?.completeError(e);
    } finally {
      _isDialogShowing = false;
    }
  }

  @override
  void hideLoadingDialog(final BuildContext context) {
    if (_isDialogShowing && _dialogCompleter?.isCompleted == false) {
      Navigator.pop(context);
      _dialogCompleter?.complete();
      _dialogCompleter = null;
      _isDialogShowing = false;
    }
  }
}
