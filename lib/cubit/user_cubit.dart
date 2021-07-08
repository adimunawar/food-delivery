import 'dart:io';

import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foodmarket/models/models.dart';
import 'package:foodmarket/services/services.dart';
// import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User> result = await UserServices.signIn(email, password);
    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<void> signUp(User user, String password, {File pictureFile}) async {
    ApiReturnValue<User> result =
        await UserServices.signUp(user, password, pictureFile: pictureFile);
    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<void> uploadProfilePicture(File pictureFile) async {
    ApiReturnValue<String> result =
        await UserServices.uploadProfilePicture(pictureFile);

    if (result.value != null) {
      emit(UserLoaded((state as UserLoaded).user.copyWith(
          picturePath: "http://192.168.42.236:8001/storage/" + result.value)));
    }
  }

  Future<void> ceklogin() async {
    var token = User.token;
    if (token != null) {
      emit(LoggedInState());
    } else {
      emit(LoggedoutState());
    }
  }

  Future<void> delete() async {
    await clear();
    // await delete();
    emit(UserInitial());
  }

  // void cekUSer(String token) async {
  //   ApiReturnValue<User> result = await UserServices.getCurrentUser(token);
  //   if (result.value != null) {
  //     emit(UserLoaded(result.value));
  //   }
  // }

  @override
  UserState fromJson(Map<String, dynamic> json) {
    try {
      // User user = User.fromJson(json['user']);
      User.token = json['token'];
      return UserLoaded(User(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          address: json['address'],
          houseNumber: json['houseNumber'],
          phoneNumber: json['phoneNumber'],
          picturePath: json['picturePath'],
          city: json['city']));
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(UserState state) {
    try {
      if (state is UserLoaded) {
        return {
          'token': User.token,
          'id': state.user.id,
          'name': state.user.name,
          'address': state.user.address,
          'email': state.user.email,
          'houseNumber': state.user.houseNumber,
          'phoneNumber': state.user.phoneNumber,
          'picturePath': state.user.picturePath,
          'city': state.user.city,
        };
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
