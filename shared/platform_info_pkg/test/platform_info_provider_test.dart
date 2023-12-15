/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:dependency_interfaces/dependency_interfaces.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  late MockPlatformInfoProvider mockPlatformInfoProvider = MockPlatformInfoProvider();

  setUp(() {
    mockPlatformInfoProvider = MockPlatformInfoProvider();
  });
  group('Testing platform_info_pkg Provider', () {
    test('Version should be returned', () async {
      when(() => mockPlatformInfoProvider.version).thenAnswer((_) => Future<String?>.value('1.0.0'));
      final version = await mockPlatformInfoProvider.version;
      expect(version, '1.0.0');
    });
  });
}

class MockPlatformInfoProvider extends Mock implements PlatformInfo {}
