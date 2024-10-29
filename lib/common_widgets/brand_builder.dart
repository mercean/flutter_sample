import 'package:flutter/material.dart';
import 'package:shoes/models/brand.dart';
class BrandBuilder extends StatelessWidget {
  const BrandBuilder({
    super.key,
    required this.future,
    required this.onEdit,
    required this.onDelete,
  });
  final Future<List<Brand>> future;
  final Function(Brand) onEdit;
  final Function(Brand) onDelete;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Brand>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final brand = snapshot.data![index];
              return _buildBrandCard(brand, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildBrandCard(Brand brand, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(brand.description),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => onEdit(brand),
              child: const Icon(Icons.edit, color: Colors.orange),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () => onDelete(brand),
              child: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
