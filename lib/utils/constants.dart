// ignore_for_file: non_constant_identifier_names
import 'environment.dart';

final String AWS_APP_SYNC_ENDPOINT =
    Environment.getEnvValueForKey('AWS_APP_SYNC_ENDPOINT');
final String USER_POOL_ID = Environment.getEnvValueForKey('USER_POOL_ID');
final String USER_POOL_CLIENT_ID =
    Environment.getEnvValueForKey('USER_POOL_CLIENT_ID');
final String CLOUDINARY_API_KEY =
    Environment.getEnvValueForKey('CLOUDINARY_API_KEY');
final String CLOUDINARY_API_SECRET =
    Environment.getEnvValueForKey('CLOUDINARY_API_SECRET');
final String CLOUDINARY_API_NAME =
    Environment.getEnvValueForKey('CLOUDINARY_API_NAME');
final String AWS_APP_SYNC_API_KEY =
    Environment.getEnvValueForKey('AWS_APP_SYNC_API_KEY');

enum USER_ROLES { CLIENT, ACUDIER }
enum USER_GENDER { MALE, FEMALE, OTHER }
