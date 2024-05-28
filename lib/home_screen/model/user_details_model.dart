class MyUserDetailsModel {
  final String srNo;
  final String companyName;
  final String type;
  final String date;
  final String gstNo;
  final String contactPerson;
  final String contactNumber;
  final String bdmName;
  final String totalAmount;
  final String receivedAmount;
  final String? balancePaymentAmount;
  final String? balancePaymentDate;
  List<String> imageList;

  MyUserDetailsModel({
    required this.srNo,
    required this.companyName,
    required this.type,
    required this.date,
    required this.gstNo,
    required this.contactPerson,
    required this.contactNumber,
    required this.bdmName,
    required this.totalAmount,
    required this.receivedAmount,
    this.balancePaymentAmount,
    this.balancePaymentDate,
    required this.imageList,
  });

  factory MyUserDetailsModel.fromJson(Map<String, dynamic> json) {
    return MyUserDetailsModel(
      srNo: json['Sr No'] ?? '',
      companyName: json['Company Name'] ?? '',
      type: json['Type'] ?? '',
      date: json['Date'] ?? '',
      gstNo: json['GST No'] ?? '',
      contactPerson: json['Contact Person'] ?? '',
      contactNumber: json['Contact Number'] ?? '',
      bdmName: json['BDM Name'] ?? '',
      totalAmount: json['Total Amount'] ?? '',
      receivedAmount: json['Received Amount'] ?? '',
      balancePaymentAmount: json['Balance Payment Amount'],
      balancePaymentDate: json['Balance Payment Date'],
      imageList: (json['Image URL'] is List)
          ? List<String>.from(json['Image URL'])
          : [],
    );
  }
}
