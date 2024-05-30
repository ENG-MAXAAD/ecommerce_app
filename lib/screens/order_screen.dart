import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

// import 'package:shop_example/models/cart_item.dart';
// import 'package:shop_example/widgets/cart_tile.dart';
// import 'package:shop_example/widgets/check_out_box.dart';

import '../components/cart_tile.dart';
// import '../components/check_out_box.dart';
import '../components/checkBox.dart';
import '../utils/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getCartItems();
  }

  // var overTotal = 0;

  int sumOverAllTotal(List<Cart> data) {
    var total = 0;
    print("the data $data");
    data.forEach((value) {
      total += value.price;
    });
    return total;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            icon: const Icon(Ionicons.chevron_back),
          ),
        ),
      ),
      bottomSheet: CheckOutBox(
          overAllTotal: sumOverAllTotal(
              Provider.of<CartProvider>(context, listen: false).cartData)),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) => CartTile(
          onDelete: () {
            Provider.of<CartProvider>(context, listen: false)
                .deleteCartItem(index);
            Provider.of<CartProvider>(context, listen: false).getCartItems();
            setState(() {});
          },
          onRemove: () {
            Cart data = Provider.of<CartProvider>(context, listen: false)
                .cartData[index];
            if (data.quantity <= 1) return;
            setState(() {
              data.quantity--;
              data.price = data.originalPrice * data.quantity;
              sumOverAllTotal(
                  Provider.of<CartProvider>(context, listen: false).cartData);
              // print(overTotal);
            });
          },
          onAdd: () {
            Cart data = Provider.of<CartProvider>(context, listen: false)
                .cartData[index];
            setState(() {
              data.quantity++;
              data.price = data.originalPrice * data.quantity;
              sumOverAllTotal(
                  Provider.of<CartProvider>(context, listen: false).cartData);
              // print(overTotal);
            });
          },
          cartData:
              Provider.of<CartProvider>(context, listen: false).cartData[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount:
            Provider.of<CartProvider>(context, listen: false).cartData.length,
      ),
    );
  }
}
