import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';

abstract interface class ForgetPasswordRepo {
 Future<Either<Failure, void>> resetPassword({required String email});}
