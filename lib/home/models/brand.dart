class Brand {
  int brandId;
  String name;
  String imagePath;

  Brand({this.brandId, this.name});

  static const imagePaths = {
    1: "assets/logo_audi.png",
    2: "assets/logo_chevrolet.png",
    3: "assets/logo_hyundai.png",
  };

  Brand.fromJson(Map<String, dynamic> json) {
    var id = json['brand_id'];
    brandId = id is String ? int.parse(id) : id;
    name = json['name'];
    imagePath = imagePaths[brandId];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = imagePath;
    data['brand_id'] = this.brandId;
    data['name'] = this.name;
    return data;
  }
}
