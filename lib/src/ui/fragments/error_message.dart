import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorMessageDialog extends StatelessWidget {
  ErrorMessageDialog({
    Key key,
    this.icon,
    this.message,
  });

  final String icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: theme.accentColor.withAlpha(100),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            tooltip: localizations.close,
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 60.0),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Image(
                    image: AssetImage(icon ?? "assets/images/error_image.png"),
                    fit: BoxFit.cover,
                    width: 180,
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: localizations.loadErrorTitle,
                  style: theme.textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                        text: localizations.loadErrorText,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
