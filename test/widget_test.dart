import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hairsalon_application/Screens/home_screen.dart';
import 'package:hairsalon_application/Models/SalonModel.dart';
import 'package:hairsalon_application/Widgets/AllSalonCard.dart';
import 'package:hairsalon_application/Widgets/NearbySalonCard.dart';

void main() {
  testWidgets('HomeScreen widget displays user profile correctly', (WidgetTester tester) async {
    // Build the HomeScreen widget
    await tester.pumpWidget(HomeScreen());

    // Verify that the user profile section is displayed correctly
    expect(find.text('Hi,'), findsOneWidget); // Verify greeting text
    expect(find.byType(Image), findsOneWidget); // Verify profile image is displayed
    expect(find.text('location'), findsOneWidget); // Verify location text
  });

  testWidgets('HomeScreen widget displays nearby salons correctly', (WidgetTester tester) async {
    // Mock nearby salons data
    List<Salon> nearbySalons = [
      Salon(name: 'Salon A', imageUrl: 'url1', city: 'City A', state: 'State A', rating: 4.5),
      Salon(name: 'Salon B', imageUrl: 'url2', city: 'City B', state: 'State B', rating: 4.0),
    ];

    // Build the HomeScreen widget
    await tester.pumpWidget(HomeScreen());

    // Verify that the nearby salons section is displayed correctly
    expect(find.text('Nearby Salons'), findsOneWidget); // Verify section title
    expect(find.byType(NearbySalonCard), findsNWidgets(nearbySalons.length)); // Verify nearby salon cards
  });

  testWidgets('HomeScreen widget displays all salons correctly', (WidgetTester tester) async {
    // Mock all salons data
    List<Salon> allSalons = [
      Salon(name: 'Salon C', imageUrl: 'url3', city: 'City C', state: 'State C', rating: 4.2),
      Salon(name: 'Salon D', imageUrl: 'url4', city: 'City D', state: 'State D', rating: 4.8),
    ];

    // Build the HomeScreen widget
    await tester.pumpWidget(HomeScreen());

    // Verify that the all salons section is displayed correctly
    expect(find.text('All Salons'), findsOneWidget); // Verify section title
    expect(find.byType(AllSalonCard), findsNWidgets(allSalons.length)); // Verify all salon cards
  });
}
