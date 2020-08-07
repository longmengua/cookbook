import 'health_knowledge_model.dart';
import 'health_knowledge_provider.dart';

enum HealthKnowledgeEvent {
  init,
  search,
  latest,
  popular,
  error,
}

class HealthKnowledgeBloc {
  HealthKnowledgeApiProvider _healthKnowledgeApiProvider =
      HealthKnowledgeApiProvider();
  Stream stream;

  String keyword;

  add(HealthKnowledgeEvent healthKnowledgeEvent) {
    switch (healthKnowledgeEvent) {
      case HealthKnowledgeEvent.init:
        break;
      case HealthKnowledgeEvent.search:
        print('search');
        try {
          stream = search();
        } catch (e) {
          print(e);
        }
        break;
      case HealthKnowledgeEvent.latest:
        stream = getLatestArticle();
        break;
      case HealthKnowledgeEvent.popular:
        stream = getPopularArticle();
        break;
      case HealthKnowledgeEvent.error:
        break;
    }
  }

  Stream<HealthKnowledgeDB> getLatestArticle() async* {
    HealthKnowledgeDB healthKnowledgeDB = await _healthKnowledgeApiProvider
        .getLatest()
        .then((response) => response);
    yield healthKnowledgeDB;
  }

  Stream<HealthKnowledgeDB> getPopularArticle() async* {
    HealthKnowledgeDB healthKnowledgeDB = await _healthKnowledgeApiProvider
        .getPopular()
        .then((response) => response);
    yield healthKnowledgeDB;
  }

  Stream<HealthKnowledgeDB> search() async* {
    HealthKnowledgeDB healthKnowledgeDB = await _healthKnowledgeApiProvider
        .search(keyword)
        .then((response) => response);
    yield healthKnowledgeDB;
  }
}
