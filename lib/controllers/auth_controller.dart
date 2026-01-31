import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mac_store_app/global_variable.dart';
import 'package:mac_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/services/manage_http_response.dart';
import 'package:mac_store_app/views/screens/authentication_screens/login_screen.dart';

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: jsonEncode(
          user.toJson(),
        ), //Convert the user object to Json for the request body
        headers: <String, String>{
          //Set the headers for the request
          'Content-Type':
              'application/json; charset=UTF-8', //specify the context type as Json
        },
      );

      manageHTTpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          showSnackBar(context, 'Account has beem created for you');
        },
      );
    } catch (e) {
      print("Error:$e");
    }
  }

  //signin users function

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          'email': email, //include the email in the request body,
          'password': password, //include the password in the request body.
        }),
        headers: <String, String>{
          //This will set the header
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //Handle the response using the managehttpresponse

      manageHTTpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Logged In');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}
