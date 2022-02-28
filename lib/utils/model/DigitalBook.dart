class DigitalBook {
  String title;
  String author;
  String publication;
  String subjectName;
  String bookNo;
  String reckNo;
  int quantity;
  int price;
  String postDate;
  String details;
  String categoryName;
  String fileLink;

  DigitalBook(
      {this.title,
      this.author,
      this.publication,
      this.subjectName,
      this.bookNo,
      this.reckNo,
      this.quantity,
      this.price,
      this.postDate,
      this.details,
      this.fileLink,
      this.categoryName});

  factory DigitalBook.fromJson(Map<String, dynamic> json) {
    return DigitalBook(
        title: json['book_title'],
        author: json['author_name'],
        publication: json['publisher_name'],
        subjectName: json['subject_name'],
        bookNo: json['book_number'],
        reckNo: json['rack_number'],
        quantity: json['quantity'],
        price: json['book_price'],
        postDate: json['post_date'],
        details: json['details'],
        categoryName: json['category_name'],
        fileLink: json['upload_file']);
  }
}

class DigitalBookList {
  List<DigitalBook> books;

  DigitalBookList(this.books);

  factory DigitalBookList.fromJson(List<dynamic> json) {
    List<DigitalBook> booklist =
        json.map((i) => DigitalBook.fromJson(i)).toList();

    return DigitalBookList(booklist);
  }
}
