part of 'models.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String address;
  final String houseNumber;
  final String phoneNumber;
  final String city;
  final String picturePath;
  static String token;

  User({
    this.id,
    this.name,
    this.address,
    this.email,
    this.houseNumber,
    this.phoneNumber,
    this.city,
    this.picturePath,
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        address: data['address'],
        houseNumber: data['houseNumber'],
        phoneNumber: data['phoneNumber'],
        city: data['city'],
        picturePath: data['profile_photo_url'],
      );

  User copyWith({
    int id,
    String name,
    String email,
    String address,
    String houseNumber,
    String phoneNumber,
    String city,
    String picturePath,
  }) =>
      User(
          id: id ?? this.id,
          name: name ?? this.name,
          address: address ?? this.address,
          email: email ?? this.email,
          houseNumber: houseNumber ?? this.houseNumber,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          city: city ?? this.city,
          picturePath: picturePath ?? this.picturePath);
  @override
  List<Object> get props =>
      [id, name, address, email, houseNumber, phoneNumber, city, picturePath];
}

User mockUser = User(
    id: 1,
    name: 'Adi Munawar',
    email: 'adi@gmail.com',
    address: 'GCC Cluster Sakura',
    houseNumber: 'i3 no 10',
    phoneNumber: '082512335',
    city: 'Bekasi',
    picturePath:
        'https://pbs.twimg.com/profile_images/1166004682851942402/sHs2hsnr.jpg');
