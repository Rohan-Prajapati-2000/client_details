class SubscriptionModel {
  final String productTitle;
  final String validity;
  final String productTotalAmount;
  final String productBalanceAmount;
  final bool isSelected;

  SubscriptionModel(
      {required this.isSelected,
      required this.productTitle,
      required this.validity,
      required this.productTotalAmount,
      required this.productBalanceAmount});

  /// Json Format
  toJson() {
    return {
      'Product Title': productTitle,
      'Validity': validity,
      'Total Amount': productTotalAmount,
      'Balance Amount': productBalanceAmount
    };
  }


  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      productTitle: json['Product Title'] ?? '',
      validity: json['Validity'] ?? '',
      productTotalAmount: json['Total Amount'] ?? '',
      productBalanceAmount: json['Balance Amount'] ?? '',
      isSelected: json['Is Selected'],
    );
  }
}
