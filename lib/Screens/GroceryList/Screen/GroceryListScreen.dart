import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/GroceryList/State/GroceryListScreenState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroceryListScreen extends ConsumerStatefulWidget {
  const GroceryListScreen({super.key});

  @override
  GroceryListScreentScreenState createState() =>
      GroceryListScreentScreenState();
}

class GroceryListScreentScreenState extends ConsumerState<GroceryListScreen> {
  void removeIngredient(int index) {
    ref.read(groceryProvider.notifier).removeItem(index);
  }

  @override
  Widget build(BuildContext context) {
    final groceryState = ref.watch(groceryProvider);
    final notifier = ref.read(groceryProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top input row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: groceryState.controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // More rounded corners
                        ),
                        hintText: 'Enter a dish',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ), // Padding inside the TextField
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ), // Space between the TextField and camera button
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.deepOrange,
                      size: 28,
                    ),
                    onPressed: () => notifier.pickImageAndDetectDish(context),
                  ),
                ],
              ),
              const SizedBox(height: 12), // Space between the rows
              // Second row with the Add Dish button (full width and styled)
              Container(
                width: double.infinity, // Makes the button full width
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: ElevatedButton(
                  onPressed: () {
                    notifier.addItem();
                    if (groceryState.items.isEmpty) {
                      notifier.showIosStyleAlertDialog(context, "Enter dishes");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400, // Button color
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ), // Padding to make the button taller
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Rounded corners
                    ),
                    elevation: 5, // Add some shadow to make it stand out
                  ),
                  child: const Text(
                    "Add Dish",
                    style: TextStyle(
                      fontSize: 16,
                    ), // Optional: Customize font size for better readability
                  ),
                ),
              ),
              const SizedBox(height: 12), // Space between the rows
              // Recipe list
              Container(
                height:
                    groceryState.items.length >= 3
                        ? 200
                        : groceryState.items.length * 75,
                child: ListView.builder(
                  itemCount: groceryState.items.length,
                  itemBuilder: (context, index) {
                    final item = groceryState.items[index];
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.ingredient,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.orange.shade800,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red.shade400,
                              ),
                              onPressed: () => removeIngredient(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              Visibility(
                visible: groceryState.items.isNotEmpty,
                child: ElevatedButton(
                  onPressed: () {
                    notifier.showMemberCountDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Generate List"),
                ),
              ),

              const SizedBox(height: 30),

              if (groceryState.generatedIngredients.isNotEmpty) ...[
                Text(
                  "Ingredients List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade700,
                  ),
                ),
                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: groceryState.generatedIngredients.length,
                  itemBuilder: (context, index) {
                    final item = groceryState.generatedIngredients[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.orange.shade200),
                        ),
                        borderRadius:
                            index ==
                                    groceryState.generatedIngredients.length - 1
                                ? const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )
                                : BorderRadius.zero,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                item.ingredient,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                item.quantity,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    final ingredients = groceryState.generatedIngredients;
                    final dishes = groceryState.items;
                    notifier.generateAndSavePDFToDownloads(ingredients, dishes,context);
                  },
                  icon: const Icon(Icons.download),
                  label: const Text("Download PDF"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.teal.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
