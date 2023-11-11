import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final Product? product;

  const ProductDescriptionScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${product?.name} Description',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(10, 10),
                  ),
                ],
              ),
              padding: EdgeInsets.all(
                16.r,
              ),
              child: Image.asset(
                product?.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.name ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ).paddingV(
                  v: 16.h,
                ),
                Text(
                  product?.shortDescription ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16.0),
                Text(
                  product?.fullDescription ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '\$${product?.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            //addToCart(product);
                          },
                          icon: const Icon(Icons.add),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToCart();
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void addToCart(Product product) {}

  void navigateToCart() {}
}

class ShoppingCartScreen extends StatelessWidget {
  final List<Product> cartItems;

  const ShoppingCartScreen(this.cartItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          Product product = cartItems[index];

          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                removeFromCart(product);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add checkout logic here
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  void removeFromCart(Product product) {
    // Remove the product from the cart
    // You can add any additional logic here, such as updating the total price.
  }
}
