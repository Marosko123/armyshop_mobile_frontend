import 'package:armyshop_mobile_frontend/screens/products_screen.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/user-home-screen';

  const UserHome({super.key});

  @override
  UserHomeState createState() => UserHomeState();
}

class UserHomeState extends State<UserHome> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      print('here');
      _isFavorite = !_isFavorite;
    });
  }

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
                _buildCard(
                    'AK 47', '\$3.99', 'assets/images/army-bg1.jpg', context),
                _buildCard(
                    'AK 47', '\$5.99', 'assets/images/army-bg1.jpg', context),
                _buildCard(
                    'AK 47', '\$1.99', 'assets/images/army-bg1.jpg', context),
                _buildCard(
                    'AK 47', '\$2.99', 'assets/images/army-bg1.jpg', context)
              ],
            ),
          ),
        ),
        SizedBox(height: 15.0)
      ],
    );
  }

  Widget _buildCard(
      String name, String price, String imagePath, BuildContext context) {
    bool _isFavorite = false;

    void _toggleFavorite() {
      setState(() {
        _isFavorite = !_isFavorite;
      });
    }

    return Card(
      child: InkWell(
        onTap: () => {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Image.asset(
                  imagePath,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Ink(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: _isFavorite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    color: Colors.white,
                    onPressed: _toggleFavorite,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildCard(
  //     String name, String price, String imagePath, BuildContext context) {
  //   bool _isFavorite = false;

  //   void _toggleFavorite() {
  //     setState(() {
  //       _isFavorite = !_isFavorite;
  //     });
  //   }

  //   return Card(
  //     child: InkWell(
  //       onTap: () => {},
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: <Widget>[
  //           Stack(
  //             alignment: Alignment.bottomRight,
  //             children: <Widget>[
  //               Image.asset(
  //                 imagePath,
  //                 height: 150,
  //                 width: double.infinity,
  //                 fit: BoxFit.cover,
  //               ),
  //               Ink(
  //                 decoration: BoxDecoration(
  //                   color: Colors.red,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: IconButton(
  //                   icon: _isFavorite
  //                       ? Icon(Icons.favorite)
  //                       : Icon(Icons.favorite_border),
  //                   color: Colors.white,
  //                   onPressed: _toggleFavorite,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Padding(
  //             padding: EdgeInsets.all(8),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   name,
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 SizedBox(height: 8),
  //                 Text(
  //                   price,
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: Colors.grey[600],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
