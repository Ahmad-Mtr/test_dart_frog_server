import 'dart:convert';

import 'package:test_dart_frog_server/src/generated/prisma/prisma_client.dart';
import 'package:crypto/crypto.dart';

class UserRepository {
  UserRepository(this._db);

  final PrismaClient _db;

  Future<User?> authUser(
      {required String username, required String password}) async {
    final user = await _db.user.findFirst(
      where: UserWhereInput(
        username: StringFilter(equals: username),
        password: StringFilter(equals: _hashPassword(password)),
      ),
    );
    return user;
  }

  Future<User?> createUser({
    required String name,
    required String lastname,
    required String username,
    required String password,
  }) async {
    final user = await _db.user.create(
        data: UserCreateInput(
      name: name,
      lastname: lastname,
      username: username,
      password: _hashPassword(password),
    ));
    return user;
  }

  Future<List<User>> getAll() async {
    final list = await _db.user.findMany();
    return list.toList();
  }

  String _hashPassword(String password) {
    final encodedpassword = utf8.encode(password);
    return sha256.convert(encodedpassword).toString();
  }
}
