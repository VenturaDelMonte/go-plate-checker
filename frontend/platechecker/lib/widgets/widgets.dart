import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';


class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.tag_faces,
              size: 150,
            ),
            SizedBox(height: 10),
            Text(
              'Success',
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 45),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Notifications {
  Notifications._();

  static void showSnackBarWithError(BuildContext context, String message,
      {Key key}) {
    Flushbar(
      messageText: Text(
        message ?? 'Sorry, an error has ocurred',
        style: TextStyle(color: Colors.black87),
      ),
      backgroundColor: Colors.red[200],
      duration: Duration(seconds: 2),
    ).show(context);
  }

  static void showSnackBarWithSuccess(BuildContext context, String message,
      {Key key}) {
    Flushbar(
      messageText: Text(
        message ?? 'Success.',
        style: TextStyle(color: Colors.black87),
      ),
      backgroundColor: Colors.green[300],
      duration: Duration(seconds: 2),
    ).show(context);
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(key: key),
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}


class LiquidLinearProgressIndicatorWithText extends ImplicitlyAnimatedWidget {
  final double percent;

  LiquidLinearProgressIndicatorWithText({
    Key key,
    @required this.percent,
    @required Duration duration,
    Curve curve = Curves.linear,
  }) : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _LiquidLinearProgressIndicatorWithTextState();
}

class _LiquidLinearProgressIndicatorWithTextState
    extends AnimatedWidgetBaseState<LiquidLinearProgressIndicatorWithText> {
  Tween _tween;

  @override
  Widget build(BuildContext context) {
    return LiquidLinearProgressIndicator(
      value: _tween.evaluate(animation),
      valueColor: AlwaysStoppedAnimation(Colors.blue[300]),
      backgroundColor: Colors.white,
      borderColor: Colors.blue[100],
      borderWidth: 0,
      borderRadius: 0,
      center: Text(
        '${(_tween.evaluate(animation) * 100).ceil().toString()}%',
        style: TextStyle(color: Colors.black87, fontSize: 16),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _tween = visitor(_tween, (widget.percent), (value) => Tween(begin: value));
  }
}

class FormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsetsGeometry padding;
  const FormButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RaisedButton(
        onPressed: onPressed,
        child: Center(child: Text(text)),
      ),
    );
  }
}