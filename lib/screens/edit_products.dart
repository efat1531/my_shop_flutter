import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Product_model_provider.dart';
import '../provider/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/products/edit_products';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  bool isLoading = false;
  var _newProduct = Product(
    id: '',
    title: '',
    description: '',
    imageUrl: '',
    price: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocus.dispose();
    _descriptionFocusNode.dispose();
    _imageURLController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveProduct() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<ProductProvider>(context, listen: false)
          .add_item(_newProduct);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('An exception occured!'),
          content: const Text(
              'Sorry something went wrong.Please press okey to close'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okey'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [
          IconButton(
            onPressed: _saveProduct,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (newValue) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: newValue as String,
                          description: _newProduct.description,
                          imageUrl: _newProduct.imageUrl,
                          price: _newProduct.price,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please add a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocus,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (newValue) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          description: _newProduct.description,
                          imageUrl: _newProduct.imageUrl,
                          price: int.parse(newValue as String),
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please add amount of the product';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                      },
                      focusNode: _descriptionFocusNode,
                      onSaved: (newValue) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          description: newValue as String,
                          imageUrl: _newProduct.imageUrl,
                          price: _newProduct.price,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please add description of the product';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageURLController.text.isEmpty
                              ? const Text('Enter a URL')
                              : Image.network(
                                  _imageURLController.text,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageURLController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (value) {
                              _saveProduct();
                            },
                            onSaved: (newValue) {
                              _newProduct = Product(
                                id: _newProduct.id,
                                title: _newProduct.title,
                                description: _newProduct.description,
                                imageUrl: newValue as String,
                                price: _newProduct.price,
                              );
                            },
                            validator: (value) {
                              if (value!.isEmpty) return 'Please enter a URL';
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Enter a valid URL';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
