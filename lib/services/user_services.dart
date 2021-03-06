part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> signIn(String email, String password,
      {http.Client client}) async {
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

  static Future<ApiReturnValue<User>> signUp(User user, String password,
      {File pictureFile, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseUrl + 'register';
    var response = await client.post(url,
        headers: {"Content-Type": "aplication/json"},
        body: jsonEncode(<String, String>{
          'name': user.name,
          'email': user.email,
          'password': password,
          'password_confirmation': password,
          'address': user.address,
          'city': user.city,
          'houseNumber': user.houseNumber,
          'phoneNumber': user.phoneNumber,
        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'please try again');
    }

    var data = jsonDecode(response.body);
    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);

    // todo: upload image

    if (pictureFile != null) {
      ApiReturnValue<String> result = await uploadProfilePicture(pictureFile);

      if (result.value != null) {
        value = value.copyWith(
            picturePath: "http://192.168.42.132:8001/storage/" + result.value);
      }
    }

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<String>> uploadProfilePicture(File pictureFile,
      {http.MultipartRequest request}) async {
    String url = baseUrl + 'user/photo';
    var uri = Uri.parse(url);

    if (request == null) {
      request = http.MultipartRequest("POST", uri)
        ..headers["Content-Type"] = "application/json"
        ..headers["Authorization"] = "Bearer ${User.token}";
    }

    var multipartFile =
        await http.MultipartFile.fromPath('file', pictureFile.path);
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      String imagePath = data['data'][0];

      return ApiReturnValue(value: imagePath);
    } else {
      return ApiReturnValue(message: 'Uploading Profile Picture Failed');
    }
  }

  Future<void> signOut() {
    return null;
  }

  static Future<ApiReturnValue<User>> getCurrentUser(String token,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'currentuser';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "aplication/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Failed please try again");
    }
    var data = jsonDecode(response.body);
    User value = User.fromJson(data['data']['user']);

    return ApiReturnValue(value: value);
  }
}
