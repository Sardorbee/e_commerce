class RatingsModel {
    double rate;
    int count;

    RatingsModel({
        required this.rate,
        required this.count,
    });

    factory RatingsModel.fromJson(Map<String, dynamic> json) => RatingsModel(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
    };
}
