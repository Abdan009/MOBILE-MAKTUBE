part of 'shared.dart';

void flushbar(String message, BuildContext context,
    {FlushbarPosition position, Color backgroundColor}) {
  Flushbar(
    duration: Duration(seconds: 3),
    flushbarPosition: position ?? FlushbarPosition.TOP,
    backgroundColor: backgroundColor ?? Color(0xFFFF5C83),
    message: message,
  )..show(context);
}

Widget loading(double sized) {
  return CircularProgressIndicator(
    strokeWidth: sized,
    backgroundColor: mainColor,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
  );
}
