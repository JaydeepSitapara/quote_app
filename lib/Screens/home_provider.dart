import 'package:quote_app/Screens/api_client.dart';
import 'package:quote_app/Screens/home_notifier.dart';

class HomeProvider {
  final HomeNotifier notifier;

  HomeProvider(this.notifier);

  final ApiClient _apiClient = ApiClient();

  void getQuote() {
    _apiClient.getQuote().then((value) {
      notifier.onNewQuote(value);
    });
  }
}
