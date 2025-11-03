// widgets/app_starter.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/bloc/app_starter/app_starter_bloc.dart';
import 'package:grand_hotel/bloc/app_starter/app_starter_event.dart';
import 'package:grand_hotel/bloc/app_starter/app_starter_state.dart';
import 'package:grand_hotel/bloc/auth/auth_bloc.dart';
import 'package:grand_hotel/bloc/auth/auth_event.dart';
import 'package:grand_hotel/bloc/auth/auth_state.dart';

import '../features/splash/screens/splash_screen.dart';

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStarterBloc, AppStarterState>(
      builder: (context, appStarterState) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            // Initialize app and auth if not done yet
            if (appStarterState is AppStarterInitial) {
              context.read<AppStarterBloc>().add(InitializeApp());
            }

            if (authState is AuthInitial) {
              context.read<AuthBloc>().add(InitializeAuth());
            }

            // Show loading while initializing
            if (appStarterState is AppStarterInitializing ||
                authState is AuthInitializing) {
              return const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        'Initializing Grand Hotel...',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Show error if initialization failed
            if (appStarterState is AppStarterError) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Error: ${appStarterState.message}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AppStarterBloc>().add(InitializeApp());
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (authState is AuthError) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Auth Error: ${authState.message}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(InitializeAuth());
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Both initialized, show splash screen
            if (appStarterState is AppStarterInitialized) {
              return const SplashScreen();
            }

            // Default fallback
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      },
    );
  }
}