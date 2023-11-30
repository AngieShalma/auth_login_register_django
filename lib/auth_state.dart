part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class RegisterLoadingState extends AuthState {}
class RegisterSucessState extends AuthState {}
class RegisterFailedState extends AuthState {}

class LoginLoadingState extends AuthState {}
class LoginSucessState extends AuthState {}
class LoginFailedState extends AuthState {}

class LogoutLoadingState extends AuthState {}
class LogoutSucessState extends AuthState {}
class LogoutFailedState extends AuthState {}