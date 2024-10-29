import 'package:flutter/material.dart';
import 'package:shoes/models/brand.dart';
import 'package:shoes/services/database_service.dart';

class BrandEditPage extends StatefulWidget {
  final Brand brand;

  BrandEditPage({Key? key, required this.brand}) : super(key: key);

  @override
  _BrandEditPageState createState() => _BrandEditPageState();
}

class _BrandEditPageState extends State<BrandEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.brand.name);
    _descriptionController = TextEditingController(text: widget.brand.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Brand'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveUpdatedBrand,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Brand Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the brand name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveUpdatedBrand() async {
    if (_formKey.currentState!.validate()) {
      Brand updatedBrand = Brand(
        id: widget.brand.id,
        name: _nameController.text,
        description: _descriptionController.text,
      );
      await DatabaseService().updateBrand(updatedBrand);
      Navigator.of(context).pop(true);  // Pop with true to trigger a refresh
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
