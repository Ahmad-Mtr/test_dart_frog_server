import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  // TODO: implement route handler
  return switch (context.request.method) {
    HttpMethod.delete => _deleteUsers(id),
    HttpMethod.put => _updateUsers(id, context),
    _ => Future.value(Response(body: "Default Case"))
  };
}

Future<Response> _deleteUsers(String id) async {
  return Response.json(body: {
    'message': 'User with id:$id is deleted!',
  });
}

Future<Response> _updateUsers(String id, RequestContext context) async {
  return Response.json(body: {
    'message': 'User is updated!',
  });
}
