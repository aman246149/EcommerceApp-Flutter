class Product{
  late String id;
  late String title;
  late int price;
  late String description;
  late String category;
  late String imageurl;
  // late dynamic rating;

Product({required this.id,
  required this.title,required this.price,
  required this.description,required this.category,
  required this.imageurl});

//Json->Map to object Desirialization
Product.fromMap(Map<String,dynamic>map){
  this.id=map["id"];
  this.title=map["title"];
  this.price=map["price"];
  this.description=map["description"];
  this.category=map["category"];
  this.imageurl=map["image"];

  //object to map serialization

  Map<String,dynamic> toMap(){
    return{
      "id":this.id,
      "title":this.title,
      "price":this.price,
      "description":this.description,
      "category":this.category,
      "image":this.imageurl
    };
  }

}
}