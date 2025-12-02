import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grand_hotel/main.dart';
import 'package:grand_hotel/repositories/local_message_repository.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Initialize repositories for test
    final messageRepository = LocalMessageRepository();
    await messageRepository.init();

    // ✅ CardRepository ham kerak
    final cardRepository = CardRepositoryImpl();

    // Build our app and trigger a frame
    await tester.pumpWidget(MyApp(
      messageRepository: messageRepository,
      cardRepository: cardRepository, // ✅ Qo'shildi
    ));

    // Wait for async operations
    await tester.pumpAndSettle();

    // Verify that the app launched (MainScreen visible)
    // ✅ GetMaterialApp ishlatilgani uchun
    expect(find.byType(MaterialApp), findsOneWidget);

    // Clean up
    await messageRepository.close();
  });
}