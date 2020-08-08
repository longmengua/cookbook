import 'package:dio/dio.dart';
import 'health_knowledge_model.dart';

class HealthKnowledgeApiProvider {
  static String domainUrl = 'http://healthcare.h2uclub.com/web';
  final Dio dio = new Dio();

  Future getLatest() async {
    return await dio
        .get(
            '$domainUrl/webapi/article?&query=status=0&order=vistors%20desc&content=false')
        .then((response) {
      return HealthKnowledgeDB.fromJson(response.data);
    });
  }

  Future getPopular() async {
    return await dio
        .get(
            '$domainUrl/webapi/article?&query=status%3D0&order=release_time+desc&content=false')
        .then((response) {
      return HealthKnowledgeDB.fromJson(response.data);
    });
  }

  Future getDetail(String id) async {
    return await dio.get('$domainUrl/webapi/article/$id').then((response) {
      return HealthKnowledgeDB.fromJson(response.data);
    });
  }

  Future search(String keyword) async {
    String url =
        "$domainUrl/webapi/article?&query=status=0+AND+(author_name+like+'%大腸%'+OR+title+like+'%大腸%'+OR+subtitle+like+'%大腸%'+OR+tag_names+like+'%大腸%'+OR+content+like+'%大腸%')&order=vistors+desc&content=false";
    url = url.replaceAll('大腸', keyword);
    return dio.get(url).then((response) {
      return HealthKnowledgeDB.fromJson(response.data);
    });
  }
}
