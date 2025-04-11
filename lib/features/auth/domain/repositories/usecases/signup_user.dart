import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository_interface.dart';

class SignUpUser {
  final AuthRepository repo;
  SignUpUser(this.repo);
  Future<void> call(String email, String password) {
    return repo.signUp(email: email, password: password);
  }
}
