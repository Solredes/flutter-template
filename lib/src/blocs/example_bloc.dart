import 'package:rxdart/rxdart.dart';

import '../models/example_model.dart';
import '../resources/repository.dart';

class ExamplesBloc {
  final _repository = Repository();
  final _examplesFetcher = PublishSubject<List<ExampleModel>>();

  Stream<List<ExampleModel>> get allExamples => _examplesFetcher.stream;

  fetchAllExamples() async {
    List<ExampleModel> examplesModel = await _repository.fetchAllExamples();
    _examplesFetcher.sink.add(examplesModel);
  }

  dispose() {
    _examplesFetcher.close();
  }
}

final bloc = ExamplesBloc();
