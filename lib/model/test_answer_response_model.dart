import 'package:meta/meta.dart';

class TestAnswerResponseModel {
  TestAnswerResponseModel({
    @required this.isAnswered,
    @required this.textOptions,
  });

  final bool isAnswered;
  final TextMcqOptions textOptions;
}


class TextMcqOptions {
  TextMcqOptions({
    @required this.optionText,
    @required this.isAnswer,
    @required this.answer,
  });

  final String optionText;
  final bool isAnswer;
  final String answer;

  factory TextMcqOptions.fromJson(Map<dynamic, dynamic> snapShot) {
    return TextMcqOptions(
      optionText: snapShot['optionText'] as String,
      isAnswer: snapShot["isAnswer"] as bool,
      answer: snapShot['answer'] as String,
    );
  }
}


class TextMcqTestCardModel {
  TextMcqTestCardModel({
    @required this.questions,
    @required this.hint,
    @required this.options,
  });

  final String questions;
  final String hint;
  final List<TextMcqOptions> options;

  factory TextMcqTestCardModel.fromJson(Map<dynamic, dynamic> snapShot) {
    var list = snapShot['options'] as List;
    List<TextMcqOptions> optionList =
    list.map((i) => TextMcqOptions.fromJson(i)).toList();
    return TextMcqTestCardModel(
        questions: snapShot['questions'] as String,
        hint: snapShot['hint'] as String,
        options: optionList);
  }
}

