import 'package:dio/dio.dart';

class APIServiceSearch {
  final Dio dio = Dio();

  searchRequest() async {
    Response response =
        await dio.get('https://www.reddit.com/r/climbing/top.json?');

    return response.data;
  }
}
