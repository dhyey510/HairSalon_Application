import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hairsalon_application/Screens/login_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('LoginScreen widget displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      
      // Verify the presence of key UI elements
      expect(find.text('HairSim'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('LOGIN'), findsOneWidget);
      expect(find.text('New user to an application?'), findsOneWidget);
      expect(find.text('SIGN UP'), findsOneWidget);
    });

    testWidgets('Login button triggers login function', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Tap the login button
      await tester.tap(find.text('LOGIN'));
      await tester.pump();

      // Verify that login function is called
      // You can add further expectations based on the behavior of the login function
    });

    testWidgets('Navigation to SignUpScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Tap the SIGN UP text
      await tester.tap(find.text('SIGN UP'));
      await tester.pump();

      // Verify navigation to SignUpScreen
      expect(find.text('Sign Up'), findsOneWidget);
    });

    // Add more test cases as needed to cover other functionalities of the LoginScreen
  });
}
