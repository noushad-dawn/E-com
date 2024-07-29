import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/const/styles.dart';
import 'package:ecom/controllers/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PaymentHistoryPage extends StatefulWidget {
  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final cartHistory = Provider.of<History>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
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
                              cartHistory.clearHistory();
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
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
      ),
      body: cartHistory.items.isEmpty
          ? Center(
              child: CachedNetworkImage(
                imageUrl: imageFromFirebase('history.png'),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: primaryColor,
                ),
                height: 350,
              ),
            )
          : ListView.builder(
              itemCount: cartHistory.items.length,
              itemBuilder: (context, index) {
                final history = cartHistory.items[index];
                return Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const CircleAvatar(
                            radius: 15,
                            foregroundColor: whiteColor,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.arrow_outward_outlined,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.20,
                                child: const Text(
                                  'Vegetables',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Text(
                                // 'Date: ${dateList[index]}',
                                'Date: ${history.date}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ]),
                        Text(
                          'Amount : \$${history.totalAmount}',
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Status: ${history.status ? 'Paid' : 'Unpaid'}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
