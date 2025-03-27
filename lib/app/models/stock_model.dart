class Stocks {
  final String? name;
  final String? id;
  final String? category;
  final double? nav;
  final Change? change;
  final double? expenseRatio;
  final String? logoUrl;

  Stocks({
    this.name,
    this.id,
    this.category,
    this.nav,
    this.change,
    this.expenseRatio,
    this.logoUrl,
  });

  Stocks.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        id = json['id'] as String?,
        category = json['category'] as String?,
        nav = json['nav'] as double?,
        change = (json['change'] as Map<String, dynamic>?) != null
            ? Change.fromJson(json['change'] as Map<String, dynamic>)
            : null,
        expenseRatio = json['expense_ratio'] as double?,
        logoUrl = json['logo_url'] as String?;

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'category': category,
        'nav': nav,
        'change': change?.toJson(),
        'expense_ratio': expenseRatio,
        'logo_url': logoUrl
      };
}

class Change {
  final double? day;
  final double? year;
  final double? yearT;
  final double? yearF;

  Change({
    this.day,
    this.year,
    this.yearT,
    this.yearF,
  });

  Change.fromJson(Map<String, dynamic> json)
      : day = json['1D'] as double?,
        year = json['1Y'] as double?,
        yearT = json['3Y'] as double?,
        yearF = json['5Y'] as double?;

  Map<String, dynamic> toJson() =>
      {'1D': day, '1Y': year, '3Y': yearT, '5Y': yearF};
}
