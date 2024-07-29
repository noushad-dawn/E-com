import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/const/styles.dart';
import 'package:ecom/controllers/address_provider.dart';
import 'package:ecom/views/screens/bottom.dart';
import 'package:ecom/controllers/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatefulWidget {
  final price;
  AddressListScreen({super.key, @required this.price});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  List monthList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nav",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Address",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  InkWell(
                    onTap: () {
                      _showAddAddressDialog(context);
                    },
                    child: const Text(
                      "Add New",
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<AddressProvider>(
              builder: (context, addressProvider, child) {
                return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.35,
                    ),
                    child: ListView.builder(
                      itemCount: addressProvider.addresses.length,
                      itemBuilder: (context, index) {
                        final address = addressProvider.addresses[index];
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              address.title,
                              style: const TextStyle(fontSize: 17),
                            ),
                            subtitle: Text(address.address),
                            leading: Radio<int>(
                              value: index,
                              groupValue: addressProvider.selectedAddressIndex,
                              onChanged: (int? value) {
                                addressProvider.selectAddress(value!);
                              },
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: secondColor,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: primaryColor,
                                ),
                                onPressed: () =>
                                    addressProvider.removeAddress(index),
                              ),
                            ),
                          ),
                        );
                      },
                    ));
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Payment",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: thirdColor,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: imageFromFirebase('master.png'),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: primaryColor,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          const ListTile(
                            leading: Icon(Icons.credit_card),
                            title: Text("MaterCard"),
                            subtitle: Text('**** **** **** 9646'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                        children: [
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.green.shade100),
                            child: CachedNetworkImage(
                              imageUrl: imageFromFirebase('visa.png'),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: primaryColor,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          const ListTile(
                            leading: Icon(Icons.credit_card),
                            title: Text("VisaCard"),
                            subtitle: Text('**** **** **** 5327'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 120.0, // Adjust height as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Price',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '\$${widget.price}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<History>(context, listen: false).addItem(
                      widget.price,
                      DateTime.now().day.toString() +
                          monthList[DateTime.now().month]);
                  _sucess(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'Payment',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showAddAddressDialog(BuildContext context) {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return AlertDialog(
        backgroundColor: whiteColor,
        title: const Text(
          'Add',
          style: TextStyle(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        content: Wrap(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Title',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                height: size.height * 0.055,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Address',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                height: size.height * 0.055,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ]),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _addressController.text.isNotEmpty) {
                    Provider.of<AddressProvider>(context, listen: false)
                        .addAddress(
                            _titleController.text, _addressController.text);
                    _titleController.clear();
                    _addressController.clear();
                  }
                  Navigator.pop(context, true);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(primaryColor),
                  foregroundColor: MaterialStatePropertyAll(whiteColor),
                ),
                child: const Text('Add Address'),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _sucess(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: secondColor,
        content: Wrap(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: CachedNetworkImage(
                    imageUrl: imageFromFirebase('check.png'),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: primaryColor,
                    ),
                  ),
                ),
                const Text(
                  "Order Sucessfully",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Your order #78457445 is Sucessfully\nplaced',
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    myIndex = 2;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                    );
                  },
                  child: const Text(
                    "Track My Order",
                    style: TextStyle(color: whiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    "Go back",
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
