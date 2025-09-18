import 'package:easy_json/easy_json.dart';
import 'package:example/generated/star_trek/company.easy.dart';

@EasyJson()
class Company with CompanySerializer {
  final String uid;
  final String name;
  const Company({required this.uid, required this.name});
}