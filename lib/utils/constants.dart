// ignore_for_file: non_constant_identifier_names
import 'environment.dart';

final String AWS_APP_SYNC_ENDPOINT = Environment.getEnvValueForKey('AWS_APP_SYNC_ENDPOINT');
final String USER_POOL_ID = Environment.getEnvValueForKey('USER_POOL_ID');
final String USER_POOL_CLIENT_ID = Environment.getEnvValueForKey('USER_POOL_CLIENT_ID');
final String CLOUDINARY_API_KEY = Environment.getEnvValueForKey('CLOUDINARY_API_KEY');
final String CLOUDINARY_API_SECRET = Environment.getEnvValueForKey('CLOUDINARY_API_SECRET');
final String CLOUDINARY_API_NAME = Environment.getEnvValueForKey('CLOUDINARY_API_NAME');
final String AWS_APP_SYNC_API_KEY = Environment.getEnvValueForKey('AWS_APP_SYNC_API_KEY');
final String OPENDATA_HOSPITAL_API = Environment.getEnvValueForKey('OPENDATA_HOSPITAL_API');

enum USER_ROLES { CLIENT, ACUDIER }
enum USER_GENDER { MALE, FEMALE, OTHER }

enum REQUEST_STATUS { ACCEPTED, PENDING, REJECTED, COMPLETED }

final double minFare = 04.00;
final double maxFare = 20.00;

final double BOTTOM_BOX_HEIGHT = 80.0;
