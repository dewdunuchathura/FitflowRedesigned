import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitflow/main.dart';

void main() {
  testWidgets('FitFlow app renders login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FitFlowApp());

    // The login screen should show the FitFlow brand name
    expect(find.text('FitFlow'), findsOneWidget);

    // The tagline should be visible
    expect(
      find.text('Your smarter fitness journey starts here.'),
      findsOneWidget,
    );

    // Email and password fields should be present
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Log In button should be visible
    expect(find.text('Log In'), findsOneWidget);
  });

  testWidgets('Login validates empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(const FitFlowApp());

    // Tap Log In without entering any data
    await tester.tap(find.text('Log In'));
    await tester.pump();

    // Validation errors should appear
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Successful login navigates to home', (WidgetTester tester) async {
    await tester.pumpWidget(const FitFlowApp());

    // Fill in credentials
    await tester.enterText(
      find.byType(TextFormField).first,
      'alex@fitflow.com',
    );
    await tester.enterText(
      find.byType(TextFormField).last,
      'password123',
    );

    // Tap Log In
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    // After login the bottom nav should be visible
    expect(find.byType(NavigationBar), findsOneWidget);

    // Home screen greeting should be visible
    expect(find.textContaining('Good Morning'), findsOneWidget);
  });
}
