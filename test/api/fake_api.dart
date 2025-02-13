import 'package:zulip/api/core.dart';
import 'package:zulip/model/store.dart';

/// An [ApiConnection] that accepts and replays canned responses, for testing.
class FakeApiConnection extends ApiConnection {
  FakeApiConnection({required Uri realmUrl, required String email})
      : super(auth: Auth(
                realmUrl: realmUrl, email: email, apiKey: _fakeApiKey));

  FakeApiConnection.fromAccount(Account account)
      : this(realmUrl: account.realmUrl, email: account.email);

  String? _nextResponse;

  // TODO: This mocking API will need to get richer to support all the tests we need.

  void prepare(String response) {
    assert(_nextResponse == null,
        'FakeApiConnection.prepare was called while already expecting a request');
    _nextResponse = response;
  }

  @override
  void close() {
    // TODO: record connection closed; assert open in methods
  }

  @override
  Future<String> get(String route, Map<String, dynamic>? params) async {
    final response = _nextResponse;
    _nextResponse = null;
    return response!;
  }

  @override
  Future<String> post(String route, Map<String, dynamic>? params) async {
    final response = _nextResponse;
    _nextResponse = null;
    return response!;
  }

  @override
  Future<String> postFileFromStream(String route, Stream<List<int>> content, int length, { String? filename }) async {
    final response = _nextResponse;
    _nextResponse = null;
    return response!;
  }
}

const String _fakeApiKey = 'fake-api-key';
