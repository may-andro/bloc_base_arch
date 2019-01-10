

import 'package:flutter_bloc_base_arch/model/test_answer_response_model.dart';

class TestApi {
  Future<List<TextMcqTestCardModel>> getUser() async {
    await Future.delayed(Duration(seconds: 3));

    var list = List<TextMcqTestCardModel>();

    TextMcqTestCardModel textMcqTestCardModel0 = TextMcqTestCardModel(
        questions: 'How to say "Hello!"',
        hint: '¡Hola!',
        options: [
          TextMcqOptions(
              optionText: '¡Buenas noches!',
              isAnswer: false,
              answer: '¡Hola!'
          ),
          TextMcqOptions(
              optionText: '¡Buenos días!',
              isAnswer: false,
              answer: '¡Hola!'
          ),
          TextMcqOptions(
              optionText: '¿Cómo estás?',
              isAnswer: false,
              answer: '¡Hola!'
          ),
          TextMcqOptions(
              optionText: '¡Hola!',
              isAnswer: true,
              answer: '¡Hola!'
          )
        ]
    );

    TextMcqTestCardModel textMcqTestCardModel1 = TextMcqTestCardModel(
        questions: 'How to say "Good Night!"',
        hint: '¡Buenas noches!',
        options: [
          TextMcqOptions(
              optionText: '¡Buenas noches!',
              isAnswer: true,
              answer: '¡Buenas noches!'
          ),
          TextMcqOptions(
              optionText: '¡Buenos días!',
              isAnswer: false,
              answer: '¡Buenas noches!'
          ),
          TextMcqOptions(
              optionText: '¿Cómo estás?',
              isAnswer: false,
              answer: '¡Buenas noches!'
          ),
          TextMcqOptions(
              optionText: '¡Hola!',
              isAnswer: false,
              answer: '¡Buenas noches!'
          )
        ]
    );

    TextMcqTestCardModel textMcqTestCardModel2 = TextMcqTestCardModel(
        questions: 'How to say "Good Morning!"',
        hint: '¡Buenos días!',
        options: [
          TextMcqOptions(
              optionText: '¡Buenas noches!',
              isAnswer: false,
              answer: '¡Buenos días!'
          ),
          TextMcqOptions(
              optionText: '¡Buenos días!',
              isAnswer: true,
              answer: '¡Buenos días!'
          ),
          TextMcqOptions(
              optionText: '¿Cómo estás?',
              isAnswer: false,
              answer: '¡Buenos días!'
          ),
          TextMcqOptions(
              optionText: '¡Hola!',
              isAnswer: false,
              answer: '¡Buenos días!'
          )
        ]
    );

    TextMcqTestCardModel textMcqTestCardModel3 = TextMcqTestCardModel(
        questions: 'How to say "How are you?"',
        hint: '¿Cómo estás?',
        options: [
          TextMcqOptions(
              optionText: '¡Buenas noches!',
              isAnswer: false,
              answer: '¿Cómo estás?'
          ),
          TextMcqOptions(
              optionText: '¡Buenos días!',
              isAnswer: false,
              answer: '¿Cómo estás?'
          ),
          TextMcqOptions(
              optionText: '¿Cómo estás?',
              isAnswer: true,
              answer: '¿Cómo estás?'
          ),
          TextMcqOptions(
              optionText: '¡Hola!',
              isAnswer: false,
              answer: '¿Cómo estás?'
          )
        ]
    );

    list.add(textMcqTestCardModel0);
    list.add(textMcqTestCardModel1);
    list.add(textMcqTestCardModel2);
    list.add(textMcqTestCardModel3);

    return list;
  }
}

TestApi api = TestApi();