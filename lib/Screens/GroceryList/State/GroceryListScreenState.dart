import 'dart:convert';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ReusableWidgets/CommonViews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class GroceryItem {
  final String ingredient;
  final String level;

  GroceryItem({required this.ingredient, required this.level});
}

class GroceryIngredient {
  final String ingredient;
  final String quantity;

  GroceryIngredient({required this.ingredient, required this.quantity});
}

class GroceryState {
  final List<GroceryItem> items;
  final List<GroceryIngredient> generatedIngredients;
  final TextEditingController controller;
  final bool isLoading;

  GroceryState({
    required this.items,
    required this.generatedIngredients,
    required this.controller,
    required this.isLoading,
  });

  GroceryState copyWith({
    List<GroceryItem>? items,
    List<GroceryIngredient>? generatedIngredients,
    TextEditingController? controller,
    bool? isLoading,
  }) {
    return GroceryState(
      items: items ?? this.items,
      generatedIngredients: generatedIngredients ?? this.generatedIngredients,
      controller: controller ?? this.controller,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class GroceryStateNotifier extends StateNotifier<GroceryState> {
  GroceryStateNotifier()
    : super(
        GroceryState(
          items: [],
          generatedIngredients: [],
          controller: TextEditingController(),
          isLoading: false,
        ),
      );

  void addItem() {
    final ingredient = state.controller.text.trim();
    if (ingredient.isEmpty) return;

    final updatedList = [
      GroceryItem(ingredient: ingredient, level: '1 unit'),
      ...state.items,
    ];

    state.controller.clear();
    state = state.copyWith(items: updatedList);
  }

  void removeItem(int index) {
    final updatedList = [...state.items]..removeAt(index);
    state = state.copyWith(items: updatedList);
  }

  Future<void> pickImageAndDetectDish(BuildContext context) async {
    final imageFile = await Commonviews.imagePickerPopup(context);
    if (imageFile == null) return;

    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);
    final mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';

    const apiKey = 'AIzaSyCrXu-cpy0PHpqsk7yIzhunAjO4lNfKxBk';
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text":
                    "Please analyze this food image and tell me the name of the dish only.",
              },
              {
                "inlineData": {"mimeType": mimeType, "data": base64Image},
              },
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final dishName =
          json['candidates'][0]['content']['parts'][0]['text'] ?? '';
      if (dishName.trim().isNotEmpty) {
        state.controller.text = dishName.trim();
      } else {
        showIosStyleAlertDialog(context, "Dish name not found.");
      }
    } else {
      showIosStyleAlertDialog(context, "Failed to detect dish name.");
    }
  }

  Future<void> generateGroceryList(BuildContext context, int members) async {
    if (state.items.isEmpty) {
      showIosStyleAlertDialog(context, "Please enter at least one dish.");
      return;
    }

    state = state.copyWith(isLoading: true);

    const apiKey = 'AIzaSyCrXu-cpy0PHpqsk7yIzhunAjO4lNfKxBk';
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey',
    );

    final dishes = state.items.map((e) => e.ingredient).join(', ');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text":
                    "For the following dishes: $dishes, provide a consolidated grocery list for $members people. "
                    "If the same ingredient appears in multiple dishes, combine them and sum the quantities. "
                    "the quatities must be in indian standard like kg or grams or liters, milli liters or pinch. "
                    "Reply only with a clean list in the format 'Ingredient - Quantity' without dish names, explanations, or bullet points.",
              },
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final text = json['candidates'][0]['content']['parts'][0]['text'] ?? '';
      final lines = text.split('\n');
      final ingredients =
          lines
              .map((line) {
                final parts = line.split(RegExp(r'[-–]'));
                if (parts.length >= 2) {
                  return GroceryIngredient(
                    ingredient: parts[0].trim(),
                    quantity: parts[1].trim(),
                  );
                }
                return null;
              })
              .whereType<GroceryIngredient>()
              .toList();

      state = state.copyWith(
        generatedIngredients: ingredients,
        isLoading: false,
      );
    } else {
      state = state.copyWith(isLoading: false);
      showIosStyleAlertDialog(context, "Failed to fetch ingredient list.");
    }
  }

  void showMemberCountDialog(BuildContext context) {
    final TextEditingController memberController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Enter number of members",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: memberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "e.g. 4",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final text = memberController.text.trim();
                    final members = int.tryParse(text);
                    if (members != null && members > 0) {
                      Navigator.of(context).pop(); // Close dialog
                      generateGroceryList(context, members); // Call generator
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter a valid number.")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showIosStyleAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) return true;

    await openAppSettings();
    return false;
  }

  Future<void> generateAndSavePDFToDownloads(
    List<GroceryIngredient> ingredients,
    List<GroceryItem> dishes,
    BuildContext context,
  ) async {
    final hasPermission = await requestStoragePermission();
    if (!hasPermission) return;

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Grocery Ingredients List',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.TableHelper.fromTextArray(
                headers: ['Ingredient', 'Quantity'],
                data:
                    ingredients.map((e) => [e.ingredient, e.quantity]).toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellStyle: pw.TextStyle(fontSize: 12),
                cellAlignment: pw.Alignment.centerLeft,
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Dishes Included:',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              ...dishes.map((dish) => pw.Bullet(text: dish.ingredient)),
            ],
          );
        },
      ),
    );

    final downloadsDir = await DownloadsPathProvider.downloadsDirectory;
    if (downloadsDir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not access Downloads folder.")),
      );
      return;
    }

    final filePath = "${downloadsDir.path}/grocery_list.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF saved to Downloads folder:\n$filePath")),
    );
  }

  @override
  void dispose() {
    state.controller.dispose();
    super.dispose();
  }
}

final groceryProvider =
    StateNotifierProvider<GroceryStateNotifier, GroceryState>(
      (ref) => GroceryStateNotifier(),
    );
