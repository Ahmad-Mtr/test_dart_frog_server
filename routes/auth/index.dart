import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:test_dart_frog_server/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _authUser(context),
    _ => Future.value(Response(body: 'This is default'))
  };
}

Future<Response> _authUser(RequestContext context) async {
  final json = (await context.request.json()) as Map<String, dynamic>;

  final username = json['username'] as String?;
  final password = json['password'] as String?;

  if (username == null || password == null) {
    return Response.json(
      body: {'message': 'Username or password not the same!'},
      statusCode: HttpStatus.badRequest,
    );
  }
  final repo = context.read<UserRepository>();
  final user = await repo.authUser(username: username, password: password);

  return Response.json(
    body: {'user': user},
  );
}
