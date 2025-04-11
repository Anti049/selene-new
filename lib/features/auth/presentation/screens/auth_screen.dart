import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/themed_logo.dart';
import 'package:selene/core/auth/providers/auth_providers.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/utils/theming.dart';

enum AuthMode {
  signin('Sign In'),
  signup('Sign Up');

  const AuthMode(this.label);

  final String label;
}

@RoutePage()
class AuthScreen extends StatefulHookConsumerWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  AuthMode _authMode = AuthMode.signin;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signIn(BuildContext context, WidgetRef ref) async {
    // Delay to simulate loading
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      final authRepo = ref.read(authRepositoryProvider);
      final userCredential = await authRepo.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      setState(() {
        _isLoading = false;
      });
      if (userCredential == null) {
        // Handle sign-in error (e.g., show a message to the user)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Sign-in failed')));
      } else {
        // Navigate to the next screen after successful sign-up
        context.router.replacePath('/');
      }
    }
  }

  Future<void> _signUp(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      final authRepo = ref.read(authRepositoryProvider);
      final userCredential = await authRepo.signUpWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      setState(() {
        _isLoading = false;
      });
      if (userCredential == null) {
        // Handle sign-in error (e.g., show a message to the user)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Sign-up failed')));
      } else {
        // Navigate to the next screen after successful sign-up
        context.router.replacePath('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = context.mediaQuery.viewInsets.bottom > 0.0;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: context.mediaQuery.padding.top,
          bottom: context.mediaQuery.padding.bottom,
        ),
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: EdgeInsets.only(
            top: keyboardVisible ? 24.0 : 64.0,
            left: 32.0,
            right: 32.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: keyboardVisible ? 16.0 : 32.0,
              children: [
                ThemedLogo(size: keyboardVisible ? 72.0 : 192.0),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 16.0,
                    children: [
                      Text(_authMode.label, style: context.text.headlineMedium),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Symbols.email),
                          filled: true,
                          fillColor: context.theme.colorScheme.surface,
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(Symbols.lock),
                          filled: true,
                          fillColor: context.theme.colorScheme.surface,
                        ),
                        obscureText: true,
                      ),
                      AnimatedSize(
                        curve: kAnimationCurve,
                        duration: kAnimationDuration,
                        child:
                            (_authMode == AuthMode.signup)
                                ? TextFormField(
                                  controller: _confirmPasswordController,
                                  validator: (value) {
                                    if (_authMode != AuthMode.signup) {
                                      return null; // Only validate in signup mode
                                    }
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Symbols.lock),
                                    filled: true,
                                    fillColor:
                                        context
                                            .theme
                                            .colorScheme
                                            .surfaceContainer,
                                  ),
                                  obscureText: true,
                                )
                                : const SizedBox.shrink(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.0,
                        children: [
                          FilledButton(
                            onPressed: () {
                              // Unfocus active text field
                              FocusScope.of(context).unfocus();
                              // Perform sign in or sign up
                              if (_authMode == AuthMode.signin) {
                                _signIn(context, ref);
                              } else {
                                _signUp(context, ref);
                              }
                            },
                            style: FilledButton.styleFrom(
                              minimumSize: Size.fromHeight(40.0),
                            ),
                            child:
                                _isLoading
                                    ? Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CircularProgressIndicator(
                                        color: context.scheme.onPrimary,
                                      ),
                                    )
                                    : Text(_authMode.label),
                          ),
                          FilledButton(
                            onPressed: null,
                            style: FilledButton.styleFrom(
                              minimumSize: Size.fromHeight(40.0),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            child: Text('${_authMode.label} with Google'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _authMode =
                                    _authMode == AuthMode.signin
                                        ? AuthMode.signup
                                        : AuthMode.signin;
                              });
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.fromHeight(40.0),
                            ),
                            child: Text(
                              _authMode == AuthMode.signin
                                  ? 'Create an account'
                                  : 'Already have an account?',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
