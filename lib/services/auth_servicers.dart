part of 'services.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<ApiReturnValue<User>> signIn(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User> getCurrentUser() async {
    return null;
  }

  @override
  Future<ApiReturnValue<User>> signIn(String email, String password,
      {http.Client client}) async {
    // await Future.delayed(Duration(seconds: 1)); // simulate a network delay
    if (client == null) {
      client = http.Client();
    }
    String url = baseUrl + 'login';
    var response = await client.post(url,
        headers: {"Content-Type": "aplication/json"},
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }
    var data = jsonDecode(response.body);
    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);
    return ApiReturnValue(value: value);
  }

  @override
  Future<void> signOut() {
    return null;
  }
}
