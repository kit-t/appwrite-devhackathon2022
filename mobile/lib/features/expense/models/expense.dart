class ExpenseFields {
  static const String id = "\$id";
  static const String name = "name";
  static const String totalAmt = "totalAmt";
  static const String userId = "userId";
  static const String attachmentId = "attachmentId";
  static const String date = "date";
  static const String createdAt = "createdAt";
  static const String updatedAt = "updatedAt";
}

class Expense {
  String? id;
  late String name;
  late double totalAmt;
  String? userId;
  String? attachmentId;
  late DateTime date;
  DateTime? createdAt;
  DateTime? updatedAt;

  Expense({
    this.id,
    required this.name,
    required this.totalAmt,
    this.userId,
    this.attachmentId,
    required this.date,
    this.createdAt,
    this.updatedAt,
  });

  Expense.fromJson(Map<dynamic, dynamic> json) {
    id = json[ExpenseFields.id];
    name = json[ExpenseFields.name];
    totalAmt = json[ExpenseFields.totalAmt].toDouble();
    userId = json[ExpenseFields.userId];
    attachmentId = json[ExpenseFields.attachmentId];
    date = DateTime.fromMillisecondsSinceEpoch(json[ExpenseFields.date]);
    createdAt = DateTime.fromMillisecondsSinceEpoch(json[ExpenseFields.createdAt]);
    updatedAt = DateTime.fromMillisecondsSinceEpoch(json[ExpenseFields.updatedAt]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    // json[ExpenseFields.id] = id;
    json[ExpenseFields.name] = name;
    json[ExpenseFields.totalAmt] = totalAmt;
    json[ExpenseFields.userId] = userId;
    json[ExpenseFields.attachmentId] = attachmentId;
    json[ExpenseFields.date] = date.millisecondsSinceEpoch;
    json[ExpenseFields.createdAt] = createdAt?.millisecondsSinceEpoch;
    json[ExpenseFields.updatedAt] = updatedAt?.millisecondsSinceEpoch;
    return json;
  }
}
