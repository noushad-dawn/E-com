import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/const/styles.dart';
import 'package:ecom/views/pages/address_list_screen.dart';
import 'package:ecom/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('You want to Delete?'),
                      actions: [
                        GestureDetector(
                            onTap: () {
                              cart.clearCart();
                              Navigator.pop(context);
                            },
                            child: Text("Yes"))
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.delete,
                color: whiteColor,
              ))
        ],
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: cart.items.isEmpty
          ? Center(
              child: CachedNetworkImage(
                imageUrl: imageFromFirebase('cart.png'),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: primaryColor,
                ),
                height: 350,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cart.items[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text(
                                    "Would you like to Buy or Delete!!!"),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cart.removeItem(cartItem.vegetable);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddressListScreen(
                                                      price: cartItem
                                                              .vegetable.price *
                                                          cartItem.quantity),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Buy",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Card(
                          color: whiteColor,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3, vertical: 6),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: secondColor,
                                        ),
                                        child: Image(
                                          height: size.width * 0.15,
                                          width: size.width * 0.15,
                                          image: NetworkImage(
                                              cartItem.vegetable.imageUrl),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: size.width * 0.3,
                                            child: Text(
                                              '${cartItem.vegetable.name}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          const Text(
                                            'vegetable',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '\$${cartItem.vegetable.price}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Text(
                                                '/KG',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: const Color.fromRGBO(
                                            226, 226, 226, 1),
                                        child: IconButton(
                                          icon: const Icon(
                                            size: 15,
                                            Icons.remove,
                                            color: blackColor,
                                          ),
                                          onPressed: () {
                                            if (cartItem.quantity > 1) {
                                              setState(() {
                                                cartItem.quantity -= 1;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('${cartItem.quantity} KG'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: primaryColor,
                                        child: IconButton(
                                          icon: const Icon(
                                            size: 15,
                                            Icons.add,
                                            color: whiteColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              cartItem.quantity += 1;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 85,
                  decoration: const BoxDecoration(color: whiteColor),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              '${cart.totalAmount.toString()}',
                              style: const TextStyle(
                                  color: primaryColor, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      CupertinoButton(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(40),
                        child: const Text('Checkout'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressListScreen(
                                price: cart.totalAmount,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
