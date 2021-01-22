import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/example_model.dart';
import '../models/example_det_model.dart';
import '../resources/repository.dart';

class MovieDetailBloc {
  final _repository = Repository();
  final _itemId = PublishSubject<int>();
  final _items = BehaviorSubject<Future<ExampleModel>>();

  Function(int) get fetchTrailersById => _itemId.sink.add;
  Stream<Future<ExampleModel>> get movieTrailers => _items.stream;

  MovieDetailBloc() {
    _itemId.stream.transform(_itemTransformer()).pipe(_items);
  }

  dispose() async {
    _itemId.close();
    await _items.drain();
    _items.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Future<ExampleDetModel> item, int id, int index) {
        print(index);
        item = _repository.fetchExampleDet(id);
        return item;
      },
    );
  }
}
