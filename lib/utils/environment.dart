import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static const ENV_LOCAL_FILE_NAME = '.env';
  static const ENV_DEV_FILE_NAME = '.env.development';
  static const ENV_PROD_FILE_NAME = '.env.production';

  const Environment();

  static String getEnvValueForKey(String key) {
    String value = DotEnv().env[key];

    return value;
  }

  static Future<void> loadEnvFile() async {
    const IS_DEV = String.fromEnvironment('DEV', defaultValue: 'false');
    const IS_PROD = String.fromEnvironment('PROD', defaultValue: 'false');

    if (IS_PROD == 'true') return await DotEnv().load(ENV_DEV_FILE_NAME);
    if (IS_DEV == 'true') return await DotEnv().load(ENV_DEV_FILE_NAME);
    return await DotEnv().load(ENV_LOCAL_FILE_NAME);
  }
}
