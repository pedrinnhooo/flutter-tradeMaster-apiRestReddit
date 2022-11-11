// ignore: file_names
import '../models/searchItem.dart';
import '../service/api_service.dart';

class SearchBloc {
  // ignore: non_constant_identifier_names
  final api_service = APIServiceSearch();

  Future<List<SearchItem>> getAPI() async {
    final result = await api_service.searchRequest();
    List<SearchItem> itemsList = [];
    for (var element in result["data"]["children"]) {
      itemsList.add(SearchItem.fromJson(element));
    }

    return itemsList;
  }
}
