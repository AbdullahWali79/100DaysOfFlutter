import 'dart:convert';
/// id : "bitcoin"
/// symbol : "btc"
/// name : "Bitcoin"
/// image : "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"
/// current_price : 38935
/// market_cap : 762116900207
/// market_cap_rank : 1
/// fully_diluted_valuation : 816654361803
/// total_volume : 42246259954
/// high_24h : 42135
/// low_24h : 38061
/// price_change_24h : -3128.4650062049404
/// price_change_percentage_24h : -7.43755
/// market_cap_change_24h : -63125628384.971436
/// market_cap_change_percentage_24h : -7.64934
/// circulating_supply : 19597587
/// total_supply : 21000000
/// max_supply : 21000000
/// ath : 59717
/// ath_change_percentage : -34.86045
/// ath_date : "2021-11-10T14:24:11.849Z"
/// atl : 51.3
/// atl_change_percentage : 75729.40284
/// atl_date : "2013-07-05T00:00:00.000Z"
/// roi : null
/// last_updated : "2024-01-13T11:44:03.520Z"

ApiModel apiModelFromJson(String str) => ApiModel.fromJson(json.decode(str));
String apiModelToJson(ApiModel data) => json.encode(data.toJson());
class ApiModel {
  ApiModel({
      String? id, 
      String? symbol, 
      String? name, 
      String? image, 
      num? currentPrice, 
      num? marketCap, 
      num? marketCapRank, 
      num? fullyDilutedValuation, 
      num? totalVolume, 
      num? high24h, 
      num? low24h, 
      num? priceChange24h, 
      num? priceChangePercentage24h, 
      num? marketCapChange24h, 
      num? marketCapChangePercentage24h, 
      num? circulatingSupply, 
      num? totalSupply, 
      num? maxSupply, 
      num? ath, 
      num? athChangePercentage, 
      String? athDate, 
      num? atl, 
      num? atlChangePercentage, 
      String? atlDate, 
      dynamic roi, 
      String? lastUpdated,}){
    _id = id;
    _symbol = symbol;
    _name = name;
    _image = image;
    _currentPrice = currentPrice;
    _marketCap = marketCap;
    _marketCapRank = marketCapRank;
    _fullyDilutedValuation = fullyDilutedValuation;
    _totalVolume = totalVolume;
    _high24h = high24h;
    _low24h = low24h;
    _priceChange24h = priceChange24h;
    _priceChangePercentage24h = priceChangePercentage24h;
    _marketCapChange24h = marketCapChange24h;
    _marketCapChangePercentage24h = marketCapChangePercentage24h;
    _circulatingSupply = circulatingSupply;
    _totalSupply = totalSupply;
    _maxSupply = maxSupply;
    _ath = ath;
    _athChangePercentage = athChangePercentage;
    _athDate = athDate;
    _atl = atl;
    _atlChangePercentage = atlChangePercentage;
    _atlDate = atlDate;
    _roi = roi;
    _lastUpdated = lastUpdated;
}

  ApiModel.fromJson(dynamic json) {
    _id = json['id'];
    _symbol = json['symbol'];
    _name = json['name'];
    _image = json['image'];
    _currentPrice = json['current_price'];
    _marketCap = json['market_cap'];
    _marketCapRank = json['market_cap_rank'];
    _fullyDilutedValuation = json['fully_diluted_valuation'];
    _totalVolume = json['total_volume'];
    _high24h = json['high_24h'];
    _low24h = json['low_24h'];
    _priceChange24h = json['price_change_24h'];
    _priceChangePercentage24h = json['price_change_percentage_24h'];
    _marketCapChange24h = json['market_cap_change_24h'];
    _marketCapChangePercentage24h = json['market_cap_change_percentage_24h'];
    _circulatingSupply = json['circulating_supply'];
    _totalSupply = json['total_supply'];
    _maxSupply = json['max_supply'];
    _ath = json['ath'];
    _athChangePercentage = json['ath_change_percentage'];
    _athDate = json['ath_date'];
    _atl = json['atl'];
    _atlChangePercentage = json['atl_change_percentage'];
    _atlDate = json['atl_date'];
    _roi = json['roi'];
    _lastUpdated = json['last_updated'];
  }
  String? _id;
  String? _symbol;
  String? _name;
  String? _image;
  num? _currentPrice;
  num? _marketCap;
  num? _marketCapRank;
  num? _fullyDilutedValuation;
  num? _totalVolume;
  num? _high24h;
  num? _low24h;
  num? _priceChange24h;
  num? _priceChangePercentage24h;
  num? _marketCapChange24h;
  num? _marketCapChangePercentage24h;
  num? _circulatingSupply;
  num? _totalSupply;
  num? _maxSupply;
  num? _ath;
  num? _athChangePercentage;
  String? _athDate;
  num? _atl;
  num? _atlChangePercentage;
  String? _atlDate;
  dynamic _roi;
  String? _lastUpdated;
ApiModel copyWith({  String? id,
  String? symbol,
  String? name,
  String? image,
  num? currentPrice,
  num? marketCap,
  num? marketCapRank,
  num? fullyDilutedValuation,
  num? totalVolume,
  num? high24h,
  num? low24h,
  num? priceChange24h,
  num? priceChangePercentage24h,
  num? marketCapChange24h,
  num? marketCapChangePercentage24h,
  num? circulatingSupply,
  num? totalSupply,
  num? maxSupply,
  num? ath,
  num? athChangePercentage,
  String? athDate,
  num? atl,
  num? atlChangePercentage,
  String? atlDate,
  dynamic roi,
  String? lastUpdated,
}) => ApiModel(  id: id ?? _id,
  symbol: symbol ?? _symbol,
  name: name ?? _name,
  image: image ?? _image,
  currentPrice: currentPrice ?? _currentPrice,
  marketCap: marketCap ?? _marketCap,
  marketCapRank: marketCapRank ?? _marketCapRank,
  fullyDilutedValuation: fullyDilutedValuation ?? _fullyDilutedValuation,
  totalVolume: totalVolume ?? _totalVolume,
  high24h: high24h ?? _high24h,
  low24h: low24h ?? _low24h,
  priceChange24h: priceChange24h ?? _priceChange24h,
  priceChangePercentage24h: priceChangePercentage24h ?? _priceChangePercentage24h,
  marketCapChange24h: marketCapChange24h ?? _marketCapChange24h,
  marketCapChangePercentage24h: marketCapChangePercentage24h ?? _marketCapChangePercentage24h,
  circulatingSupply: circulatingSupply ?? _circulatingSupply,
  totalSupply: totalSupply ?? _totalSupply,
  maxSupply: maxSupply ?? _maxSupply,
  ath: ath ?? _ath,
  athChangePercentage: athChangePercentage ?? _athChangePercentage,
  athDate: athDate ?? _athDate,
  atl: atl ?? _atl,
  atlChangePercentage: atlChangePercentage ?? _atlChangePercentage,
  atlDate: atlDate ?? _atlDate,
  roi: roi ?? _roi,
  lastUpdated: lastUpdated ?? _lastUpdated,
);
  String? get id => _id;
  String? get symbol => _symbol;
  String? get name => _name;
  String? get image => _image;
  num? get currentPrice => _currentPrice;
  num? get marketCap => _marketCap;
  num? get marketCapRank => _marketCapRank;
  num? get fullyDilutedValuation => _fullyDilutedValuation;
  num? get totalVolume => _totalVolume;
  num? get high24h => _high24h;
  num? get low24h => _low24h;
  num? get priceChange24h => _priceChange24h;
  num? get priceChangePercentage24h => _priceChangePercentage24h;
  num? get marketCapChange24h => _marketCapChange24h;
  num? get marketCapChangePercentage24h => _marketCapChangePercentage24h;
  num? get circulatingSupply => _circulatingSupply;
  num? get totalSupply => _totalSupply;
  num? get maxSupply => _maxSupply;
  num? get ath => _ath;
  num? get athChangePercentage => _athChangePercentage;
  String? get athDate => _athDate;
  num? get atl => _atl;
  num? get atlChangePercentage => _atlChangePercentage;
  String? get atlDate => _atlDate;
  dynamic get roi => _roi;
  String? get lastUpdated => _lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['symbol'] = _symbol;
    map['name'] = _name;
    map['image'] = _image;
    map['current_price'] = _currentPrice;
    map['market_cap'] = _marketCap;
    map['market_cap_rank'] = _marketCapRank;
    map['fully_diluted_valuation'] = _fullyDilutedValuation;
    map['total_volume'] = _totalVolume;
    map['high_24h'] = _high24h;
    map['low_24h'] = _low24h;
    map['price_change_24h'] = _priceChange24h;
    map['price_change_percentage_24h'] = _priceChangePercentage24h;
    map['market_cap_change_24h'] = _marketCapChange24h;
    map['market_cap_change_percentage_24h'] = _marketCapChangePercentage24h;
    map['circulating_supply'] = _circulatingSupply;
    map['total_supply'] = _totalSupply;
    map['max_supply'] = _maxSupply;
    map['ath'] = _ath;
    map['ath_change_percentage'] = _athChangePercentage;
    map['ath_date'] = _athDate;
    map['atl'] = _atl;
    map['atl_change_percentage'] = _atlChangePercentage;
    map['atl_date'] = _atlDate;
    map['roi'] = _roi;
    map['last_updated'] = _lastUpdated;
    return map;
  }

}