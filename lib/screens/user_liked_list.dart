import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:armyshop_mobile_frontend/screens/product_detail.dart';
import 'package:flutter/material.dart';

class UserLikedList extends StatefulWidget {
  static const routeName = '/user-liked-list-screen';

  const UserLikedList({super.key});

  @override
  UserLikedListState createState() => UserLikedListState();
}

class UserLikedListState extends State<UserLikedList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.0),
        Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 50.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 0.8,
              children: <Widget>[
                _buildCard('AK 47 flkjdsdfj fldj fdsfj', '\$3.99',
                    'assets/images/army-bg1.jpg', context),
                _buildCard(
                    'AK 47', '\$5.99', 'assets/images/army-bg2.jpg', context),
                _buildCard(
                    'AK 47', '\$1.99', 'assets/images/army-bg3.jpg', context),
                _buildCard(
                    'AK 47', '\$2.99', 'assets/images/army-bg4.jpg', context)
              ],
            ),
          ),
        ),
        SizedBox(height: 15.0)
      ],
    );
  }

  Widget _buildCard(
      String name, String price, String image, BuildContext context) {
    // set the height of the card
    double deviceWidth = MediaQuery.of(context).size.width;
    double cardHeight;
    if (deviceWidth < 600) {
      cardHeight = MediaQuery.of(context).size.height * 0.16;
    } else if (deviceWidth < 1000) {
      cardHeight = MediaQuery.of(context).size.height * 0.24;
    } else {
      cardHeight = MediaQuery.of(context).size.height * 0.40;
    }

    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigate to the product detail page
                  Navigator.of(context).pushNamed(ProductPage.routeName);
                },
                child: Container(
                  height: cardHeight,
                  width: double.infinity,
                  child: Hero(
                    tag: image,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2.0),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            price,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.shopping_basket,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  Container(
                    height: 25.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your button press logic here
                        },
                        child: const Text('Order'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ArmyshopColors.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
