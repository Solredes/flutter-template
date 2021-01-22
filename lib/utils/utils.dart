import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../src/ui/fragments/error_message.dart';

class Utils {
  static String encryptPassword(String password) {
    if (password != '') {
      var bytes = utf8.encode(password);
      var digest = sha1.convert(bytes);
      return digest.toString();
    } else {
      return '';
    }
  }

  /// Codify the [image] to base64
  ///
  /// [image] is the image to be encoded
  /// Returns a [String] with the encoded image
  static String encodeBase64(File image) {
    if (image != null) {
      var imageBytes = image.readAsBytesSync();
      return base64Encode(imageBytes);
    } else {
      return '';
    }
  }

  /// Decode the base64 image to [Uint8List]
  ///
  /// [imageBytes] is the image encoded in [bytes]
  static Uint8List decodeBase64(String imageBytes) {
    if (imageBytes == null) {
      return null;
    } else {
      if (imageBytes != '') {
        return base64Decode(imageBytes);
      } else {
        return null;
      }
    }
  }

  /// Convert a string into md5
  ///
  /// [data] the data String
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// Return a color convert from [String] hexadecimal to [Color]
  ///
  /// [hex] is the hexadecimal string color
  static Color colorFromHex(String hex) {
    hex = hex.toUpperCase().replaceAll("#", "");

    if (hex.length == 6) {
      hex = "FF" + hex;
    }

    return Color(int.parse(hex, radix: 16));
  }

  /// UnFocus the text field
  static void unFocus(BuildContext context) =>
      FocusScope.of(context).requestFocus(new FocusNode());

  /// Verify if data is null or empty
  ///
  /// [value] is the value to verify
  static bool notNullOrEmpty(dynamic value) {
    return value != null &&
        value.toString().trim().isNotEmpty &&
        !value.toString().toUpperCase().trim().contains("NULL");
  }

  /// Convert [String] time to [TimeOfDay] and return this
  ///
  /// [time] the time on String
  static TimeOfDay stringToTimeOfDay(String time) {
    List<String> data = time.split(' ');
    if (data.length == 2 && data[1] == 'PM') {
      return TimeOfDay.fromDateTime(DateFormat.jm().parse(time));
    } else {
      return TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(time));
    }
  }

  /// Calculate if color is light
  ///
  /// [color] the color to calculate
  static bool isLight(Color color) {
    return color.computeLuminance() >= 0.45;
  }

  /// Show a error toast
  static void showErrorToast(String message) =>
      showToast(message, background: Colors.red, color: Colors.white);

  /// Show a warning toast
  static void showWarningToast(String message) =>
      showToast(message, background: Colors.amber, color: Colors.white);

  /// Show a success toast
  static void showSuccessToast(String message) =>
      showToast(message, background: Colors.green, color: Colors.white);

  /// Shows a Toast
  ///
  /// [message] is the message to show
  /// [length] is the duration to show
  static void showToast(
    String message, {
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color background,
    Color color,
  }) =>
      Fluttertoast.showToast(
          msg: message,
          toastLength: length,
          gravity: gravity,
          backgroundColor: background,
          textColor: color,
          fontSize: 16.0);

  /// Show an Snackbar
  ///
  ///
  static void showSnackBar(
    BuildContext context,
    Widget content, {
    Color background,
    Duration duration,
  }) {
    SnackBar snackBar = SnackBar(
      content: content,
      backgroundColor: background,
      duration: duration = Duration(milliseconds: 4000),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  /// Displays a progress dialog box
  ///
  /// [context] is the context of the application
  /// The message to be displayed is set with [message]
  static void showProgressDialog(BuildContext context, {String message}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return AlertDialog(
            content: message != null
                ? Row(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(width: 20.0),
                      Text(message)
                    ],
                  )
                : Container(
                    width: 40.0,
                    height: 40.0,
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

  /// Displays a dialog box
  ///
  /// [context] is the context of the application
  /// The content to be displayed is set with [content]
  /// The title of dialog [title]
  static void showPopUpDialog(BuildContext context, Widget content,
      {String title}) {
    ThemeData themeData = Theme.of(context);

    showDialog(
        context: context,
        builder: (BuildContext c) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                title != null
                    ? AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Text(
                          title,
                          style: themeData.textTheme.headline6,
                        ),
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: themeData.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      )
                    : Container(),
                content
              ],
            ),
          );
        });
  }

  static void showFullScreenError(BuildContext context,
      {String icon, String message}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ErrorMessageDialog(
        icon: icon,
        message: message,
      ),
      fullscreenDialog: true,
    ));
  }
}
