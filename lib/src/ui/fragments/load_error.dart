import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadError extends StatelessWidget {
  LoadError({
    Key key,
    @required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Center(
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: MediaQuery.of(context).orientation == Orientation.landscape
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 50),
                    child: Image(
                      image: AssetImage("assets/images/logo_white.png"),
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 40),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          localizations.loadError,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      RaisedButton.icon(
                        icon: Icon(Icons.refresh),
                        label: Text(localizations.retry),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        onPressed: onPressed,
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/logo_white.png"),
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 50,
                      right: 50,
                      top: 50,
                      bottom: 50,
                    ),
                    child: Text(
                      localizations.loadError,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RaisedButton.icon(
                    icon: Icon(Icons.refresh),
                    label: Text(localizations.retry),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: onPressed,
                  ),
                ],
              ),
      ),
    );
  }
}
