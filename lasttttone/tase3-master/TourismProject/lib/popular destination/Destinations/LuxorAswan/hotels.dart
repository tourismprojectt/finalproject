import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../hotel.dart';

List<Hotel> luxorAswanHotels = [
  Hotel(
      name:"Hilton Luxor Resort & Spa",
      imagePaths:[
        'images/luxorandaswanhotels/hilt1.jpg',
        'images/luxorandaswanhotels/hilt2.jpg',
        'images/luxorandaswanhotels/hilt3.jpg',
        'images/luxorandaswanhotels/hilt4.jpg',
      ],
      description:"Hilton Luxor: Unrivaled luxury amidst ancient wonders.",
      price:0,
      url:"https://www.hilton.com/en/hotels/luxhitw-hilton-luxor-resort-and-spa/hotel-info/",
      isFavorite:false),
  Hotel(
      name:"Jewel Howard Carter Hotel",
     imagePaths: [
        'images/luxorandaswanhotels/jewel1.jpg',
        'images/luxorandaswanhotels/jewel2.jpg',
        'images/luxorandaswanhotels/jewel3.jpg',
        'images/luxorandaswanhotels/jewel4.jpg',
      ],
      description:"Jewel Howard: Monrovia's epitome of elegance and luxury.",
      price: 0,
      url:"https://www.tripadvisor.com/Hotel_Review-g294205-d12689152-Reviews-Jewel_Howard_Carter_Hotel-Luxor_Nile_River_Valley.html",
      isFavorite: false),
  Hotel(
      name:'New Memnon Hotel',
     imagePaths: [
        'images/luxorandaswanhotels/menmon1.jpg',
        'images/luxorandaswanhotels/menmon2.jpg',
        'images/luxorandaswanhotels/menmon3.jpg',
        'images/luxorandaswanhotels/menmon4.jpg',
      ],
      description:"Menmon Hotel: Your cozy urban retreat in the heart of the city.",
      price:0,
       url:"https://www.tripadvisor.com/Hotel_Review-g294205-d2501752-Reviews-New_Memnon_Hotel-Luxor_Nile_River_Valley.html",
      isFavorite:false),
  Hotel(
      name:'Sonesta St. George Hotel',
     imagePaths: [
        'images/luxorandaswanhotels/sonesta1.jpg',
        'images/luxorandaswanhotels/sonesta2.jpg',
        'images/luxorandaswanhotels/sonesta3.jpg',
        'images/luxorandaswanhotels/sonesta4.jpg',
      ],
       description:"Sonesta Hotel: Modern elegance and warm hospitality await at our cozy urban retreat.",
      price: 0,
      url: "https://www.sonesta.com/sonesta-hotels-resorts/egy/luxor/sonesta-st-george-hotel-luxor",
      isFavorite:false),
  Hotel(
      name:'Steigenberger Nile Palace',
      imagePaths:[
        'images/luxorandaswanhotels/stein1.jpg',
        'images/luxorandaswanhotels/stein2.jpg',
        'images/luxorandaswanhotels/stein3.jpg',
        'images/luxorandaswanhotels/stein4.jpg',
      ],
      description:"Steigenburger Nile Hotel: Luxurious Nile-side charm awaits at our tranquil retreat.",
      price: 0,
     url: "https://hrewards.com/en/steigenberger-nile-palace-luxor",
      isFavorite:false),

  Hotel(
     name: "Obelisk Nile Hotel",
      imagePaths:[
        'images/luxorandaswanhotels/ob1.jpg',
        'images/luxorandaswanhotels/ob2.jpg',
        'images/luxorandaswanhotels/ob3.jpg',
        'images/luxorandaswanhotels/ob4.jpg',
      ],
      description:"Obelisk Hotel: Where history and luxury converge, promising an unforgettable stay in the heart of the city.",
      price:0,
     url: "https://obeliskhotels.com/",
      isFavorite:false),
  Hotel(
     name: "Movenpick aswan",
      imagePaths:[
        'images/luxorandaswanhotels/moven11.jpg',
        'images/luxorandaswanhotels/moven2.jpg',
        'images/luxorandaswanhotels/moven3.jpg',
        'images/luxorandaswanhotels/moven4.jpg',
      ],
      description:"Mövenpick: Swiss hospitality, exotic charm, and unmatched comfort.",
      price:0,
     url: "https://movenpick.accor.com/ar/africa/egypt/aswan/resort-aswan.html",
      isFavorite:false),
  Hotel(
     name: 'Sofitel Legend',
     imagePaths: [
        'images/luxorandaswanhotels/sof1.jpg',
        'images/luxorandaswanhotels/sof2.jpg',
        'images/luxorandaswanhotels/sof3.jpg',
        'images/luxorandaswanhotels/sof4.jpg',
      ],
      description:"Sofitel Hotel: A harmonious blend of sophistication and comfort awaits at our urban oasis.",
      price:0,
     url: "https://all.accor.com/hotel/1666/index.en.shtml",
      isFavorite:false),
  Hotel(
      name:'Benben by Dhara hotel',
     imagePaths: [
        'images/luxorandaswanhotels/ben1.jpg',
        'images/luxorandaswanhotels/ben2.jpg',
        'images/luxorandaswanhotels/ben3.jpg',
        'images/luxorandaswanhotels/ben4.jpg',
      ],
      description:"Benben by Dhara Hotel: Urban elegance and warm hospitality await your arrival.",
     price: 0,
     url: "https://dharahotels.com/",
    isFavorite:  false),
  Hotel(
      name:'Pyramisa aswan hotel',
      imagePaths:[
        'images/luxorandaswanhotels/py1.jpg',
        'images/luxorandaswanhotels/py2.jpg',
        'images/luxorandaswanhotels/py3.jpg',
        'images/luxorandaswanhotels/py4.jpg',
      ],
     description: "Pyramisa Hotel: Your cozy urban retreat awaits.",
     price: 0,
     url: "https://www.pyramisahotels.com/isis-island-aswan-home",
     isFavorite: false),
  // Add more hotels here
];

class ScreenOne extends StatefulWidget {
  ScreenOne({Key? key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userId;
  String? _firestoreUserId;
  List<Hotel> favoriteHotels = [];
  List<int> activeIndices = List.filled(luxorAswanHotels.length, 0);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getHotelPrices();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _userId = user?.uid;
        if (_userId != null) {
          getFirestoreUserId(_userId!);
        }
      });
    });
  }

  void getFirestoreUserId(String uid) async {
    try {
      DocumentSnapshot docSnapshot =
          await FirebaseFirestore.instance.collection('Usere').doc(uid).get();
      if (docSnapshot.exists) {
        setState(() {
          _firestoreUserId =
              docSnapshot.get('userId') as String?; // Safe cast to String?
        });
      } else {
        print('User document does not exist in Firestore');
      }
    } catch (e) {
      print('Error getting user ID from Firestore: $e');
    }
  }

  void toggleFavoriteStatus(int index) async {
    if (_firestoreUserId == null)
      return; // Cannot proceed without a Firestore user ID

    final hotel =
        luxorAswanHotels[index]; // Use alexHotels instead of cairoHotels
    final hotelRef =
        FirebaseFirestore.instance.collection('Hotels').doc(hotel.name);
    final userFavoritesRef = FirebaseFirestore.instance
        .collection('Usere')
        .doc(_firestoreUserId!)
        .collection('favorites');

    // Update the isFavorite field in the hotel document
    await hotelRef.update({'isFavorite': !hotel.isFavorite});

    // Add or remove the hotel from the user's favorites sub-collection
    if (!hotel.isFavorite) {
      // Add to favorites
      await userFavoritesRef.doc(hotel.name).set({
        'name': hotel.name,
        // Add any other relevant data you want to store
      });
    } else {
      // Remove from favorites
      await userFavoritesRef.doc(hotel.name).delete();
    }

    // Update the local state to reflect the change
    setState(() {
      luxorAswanHotels[index].isFavorite = !luxorAswanHotels[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> getHotelPrices() async {
    for (int i = 0; i < luxorAswanHotels.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(luxorAswanHotels[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        bool isFavorite =
            document.get('isFavourite'); // Get isFavorite value from Firestore
        luxorAswanHotels[i] = Hotel(
          name: luxorAswanHotels[i].name,
          imagePaths: luxorAswanHotels[i].imagePaths,
          description: luxorAswanHotels[i].description,
          price: price,
          url: luxorAswanHotels[i].url,
          isFavorite: isFavorite,
        );
        if (price == 0) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Document does not exist');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Luxor And Aswan',
          style: TextStyle(
            fontFamily: 'MadimiOne',
            color: Color.fromARGB(255, 121, 155, 228),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 121, 155, 228),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdRoute()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Text(
              'Hotels',
              style: TextStyle(
                fontFamily: 'MadimiOne',
                color: Color.fromARGB(255, 121, 155, 230),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < luxorAswanHotels.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: luxorAswanHotels[i]
                      .imagePaths
                      .map((imagePath) => Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 180,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndices[i] = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                buildIndicator(
                    activeIndices[i], luxorAswanHotels[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        luxorAswanHotels[i].name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MadimiOne',
                          color: Color.fromARGB(255, 83, 137, 182),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 5, 59, 107),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          toggleFavoriteStatus(i);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(luxorAswanHotels[i].isFavorite
                                  ? 'Added to Favorites!'
                                  : 'Removed from Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          luxorAswanHotels[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to Trip!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _launchURL(luxorAswanHotels[i]
                              .url); // Launch URL when tapped
                        },
                        child: Icon(
                          Icons.link,
                          color: Colors.blue, // Use blue color for link icon
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    luxorAswanHotels[i].description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 36, 108, 163),
                      fontFamily: 'MadimiOne',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (isLoading)
                        CircularProgressIndicator(), // Show loading icon
                      if (!isLoading && luxorAswanHotels[i].price != 0)
                        Text(
                          luxorAswanHotels[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && luxorAswanHotels[i].price != 0)
                        SizedBox(width: 8),
                      if (!isLoading && luxorAswanHotels[i].price != 0)
                        Text(
                          "EGP",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildIndicator(int activeIndex, int length) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: length,
        effect: WormEffect(
          dotWidth: 18,
          dotHeight: 18,
          activeDotColor: Colors.blue,
          dotColor: Color.fromARGB(255, 16, 65, 106),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
