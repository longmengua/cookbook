import 'package:flutter/material.dart';

class SnackBarBuilder {
  SnackBarBuilder.showError(BuildContext context, String errorMessage) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(errorMessage ?? '')),
              Icon(Icons.error),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }

  SnackBarBuilder.showLoading(BuildContext context, String message,
      [num time]) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: time ?? 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(message ?? ' '),
              CircularProgressIndicator(),
            ],
          ),
          backgroundColor: Colors.grey[800],
        ),
      );
  }

  SnackBarBuilder.showSuccess(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(message ?? ' '),
              Icon(Icons.done, color: Colors.lightGreen),
            ],
          ),
          backgroundColor: Colors.grey[800],
        ),
      );
  }

  SnackBarBuilder.hide(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }
}
