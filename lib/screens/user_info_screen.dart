import 'package:flutter/material.dart';




class UserInfoScreen extends StatelessWidget {
  final String title;
  final String imageUrl;

  const UserInfoScreen({Key? key, required this.imageUrl,  required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Icon(Icons.person),
        ),
        title: const Text('User'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, size: 30),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
                const SizedBox(height: 8),
                imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : const Text('Photo not available'),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}