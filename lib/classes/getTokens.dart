class GetTokens {
  String address;
  ETH eTH;
  int countTxs;
  List<Tokens> tokens;

  GetTokens({this.address, this.eTH, this.countTxs, this.tokens});

  GetTokens.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    eTH = json['ETH'] != null ? new ETH.fromJson(json['ETH']) : null;
    countTxs = json['countTxs'];
    if (json['tokens'] != null) {
      tokens = new List<Tokens>();
      json['tokens'].forEach((v) {
        tokens.add(new Tokens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    if (this.eTH != null) {
      data['ETH'] = this.eTH.toJson();
    }
    data['countTxs'] = this.countTxs;
    if (this.tokens != null) {
      data['tokens'] = this.tokens.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ETH {
  double balance;

  ETH({this.balance});

  ETH.fromJson(Map<String, dynamic> json) {
    if (json['balance'] is bool) {
      balance = 0.0;
    } else {
      balance = double.parse(json['balance'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    return data;
  }
}

class Tokens {
  TokenInfo tokenInfo;
  double balance;
  int totalIn;
  int totalOut;

  Tokens({this.tokenInfo, this.balance, this.totalIn, this.totalOut});

  Tokens.fromJson(Map<String, dynamic> json) {
    tokenInfo = json['tokenInfo'] != null
        ? new TokenInfo.fromJson(json['tokenInfo'])
        : null;
    if (json['balance'] is bool) {
      balance = 0;
    } else {
      balance = double.parse(json['balance'].toString());
    }
    totalIn = json['totalIn'];
    totalOut = json['totalOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tokenInfo != null) {
      data['tokenInfo'] = this.tokenInfo.toJson();
    }
    data['balance'] = this.balance;
    data['totalIn'] = this.totalIn;
    data['totalOut'] = this.totalOut;
    return data;
  }
}

class TokenInfo {
  String address;
  String name;
  int decimals;
  String symbol;
  String totalSupply;
  String owner;
  int lastUpdated;
  int issuancesCount;
  int holdersCount;
  String description;
  String website;
  String facebook;
  String twitter;
  String reddit;
  int ethTransfersCount;
  var price;

  TokenInfo(
      {this.address,
      this.name,
      this.decimals,
      this.symbol,
      this.totalSupply,
      this.owner,
      this.lastUpdated,
      this.issuancesCount,
      this.holdersCount,
      this.description,
      this.website,
      this.facebook,
      this.twitter,
      this.reddit,
      this.ethTransfersCount,
      this.price});

  TokenInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
    decimals = int.parse(json['decimals'].toString());
    symbol = json['symbol'];
    totalSupply = json['totalSupply'];
    owner = json['owner'];
    lastUpdated = json['lastUpdated'];
    issuancesCount = json['issuancesCount'];
    holdersCount = json['holdersCount'];
    description = json['description'];
    website = json['website'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    reddit = json['reddit'];
    ethTransfersCount = json['ethTransfersCount'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['name'] = this.name;
    data['decimals'] = this.decimals;
    data['symbol'] = this.symbol;
    data['totalSupply'] = this.totalSupply;
    data['owner'] = this.owner;
    data['lastUpdated'] = this.lastUpdated;
    data['issuancesCount'] = this.issuancesCount;
    data['holdersCount'] = this.holdersCount;
    data['description'] = this.description;
    data['website'] = this.website;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['reddit'] = this.reddit;
    data['ethTransfersCount'] = this.ethTransfersCount;
    data['price'] = this.price;
    return data;
  }
}
