import 'package:flutter_test/flutter_test.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/environment/environment.dart';

void main() {
  group('Url', () {
    group('when env is DEV', () {
      setUp(() {
        Environment().initConfig(Environment.dev);
      });

      test('appUrl should be localhost', () {
        expect(Urls.appUrl, 'http://localhost:8080');
      });

      test('unqorkAuthUrl should be uatx', () {
        expect(Urls.unqorkAuthUrl, 'https://purpose-uatx.unqork.io/auth/oidc/glorifi?destination=/app/redirect');
      });
    });
  });
}
