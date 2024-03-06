class NavSearchBarType {
  String? search;
  String? category;

  NavSearchBarType({this.search, this.category});

  NavSearchBarType.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['category'] = category;
    return data;
  }
}

class ProductSearchModel {
  int? page;
  String? search;
  String? subcategory;
  String? priceRange;
  String? popularBrands;
  String? sortBy;

  ProductSearchModel(
      {this.page,
      this.search,
      this.subcategory,
      this.priceRange,
      this.popularBrands,
      this.sortBy});

  ProductSearchModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    search = json['search'];
    subcategory = json['subcategory'];
    priceRange = json['priceRange'];
    popularBrands = json['popularBrands'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['search'] = search;
    data['subcategory'] = subcategory;
    data['priceRange'] = priceRange;
    data['popularBrands'] = popularBrands;
    data['sortBy'] = sortBy;
    return data;
  }
}
