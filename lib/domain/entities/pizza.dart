class Pizza {
  String description;
  String title;
  double price;
  String? image;

  Pizza({
    required this.description,
    required this.title,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'description': description,
    'title': title,
    'price': price,
  };

  @override
  String toString() {
    return '{\n'
        '\tdescription: $description,\n'
        '\ttitle: $title,\n'
        '\tprice: $price,\n'
        '\timage: $image\n'
        '}\n';
  }
}
