import 'package:flutter/material.dart';
import 'package:shoes/models/brand.dart';
import 'package:shoes/services/database_service.dart';
class BrandFormPage extends StatefulWidget {
  final Brand? brand;  // Optional, can be null for new entries

  const BrandFormPage({super.key, this.brand});

  @override
  _BrandFormPageState createState() => _BrandFormPageState();
}

class _BrandFormPageState extends State<BrandFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    if (widget.brand != null) {
      _nameController.text = widget.brand!.name;
      _descController.text = widget.brand!.description;
    }
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final description = _descController.text;
    if (widget.brand == null) {
      // If it's a new brand
      await _databaseService.insertBrand(Brand(name: name, description: description));
    } else {
      // Updating an existing brand
      await _databaseService.updateBrand(Brand(id: widget.brand!.id, name: name, description: description));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Edit Brand'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Brand Name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onSave,
              child: const Text('Save Brand'),
            ),
          ],
        ),
      ),
    );
  }
}
