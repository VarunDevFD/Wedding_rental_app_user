import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/forgot_password_repo.dart';

class ForgetPasswordUseCase {
  final ForgetPasswordRepo _forgetPasswordRepo;

  ForgetPasswordUseCase(this._forgetPasswordRepo);

  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await _forgetPasswordRepo.resetPassword(email: email);
      return const Right(null); // Return success
    } catch (e) {
      return Left(Failure(message: e.toString())); // Return failure
    }
  }
}
