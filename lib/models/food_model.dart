class Food {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<FoodModel> _foods;
  List<FoodModel> get foods => _foods;

  Food(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._foods = products;
  }

  Food.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offsets'];
    if (json['products'] != null) {
      _foods = <FoodModel>[];
      json['products'].forEach((v) => _foods.add(FoodModel.fromJson(v)));
    }
  }
}

class FoodModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  FoodModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }
}
