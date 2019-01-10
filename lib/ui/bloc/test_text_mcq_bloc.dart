import 'dart:async';

import 'package:flutter_bloc_base_arch/api/mock_api_data.dart';
import 'package:flutter_bloc_base_arch/base_bloc/base_bloc_provider.dart';
import 'package:flutter_bloc_base_arch/model/test_answer_response_model.dart';
import 'package:rxdart/rxdart.dart';

class TestTextMcqBloc implements BlocBase{

  TestAnswerResponseModel testAnswerResponseModel;

  List<TextMcqTestCardModel> testList;

  int currentQuestionIndex;

  final _optionClickedBehaviorSubject = BehaviorSubject<TestAnswerResponseModel>();
  // retrieve data from click stream
  Stream<TestAnswerResponseModel> get optionClickedStream    => _optionClickedBehaviorSubject.stream;
  // add data to click stream
  Sink<TestAnswerResponseModel> get optionClickedSink => _optionClickedBehaviorSubject.sink;

  final _fetchTestBehaviorSubject = BehaviorSubject<String>();
  // retrieve levelId stream
  Stream<String> get fetchTestStream    => _fetchTestBehaviorSubject.stream;
  // add levelId to stream
  Sink<String> get fetchTestSink => _fetchTestBehaviorSubject.sink;

  final _broadcastTestListBehaviorSubject = BehaviorSubject<List<TextMcqTestCardModel>>();
  // retrieve list from stream
  Stream<List<TextMcqTestCardModel>> get broadcastTestListStream    => _broadcastTestListBehaviorSubject.stream;
  // add list to stream
  Sink<List<TextMcqTestCardModel>> get broadcastTestListSink => _broadcastTestListBehaviorSubject.sink;

  final _errorBehaviorSubject = BehaviorSubject<bool>();
  // retrieve error from stream
  Stream<bool> get errorStream    => _errorBehaviorSubject.stream;
  // add error to stream
  Sink<bool> get errorSink => _errorBehaviorSubject.sink;

  final _progressBehaviorSubject = BehaviorSubject<bool>();
  // retrieve progress stream
  Stream<bool> get progressStream    => _progressBehaviorSubject.stream;
  // add progress stream
  Sink<bool> get progressSink => _progressBehaviorSubject.sink;

  final _navigateToNextPageBehaviorSubject = BehaviorSubject<int>();
  // retrieve progress stream
  Stream<int> get navigateStream    => _navigateToNextPageBehaviorSubject.stream;
  // add progress stream
  Sink<int> get navigateSink => _navigateToNextPageBehaviorSubject.sink;


  TestTextMcqBloc() {
    fetchTestStream.listen(_fetchList);
    progressSink.add(true);
  }

  Future _fetchList(String levelId) async{
    api.getUser().then((list) {
      print('TestTextMcqBloc._fetchList list $list');
      if(list != null) {
        testList = list;
        currentQuestionIndex = 0;
        progressSink.add(false);
        broadcastTestListSink.add(list);
      } else {
        progressSink.add(false);
        errorSink.add(true);
      }

    }).catchError((e){
      print('TestTextMcqBloc._fetchList   e $e');
      progressSink.add(false);
      errorSink.add(true);
    });

  }

  Future resetTest() async{
    currentQuestionIndex = 0;

  }

  @override
  void dispose() {
    _optionClickedBehaviorSubject.close();
    _fetchTestBehaviorSubject.close();
    _broadcastTestListBehaviorSubject.close();
    _errorBehaviorSubject.close();
    _progressBehaviorSubject.close();
    _navigateToNextPageBehaviorSubject.close();
  }

}
