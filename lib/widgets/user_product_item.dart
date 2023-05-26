import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageURL;
  UserProductItem({
    required this.title,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              color: Colors.orange[700],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_outline,
                color: Colors.redAccent[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
