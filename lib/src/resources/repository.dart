import 'dart:async';

import '../models/example_model.dart';
import '../models/example_det_model.dart';
import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<List<ExampleModel>> fetchAllExamples() =>
      apiProvider.fetchExampleList();

  Future<ExampleDetModel> fetchExampleDet(int id) =>
      apiProvider.fetchExampleDet(id);
}
