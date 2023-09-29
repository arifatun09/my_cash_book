class Transaction {
  int? id;
  String? date;
  int? nominal;
  String? description;
  String? category;

  Transaction({
    this.id,
    this.date,
    this.nominal,
    this.description,
    this.category,
  });

  transactionMap() {
    var mapping = <String, dynamic>{};
    // ignore: unnecessary_null_in_if_null_operators
    mapping['id'] = id ?? null;
    mapping['date'] = date!;
    mapping['nominal'] = nominal!;
    mapping['description'] = description!;
    mapping['category'] = category!;
    return mapping;
  }
}
