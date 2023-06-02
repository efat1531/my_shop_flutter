import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  UserProductItem({
    required this.title,
    required this.imageURL,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
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
              onPressed: () async {
                try {
                  Provider.of<ProductProvider>(context, listen: false)
                      .removeProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text('Delete item failed'),
                    ),
                  );
                }
              },
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
