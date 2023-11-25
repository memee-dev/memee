import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/app_button.dart';
import 'package:memee/ui/cart/cart_address_widget.dart';

class ShoppingCartScreen extends StatelessWidget {
  final List<ProductModel> cartItems;

  const ShoppingCartScreen(this.cartItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  12.r,
                ),
                bottomRight: Radius.circular(
                  12.r,
                ),
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const CartAddressWidget(),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12.r,
                          ),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      padding: EdgeInsets.all(
                        8.r,
                      ),
                      child: Image.asset(
                        'cartItems[index].imageUrl',
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      cartItems[index].name,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity: 1',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).paddingV(
                          v: 4.h,
                        ),
                        // Text(
                        //   'Price: \$${cartItems[index].price}',
                        //   style: Theme.of(context).textTheme.bodyLarge,
                        // ).gapBottom(
                        //   4.h,
                        // ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            //_removeItem(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            //_addItem(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).paddingS(
              h: 16.w,
              v: 16.h,
            ),
          ),
          AppButton(
            label: 'Pay now',
            onTap: () {},
          ).paddingS(
            h: 16.w,
            v: 16.h,
          ),
        ],
      ),
    );
  }

  void removeFromCart(ProductModel product) {
    // Remove the product from the cart
    // You can add any additional logic here, such as updating the total price.
  }
}
