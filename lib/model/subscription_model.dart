class SubscriptionModel {
  final String productTitle;
  final String validity;
  final String totalAmount;
  final String balanceAmount;
  final bool isSelected;

  SubscriptionModel(
      {required this.isSelected,
      required this.productTitle,
      required this.validity,
      required this.totalAmount,
      required this.balanceAmount});

  /// Json Format
  toJson() {
    return {
      'Product Title': productTitle,
      'Validity': validity,
      'Total Amount': totalAmount,
      'Balance Amount': balanceAmount
    };
  }


  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      productTitle: json['Product Title'] ?? '',
      validity: json['Validity'] ?? '',
      totalAmount: json['Total Amount'] ?? '',
      balanceAmount: json['Balance Amount'] ?? '',
      isSelected: json['Is Selected'],
    );
  }
}
