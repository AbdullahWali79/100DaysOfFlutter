import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tradding_app/User%20With%20Login%20Panel/loginscreen.dart';

void main() {
  runApp(MaterialApp(
    home: ShowCryptoScreen(),
  ));
}

class ApiModel {
  final String name;
  final String symbol;
  final String image;
  final double currentPrice;
  final double? priceChangePercentage24h;

  ApiModel({
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      name: json['name'],
      symbol: json['symbol'],
      image: json['image'],
      currentPrice: json['current_price'].toDouble(),
      priceChangePercentage24h: json['price_change_percentage_24h'],
    );
  }
}

class ShowCryptoScreen extends StatefulWidget {
  const ShowCryptoScreen({Key? key}) : super(key: key);

  @override
  State<ShowCryptoScreen> createState() => _ShowCryptoScreenState();
}

class _ShowCryptoScreenState extends State<ShowCryptoScreen> {
  TextEditingController searchController = TextEditingController();
  List<ApiModel> postList = [];
  List<ApiModel> filteredList = [];
  List<ApiModel> watchlist = [];

  Future<List<ApiModel>> getApi() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data is List) {
        postList = data.map((coinData) => ApiModel.fromJson(coinData)).toList();
        return postList;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  void addToWatchlist(ApiModel coin) {
    setState(() {
      watchlist.add(coin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Cap'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle,size: 30.0),
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (query) {
                setState(() {
                  filteredList = postList
                      .where((coin) =>
                  coin.name!.toLowerCase().contains(query.toLowerCase()) ||
                      coin.symbol!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search by Coin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    );
                  } else if(!snapshot.hasData) {
    return Center(
    child: Text('Error loading data'),
    );}
    else{
                    return ListView.builder(
                      itemCount: filteredList.isEmpty ? postList.length : filteredList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final coin = filteredList.isEmpty ? postList[index] : filteredList[index];
                        return ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CoinDetailScreen(coin: coin),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              child: Image.network(coin.image.toString()),
                            ),
                          ),
                          title: Text(coin.name.toString()),
                          subtitle: Text("${coin.priceChangePercentage24h?.toStringAsFixed(3)}%"),
                          trailing: Column(
                            children: [
                              Text('\$${coin.currentPrice.toString()}'),
                              SizedBox(height: 5),
                              Text(coin.symbol.toString().toUpperCase()),
                            ],
                          ),
                          onTap: () {
                            // Handle tap on coin (e.g., navigate to coin details)
                            // You can customize this based on your app's requirements
                          },
                          onLongPress: () {
                            addToWatchlist(coin);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculate',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WatchlistScreen(watchlist: watchlist)),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculateScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}

class WatchlistScreen extends StatelessWidget {
  final List<ApiModel> watchlist;

  WatchlistScreen({required this.watchlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: ListView.builder(
        itemCount: watchlist.length,
        itemBuilder: (BuildContext context, int index) {
          final coin = watchlist[index];
          return ListTile(
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoinDetailScreen(coin: coin),
                  ),
                );
              },
              child: CircleAvatar(
                child: Image.network(coin.image.toString()),
              ),
            ),
            title: Text(coin.name.toString()),
            subtitle: Text("${coin.priceChangePercentage24h?.toStringAsFixed(3)}%"),
            trailing: Column(
              children: [
                Text('\$${coin.currentPrice.toString()}'),
                SizedBox(height: 5),
                Text(coin.symbol.toString().toUpperCase()),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CoinDetailScreen extends StatelessWidget {
  final ApiModel coin;

  CoinDetailScreen({required this.coin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coin.name),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(coin.image),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}

class CalculateScreen extends StatefulWidget {
  @override
  _CalculateScreenState createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  TextEditingController buyingPriceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController investmentFeesController = TextEditingController();
  double profit = 0.0;

  void calculateProfit() {
    double buyingPrice = double.tryParse(buyingPriceController.text) ?? 0.0;
    double sellingPrice = double.tryParse(sellingPriceController.text) ?? 0.0;
    double investmentFees = double.tryParse(investmentFeesController.text) ?? 0.0;

    setState(() {
      profit = (sellingPrice - buyingPrice) - investmentFees;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate Profit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: buyingPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Buying Price in \$'),
            ),
            TextField(
              controller: sellingPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Selling Price in \$'),
            ),
            TextField(
              controller: investmentFeesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Investment Fees in \$'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                calculateProfit();
              },
              child: Container(child: Center(child: Text('Calculate Profit'))),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'Profit: \$${profit.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
