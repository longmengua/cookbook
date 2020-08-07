import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi365/pages/register/register_model.dart';
import 'package:hi365/utils/app_configs.dart';
import 'package:hi365/utils/base_provider.dart';
import 'package:hi365/utils/firebase_auth_provider.dart';

class ApiProvider extends BaseProvider with FirebaseAuthProvider {
  static final BaseOptions _options = BaseOptions(
    baseUrl: AppConfig().baseUrl,
    connectTimeout: 20000,
    receiveTimeout: 20000,
  );

  Future<FirebaseUser> get isUserExisted async => await auth.currentUser();

  ApiProvider([BaseOptions options]) : super(options: options ?? _options) {
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          FirebaseUser firebaseUser = await auth.currentUser();
          IdTokenResult idTokenResult = await firebaseUser.getIdToken();
          options.headers = {
            "content-type": "application/json",
            'X-Authorization-Firebase': idTokenResult.token,
          };
          print(options.headers);
          return options;
        },
      ),
    );
  }

  Future<RegisterResult> registerNewUserIntoHi365(
      FirebaseUser firebaseUser) async {
    return await client
        .post(
          '/resource/client/register',
          options: Options(
            headers: {
              'X-Authorization-Firebase':
                  (await firebaseUser.getIdToken()).token,
            },
          ),
        )
        .then((response) => RegisterResult.fromJson(response.data));
  }
}
