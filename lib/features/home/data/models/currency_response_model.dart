class CurrencyResponseModel {
  CurrencyResponseModel({
    this.title,
    this.code,
    this.cbPrice,
    this.nbuBuyPrice,
    this.nbuCellPrice,
    this.date,
  });

  CurrencyResponseModel.fromJson(dynamic json) {
    title = json['title'];
    code = json['code'];
    cbPrice = json['cb_price'];
    nbuBuyPrice = json['nbu_buy_price'];
    nbuCellPrice = json['nbu_cell_price'];
    date = json['date'];
  }

  String? title;
  String? code;
  String? cbPrice;
  String? nbuBuyPrice;
  String? nbuCellPrice;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['code'] = code;
    map['cb_price'] = cbPrice;
    map['nbu_buy_price'] = nbuBuyPrice;
    map['nbu_cell_price'] = nbuCellPrice;
    map['date'] = date;
    return map;
  }
}
