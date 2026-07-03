import '../model/product_model.dart';

class ProductDummy {
  static List<ProductModel> products = [
    ProductModel(
      id: "1",
      name: "Mouse Gaming",
      price: 150000,
    ),
    ProductModel(
      id: "2",
      name: "Keyboard Mechanical",
      price: 350000,
    ),
    ProductModel(
      id: "3",
      name: "Headset Gaming",
      price: 250000,
    ),
    ProductModel(
      id: "4",
      name: "Monitor 24 inch",
      price: 1800000,
    ),
  ];
}