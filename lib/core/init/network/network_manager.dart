import 'package:dio/dio.dart';

import '../../constants/enums/locale_keys_enum.dart';
import '../cache/locale_manager.dart';

class NetworkManager {
  // # Tüm servislerin olası bir API bağlantısı durumunda tek bir servis managerdan yürütüleceği için oluşturduğumuz singleton bloğu
  static NetworkManager? _instance;
  static NetworkManager? get instance {
    _instance ??= NetworkManager._init();
    return _instance;
  }

  NetworkManager._init() {
    final baseOptions = BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      headers: {
        'val': LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN),
      },
    );
  }
}
