class TotalingType {
  double? totalTax;
  double? totalShippingFee;
  double? totalDiscount;
  double? subTotal;
  double? total;

  TotalingType({
    this.totalTax,
    this.totalShippingFee,
    this.totalDiscount,
    this.subTotal,
    this.total,
  });

  TotalingType.fromJson(Map<String, dynamic> json) {
    totalTax = json['total_tax'];
    totalShippingFee = json['total_shipping_fee'];
    totalDiscount = json['total_discount'];
    subTotal = json['sub_total'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_tax'] = totalTax;
    data['total_shipping_fee'] = totalShippingFee;
    data['total_discount'] = totalDiscount;
    data['sub_total'] = subTotal;
    data['total'] = total;
    return data;
  }
}
