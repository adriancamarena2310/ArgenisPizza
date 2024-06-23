import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadCoffee() async {
    if (_image != null) {
      String fileName = _image!.path.split('/').last;
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('coffees').add({
        'name': nameController.text,
        'price': double.parse(priceController.text),
        'image': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coffee uploaded successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image')));
    }
  }

  Future<void> _deleteCoffee(String documentId) async {
    await FirebaseFirestore.instance.collection('coffees').doc(documentId).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coffee deleted successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Coffee Name'),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!, height: 150),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _uploadCoffee,
              child: Text('Upload Coffee'),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('coffees').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot coffee = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(coffee['name']),
                        subtitle: Text('\$${coffee['price']}'),
                        leading: Image.network(coffee['image'], width: 50, height: 50),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteCoffee(coffee.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
