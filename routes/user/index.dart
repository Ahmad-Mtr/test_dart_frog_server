import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:test_dart_frog_server/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  // TODO: implement route handler
  return switch (context.request.method) {
    HttpMethod.get => _getUsers(context),
    HttpMethod.post => _createUsers(context),
    _ => Future.value(Response(body: "Default Case"))
  };
}

Future<Response> _getUsers(RequestContext context) async {
  final repo = context.read<UserRepository>();

  final users = await repo.getAll();

  return Future.value(Response.json(
    body: users,
  ));
}

Future<Response> _createUsers(RequestContext context) async {
  final json = (await context.request.json()) as Map<String, dynamic>;
  final name = json['name'] as String?;
  final lastname = json['lastname'] as String?;
  final username = json['username'] as String?;
  final password = json['password'] as String?;

  // TODO: Insert user info to Database
  if (name == null ||
      lastname == null ||
      username == null ||
      password == null) {
    return Response.json(
      body: {
        'message':
            'Problem! Kein Vorname oder Nachname, oder username, oder password',
      },
      statusCode: HttpStatus.badRequest,
    );
  }

  final repo = context.read<UserRepository>();
  final user = await repo.createUser(
      name: name, lastname: lastname, username: username, password: password);
  return Response.json(body: {
    'message': 'Saved!',
    'user': user,
  });
}
