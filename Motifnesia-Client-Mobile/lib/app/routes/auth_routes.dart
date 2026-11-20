import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/views/auth/pages/forgot_password_page.dart';
import 'package:motifnesia_mobile/views/auth/pages/login_page.dart';
import 'package:motifnesia_mobile/views/auth/pages/register_page.dart';

const loginRoute = AppRoute('/login', 'Masuk', Icons.login, LoginPage.new);

const authRoutes = [
  loginRoute,
  AppRoute(
    '/register',
    'Daftar Akun',
    Icons.person_add_alt_1_outlined,
    RegisterPage.new,
  ),
  AppRoute(
    '/forgot',
    'Atur Ulang Sandi',
    Icons.lock_reset_outlined,
    ForgotPasswordPage.new,
  ),
];
