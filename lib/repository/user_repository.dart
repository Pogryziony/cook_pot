/// Contains the minimal authentication logic that must be implemented
/// by a provider. It can also be used to create "mock" classes for easy
/// unit testing.
abstract class UserRepository {
  const UserRepository();

  /// Email of the signed user
  String? get signedEmail;

  /// Login with usernamne and password
  Future<bool> authenticate(String email, String password);

  /// Register with username and password
  Future<bool> register(String email, String password);

  /// Logout
  Future<void> logOut();
}