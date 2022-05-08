import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile(this.name, this.bio, {Key? key}) : super(key: key);
  final String name;
  final String bio;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final String? uid = FirebaseAuth.instance.currentUser?.uid.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff99879D),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Back",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.name,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.bio,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      // .collection('info')
                      .update({
                       'fullName': _nameController.text,
                          'bio': _bioController.text,
                        });
                } catch (e) {
                  print(e);
                }
                Navigator.pop(context);
              },
              child: const Text('Update Profile'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
