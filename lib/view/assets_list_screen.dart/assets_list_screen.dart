
import 'package:asset_manager/controller/asesetsscreen_controller.dart';
import 'package:asset_manager/view/add_assets_screen.dart/add_assets_screen.dart';
import 'package:flutter/material.dart';



class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  State<AssetListScreen> createState() => _AssetListScreenState();
}

class _AssetListScreenState extends State<AssetListScreen> {
  @override
  void initState() {
    AssetController.getAllAssets().then((_) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Text("My Assets", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: AssetController.assetList.length,
        itemBuilder: (context, index) {
          final asset = AssetController.assetList[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 2,
            child: ListTile(
              title: Text(asset["name"] ?? "", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple[300])),
              subtitle: Text("Type: ${asset["type"]}\nSerial: ${asset["serialNumber"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, color: asset["isAvailable"] == 1 ? Colors.green : Colors.red, size: 16),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.purple),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddAssetScreen(
                            isEdit: true,
                            id: asset["id"],
                            type: asset["type"],
                            name: asset["name"],
                            description: asset["description"],
                            serialNumber: asset["serialNumber"],
                            isAvailable: asset["isAvailable"] == 1,
                          ),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.purple),
                    onPressed: () async {
                      await AssetController.deleteAsset(asset["id"]);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[300],
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAssetScreen()),
          );
          setState(() {});
        },
      ),
    );
  }
}
