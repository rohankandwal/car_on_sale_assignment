import 'package:assignment_car_on_sale/core/utils/space_limiting_formatter.dart';
import 'package:flutter/material.dart';

class VehicleSearchWidget extends StatelessWidget {
  final TextEditingController vinController;
  final VoidCallback onSearch;

  const VehicleSearchWidget({
    super.key,
    required this.vinController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLength: 17,
              controller: vinController,
              inputFormatters: [
                SpaceLimitingFormatter.deny(),
              ],
              decoration: InputDecoration(
                labelText: "Enter VIN",
                prefixIcon: Icon(Icons.car_rental_sharp,
                    color: Theme.of(context).colorScheme.primary),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    vinController.clear();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Sample Pin - 1G1AZ123456789012'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: theme.colorScheme.primary,
              ),
              onPressed: onSearch,
              child: Text(
                'Search',
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
