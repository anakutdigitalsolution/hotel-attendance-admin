import 'package:equatable/equatable.dart';

abstract class VerifyOtpState extends Equatable {
  VerifyOtpState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class VerifyingOtp extends VerifyOtpState {}

class VerifiedOtp extends VerifyOtpState {
  final dynamic token;
  VerifiedOtp({required this.token});
}

class ResendingVerifyOtp extends VerifyOtpState {}

class ResentVerifiedOpt extends VerifyOtpState {}

class ErrorVerifyOtp extends VerifyOtpState {
  final dynamic error;
  ErrorVerifyOtp({required this.error});
}
