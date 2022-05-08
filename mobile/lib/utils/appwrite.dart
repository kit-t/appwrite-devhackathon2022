import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const String endpoint = "https://kit-t-appwrite.loca.lt/v1";
  static const String projectId = "626509630c2a5b97d779";
  static const String expensesCollId = "626e752c9989a44f2917";

  static Client get _client {
    Client client = Client(endPoint: endpoint);
    client.setProject(projectId);
    return client;
  }
  static Database get database => Database(_client);
  static Account get account => Account(_client);
  static Storage get storage => Storage(_client);
  static Locale get locale => Locale(_client);

  static final Appwrite _instance = Appwrite._internal();
  Appwrite._internal();
  factory Appwrite() => _instance;
}