import 'package:ecommerce_flutter_laravel/services/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPreferences preferences;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getWishlistData();
  }

  void getWishlistData() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    Provider.of<Wishlist>(context, listen: false).getWishlist(token);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // String? token = preferences1.getString('token');
    // final getWishlistProvider = Provider.of<Wishlist>(context);
    // getWishlistProvider.getWishlist(token);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 35.0, top: 20.0),
              child: Container(
                width: 65.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: Offset(4, 8), // Shadow position
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // Handle button tap
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                        ),
                        SizedBox(width: 9),
                        Text(
                          '1',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          elevation: 0.0,
          scrolledUnderElevation: 1.0,
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Favorite',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  Color(0xffFFB100),
                  Color(0xffEEAE1C),
                  Color(0xffF5A64F),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Consumer<Wishlist>(
        // Wrap the ListView.builder with Consumer
        builder: (context, wishlist, child) {
          // Use the wishlist data to build the ListView
          return ListView.builder(
            itemCount: wishlist.wishlists.length,
            itemBuilder: (context, index) {
              final item = wishlist.wishlists[index];
              // Build your list item here using the item data
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  isThreeLine: true,
                  leading: Image.network(
                    item['products']['image'],
                    height: MediaQuery.of(context).size.height / 3.0,
                  ),
                  title: Text(
                    "${item['products']['name']}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  subtitle: Text(
                    "${item['products']['description']}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
                  ),
                  // Add more widgets to display other information
                ),
              );
            },
          );
        },
      ),
    );
  }
}
