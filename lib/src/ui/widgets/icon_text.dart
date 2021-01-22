import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  IconText({
    Key key,
    this.active = false,
    @required this.text,
    @required this.icon,
    this.onPressed,
  })  : assert(text != null),
        assert(icon != null),
        super(key: key);

  final bool active;
  final Widget text;
  final Widget icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: icon,
            ),
            SizedBox(height: 5.0),
            Align(
              alignment: Alignment.bottomCenter,
              child: text,
            ),
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
