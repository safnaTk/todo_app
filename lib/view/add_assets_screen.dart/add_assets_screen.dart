import 'package:asset_manager/controller/asesetsscreen_controller.dart';
import 'package:flutter/material.dart';

class AddAssetScreen extends StatefulWidget {
  final bool isEdit;
  final int? id;
  final String? type;
  final String? name;
  final String? description;
  final String? serialNumber;
  final bool? isAvailable;

  const AddAssetScreen({
    super.key,
    this.isEdit = false,
    this.id,
    this.type,
    this.name,
    this.description,
    this.serialNumber,
    this.isAvailable,
  });

  @override
  State<AddAssetScreen> createState() => AddAssetScreenState();
}

class AddAssetScreenState extends State<AddAssetScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final serialController = TextEditingController();
  String type = 'Laptop';
  bool isAvailable = true;

  @override
  void initState() {
    if (widget.isEdit) {
      type = widget.type ?? 'Laptop';
      nameController.text = widget.name ?? '';
      descController.text = widget.description ?? '';
      serialController.text = widget.serialNumber ?? '';
      isAvailable = widget.isAvailable ?? true;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    serialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text(
          widget.isEdit ? 'Update Asset' : 'Add Asset',
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              value: type,
              items:
                  ['Laptop', 'Vehicle', 'Motor', 'Other']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (val) => setState(() => type = val!),
              decoration: const InputDecoration(
                labelText: "Asset Type",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Asset Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: serialController,
              decoration: const InputDecoration(
                labelText: "Serial Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text("Available"),
              value: isAvailable,
              onChanged: (val) => setState(() => isAvailable = val),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (widget.isEdit) {
                    await AssetController.updateAsset(
                      id: widget.id!,
                      type: type,
                      name: nameController.text,
                      description: descController.text,
                      serialNumber: serialController.text,
                      isAvailable: isAvailable,
                    );
                  } else {
                    await AssetController.addAsset(
                      type: type,
                      name: nameController.text,
                      description: descController.text,
                      serialNumber: serialController.text,
                      isAvailable: isAvailable,
                    );
                  }
                  Navigator.pop(context, true);
                },
                child: Text(
                  widget.isEdit ? "Update" : "Add",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

