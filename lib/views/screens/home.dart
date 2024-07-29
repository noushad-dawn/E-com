import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:ecom/const/styles.dart';
import 'package:ecom/views/pages/cart_details.dart';
import 'package:ecom/views/screens/product.dart';
import 'package:ecom/models/category.dart';
import 'package:ecom/models/vegetables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('vegetables');
  final DatabaseReference _dbRef2 =
      FirebaseDatabase.instance.ref().child('categories');

  List<Vegetable> vegetables = [];
  List<Categorie> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchVegetables();
  }

  void _fetchVegetables() {
    _dbRef.onValue.listen((event) {
      final List<Vegetable> loadedVegetables = [];

      final data = event.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        final vegetable = Vegetable.fromJson(Map<String, dynamic>.from(value));
        loadedVegetables.add(vegetable);
      });
      setState(() {
        vegetables = loadedVegetables;
      });
    });

    _dbRef2.onValue.listen((event) {
      final List<Categorie> loadedCategories = [];

      final data = event.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        final category = Categorie.fromJson(Map<String, dynamic>.from(value));
        loadedCategories.add(category);
      });
      setState(() {
        categories = loadedCategories;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bodyColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 4,
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 30, bottom: 5),
              decoration: const BoxDecoration(
                color: primaryColor,
                image: DecorationImage(
                  opacity: 0.1,
                  image: AssetImage('assets/images/green.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 22,
                                color: thirdColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: thirdColor,
                                ),
                              ),
                            ],
                          ),
                          _iconwidget(Icons.shopping_cart, 25),
                        ],
                      ),
                      const Text(
                        "Santoshi, Raipur",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        suffixIconColor: primaryColor,
                        focusColor: whiteColor,
                        filled: true,
                        hintText: "  Search Your Groceries",
                        hintStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: whiteColor),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: whiteColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: whiteColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: imageFromFirebase(
                                      'image${index + 1}.png'),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: primaryColor,
                                  ),
                                  fit: BoxFit.cover,
                                  height: 160,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                      itemCount: 3,
                      viewportFraction: 1,
                      scale: 1,
                      allowImplicitScrolling: true,
                      autoplay: true,
                      controller: SwiperController(),
                      pagination: const SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          activeColor: primaryColor,
                          space: 4,
                          activeSize: 12,
                          color: thirdColor,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: blackColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 75,
                          height: 100,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundColor: secondColor,
                                child: Container(
                                  height: 45,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: CachedNetworkImage(
                                      imageUrl: categories[index].imageUrl,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                radius: 32,
                              ),
                              Text(
                                "${categories[index].name}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Text(
                      "Popular",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: blackColor),
                    ),
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.8),
                    itemCount: vegetables.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final vegetable = vegetables[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Details(vegetable: vegetable),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 2,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 5, left: 5, right: 5),
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: secondColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18),
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: vegetable.imageUrl,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(
                                          color: primaryColor,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      right: 15,
                                      top: 15,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: thirdColor,
                                        foregroundColor: primaryColor,
                                        child: Icon(
                                          Icons.favorite_outline,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: size.width / 2.5,
                                            child: Text(
                                              '${vegetable.name}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          RatingBar.builder(
                                            initialRating: 4,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 1.0,
                                            ),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: ratingColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              // print(rating);
                                            },
                                            itemSize: 15,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "\$${vegetable.price}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "/KG",
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(20))),
                                        child: IconButton(
                                          color: whiteColor,
                                          onPressed: () {},
                                          icon: const Icon(Icons.add),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
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
      ),
    );
  }

  CircleAvatar _iconwidget(IconData icon, double size) {
    return CircleAvatar(
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductListScreen(),
            ),
          );
        },
        icon: Icon(
          icon,
          size: size,
        ),
      ),
      foregroundColor: secondColor,
      backgroundColor: const Color.fromARGB(37, 255, 255, 255),
    );
  }
}
