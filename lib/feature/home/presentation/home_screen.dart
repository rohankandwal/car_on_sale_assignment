import 'package:assignment_car_on_sale/core/utils/get_it.dart';
import 'package:assignment_car_on_sale/core/utils/space_limiting_formatter.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/bloc/home_cubit.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _vinController = TextEditingController();
  final HomeCubit homeCubit = getIt.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          "CarOnSale",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        iconTheme: IconThemeData(
          color: theme.canvasColor,
        ),
      ),
      drawer: Container(
        color: theme.canvasColor,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person_2_rounded,
              size: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Hi User',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        heightFactor: 1.8,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLength: 17,
                  controller: _vinController,
                  inputFormatters: [
                    SpaceLimitingFormatter.deny(),
                  ],
                  decoration: InputDecoration(
                    labelText: "Enter VIN",
                    prefixIcon: Icon(Icons.car_rental_sharp,
                        color: Theme.of(context).colorScheme.primary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear,
                          color: Theme.of(context).colorScheme.primary),
                      onPressed: () {
                        _vinController.clear();
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
                    backgroundColor: theme.primaryColor,
                  ),
                  onPressed: () {
                    homeCubit.searchVin(_vinController.text);
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _vinController.dispose();
    super.dispose();
  }
}
