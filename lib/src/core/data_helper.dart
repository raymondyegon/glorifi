import 'package:glorifi/src/core/api/api_endpoints.dart';
import 'package:glorifi/src/core/api/api_helper.dart';
import 'package:glorifi/src/core/api/rest_client.dart';
import 'package:glorifi/src/core/cache/cache_client.dart';
import 'package:glorifi/src/core/cache/cache_helper.dart';
import 'package:glorifi/src/core/cache/cache_helper_impl.dart';
import 'package:glorifi/src/core/mock/mock_data.dart';
import 'package:glorifi/src/environment/environment.dart';

abstract class DataHelper {
  setApiHelper(ApiHelper apiHelper);

  setCacheHelper(CacheHelper cacheHelper);

  ApiHelper get apiHelper;

  ApiHelper get mockApiHelper;

  CacheHelper get cacheHelper;
}

class DataHelperImpl implements DataHelper {
  DataHelperImpl._internal() {
    _apiHelper = ApiHelperImpl(
      api: RestClient(ApiEndPoints.apiBaseUrl),
      googleClient: RestClient(ApiEndPoints.googleMapsEndpoint),
    );
    _mockDataHelper = MockData();
    _cacheHelper = CacheHelperImpl(CacheClient());
  }

  static final DataHelperImpl _singleton = DataHelperImpl._internal();
  late ApiHelper _apiHelper;
  late CacheHelper _cacheHelper;
  late ApiHelper _mockDataHelper;
  Environment? _env;

  static DataHelperImpl get instance => _singleton;

  @override
  setApiHelper(ApiHelper apiHelper) {
    _apiHelper = apiHelper;
  }

  // TODO: Do we still need this?
  @override
  ApiHelper get apiHelper =>
      _env?.config.name == 'Mock' ? _mockDataHelper : _apiHelper;

  @override
  ApiHelper get mockApiHelper => _mockDataHelper;

  @override
  CacheHelper get cacheHelper => _cacheHelper;

  @override
  setCacheHelper(CacheHelper cacheHelper) {
    _cacheHelper = cacheHelper;
  }
}
