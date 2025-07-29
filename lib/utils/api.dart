import 'package:http/http.dart' as http;

class APIURL {
  APIURL(_);

  static var client = http.Client();

  static const String mainUrl = "http://128.199.81.208/api/v1";

  static const String mainUrlForUri = "https://www.sarpaynantaw.com";

  //Joker App Play Store Link
  static const String playStoreLink =
      "https://play.google.com/store/apps/details?id=com.lucky.seven_mm";

  //Auth
  static const String loginUrl = "$mainUrl/auth/signin";
  static const String exchangeRate = "$mainUrl/v1/exchange-rates";
}
