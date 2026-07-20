abstract class AuthDataSource {
  Future<void> register({
    required String name,
    required String email,
    required String password,
  });
  Future<void> login({required String email, required String password});
  Future<void> forgotPassword({required String email});
  Future<void> sendEmailVerification();
  bool emailVerified();
  Future<void> signWithGoogle();
  Future<void> signWithFacebook();
}
