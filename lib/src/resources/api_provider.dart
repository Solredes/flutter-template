import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_template/src/models/example_det_model.dart';
import 'package:http/http.dart' show Response;
import 'package:http/io_client.dart';

import '../../config.dart';
import '../models/example_model.dart';

/// Class to access to WS
///
/// @author Alex Torres <alextorressk@gmail.com>
class ApiProvider {
  IOClient client = IOClient(
      new HttpClient()..badCertificateCallback = ((_, __, ___) => true));
  final String _baseUrl = "${Config().apiUrl}/rest-api/api";

  /// List of items
  Future<List<ExampleModel>> fetchExampleList() async {
    try {
      Response response = await client.post(
        Uri.parse("$_baseUrl/api/example"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<Map<String, dynamic>> parsedJson =
            jsonDecode(utf8.decode(response.bodyBytes));

        return parsedJson.map((b) => ExampleModel.fromJson(b)).toList();
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load example');
      }
    } on Exception catch (_) {
      print(_.toString());
      return null;
    } finally {
      client.close();
    }
  }

  /// Unique item
  Future<ExampleDetModel> fetchExampleDet(int id) async {
    try {
      Response response = await client.get(
        Uri.parse("$_baseUrl/api/example-det?id=$id"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        Map<String, dynamic> parsedJson =
            jsonDecode(utf8.decode(response.bodyBytes));

        return ExampleDetModel.fromJson(parsedJson);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load example details');
      }
    } on Exception catch (_) {
      print(_.toString());
      return null;
    } finally {
      client.close();
    }
  }
}
