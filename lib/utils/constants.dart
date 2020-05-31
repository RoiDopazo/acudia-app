// ignore_for_file: non_constant_identifier_names
import 'environment.dart';

final String AWS_APP_SYNC_ENDPOINT =
    Environment.getEnvValueForKey('AWS_APP_SYNC_ENDPOINT');
final String USER_POOL_ID = Environment.getEnvValueForKey('USER_POOL_ID');
final String USER_POOL_CLIENT_ID =
    Environment.getEnvValueForKey('USER_POOL_CLIENT_ID');

enum USER_ROLES { client, acudier }
enum USER_GENDER { male, female, other }
