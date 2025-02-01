class Rate {
  final double rate;
  final int count;

  Rate({
    required this.rate,
    required this.count,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
