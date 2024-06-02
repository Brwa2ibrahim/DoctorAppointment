import 'package:doc_app/Services/assets_manager.dart';
import 'package:doc_app/models/categories_model.dart';

export './colors.dart';
export './images.dart';
export './strings.dart';
export './styles.dart';

class AppConstants {
  static List<CategoriesModel> categoriesList = [
    CategoriesModel(
      id: "brines",
      image: AssetsManager.brine,
      name: "brines",
    ),
    CategoriesModel(
      id: "dentals",
      image: AssetsManager.dental,
      name: "dental",
    ),
    CategoriesModel(
      id: "eyes",
      image: AssetsManager.eye,
      name: "eyes",
    ),
    CategoriesModel(
      id: "hearts",
      image: AssetsManager.heart,
      name: "hearts",
    ),
  ];
}
