import 'package:khaltabita/user/data/model/user_model.dart';
import 'package:khaltabita/user/domin/entites/output_data.dart';

class OutputDataModel extends OutputData {
  OutputDataModel(
      { required super.userData});

  factory OutputDataModel.fromJson(Map<String, dynamic> json) {
    return OutputDataModel(

        userData: UserModel.fromJson(json['deletedBook'])
    );
  }
}
