import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  // TODO: implement route handler
  if (context.request.method == HttpMethod.get)
    return Response(body: 'This is a new route! with GET');
  return Response(body: 'This is a new route! without get');
}
