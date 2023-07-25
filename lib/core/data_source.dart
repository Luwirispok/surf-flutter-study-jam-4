import 'api_helper.dart';

class EightBallDataSource {
  ///Получение случайного предсказания
  static Future<String> getRandomFortuneReading() async {
    String url = 'https://eightballapi.com/api';
    Map<String, dynamic> response = await ApiHelper.get(path: url);
    return response['reading'];
  }
}

class JustTranslateDataSource {
  ///Перевод текста
  static Future<String> getTranslation({String lang = 'ru', required String text}) async {
    String url = 'https://just-translated.p.rapidapi.com/';
    Map<String, String> params = {'lang': lang, 'text': text};
    Map<String, String> headers = {
      'X-RapidAPI-Key': '55ae1ccc42msh580a51a069ea34dp1bccb7jsn0ec6365fba5a',
      'X-RapidAPI-Host': 'just-translated.p.rapidapi.com',
    };
    Map<String, dynamic> response = await ApiHelper.get(path: url, queryParameters: params, header: headers);
    return response['text'][0];
  }
}
