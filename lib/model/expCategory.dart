
class ExpCategory {
    int? categoryId;
    String? mainCategory;
    String? subCategory;
    bool? trash;

    ExpCategory({this.categoryId, this.mainCategory, this.subCategory, this.trash});

    ExpCategory.fromJson(Map<String, dynamic> json) {
        if(json["categoryId"] is num) {
            categoryId = (json["categoryId"] as num).toInt();
        }
        if(json["mainCategory"] is String) {
            mainCategory = json["mainCategory"];
        }
        if(json["subCategory"] is String) {
            subCategory = json["subCategory"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<ExpCategory> fromList(List<Map<String, dynamic>> list) {
        return list.map(ExpCategory.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["categoryId"] = categoryId;
        _data["mainCategory"] = mainCategory;
        _data["subCategory"] = subCategory;
        _data["trash"] = trash;
        return _data;
    }

    ExpCategory copyWith({
        int? categoryId,
        String? mainCategory,
        String? subCategory,
        bool? trash,
    }) => ExpCategory(
        categoryId: categoryId ?? this.categoryId,
        mainCategory: mainCategory ?? this.mainCategory,
        subCategory: subCategory ?? this.subCategory,
        trash: trash ?? this.trash,
    );
}