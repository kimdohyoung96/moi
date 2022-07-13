import 'package:flutter/material.dart';
import 'package:untitled1/utils/logger.dart';

CategoryNotifier categoryNotifier = CategoryNotifier();

class CategoryNotifier extends ChangeNotifier {
  String _selectedCategoryInEng = 'none';

  String get currentCategoryInEng => _selectedCategoryInEng;
  String get currentCategoryInKor {
    logger.d("currentCategoryInKor called!!!!");
    return categoriesMapEngToKor[_selectedCategoryInEng]!;
  }

  void setNewCategoryWithEng(String newCategory) {
    if (categoriesMapEngToKor.keys.contains(newCategory)) {
      _selectedCategoryInEng = newCategory;
      notifyListeners();
    }
  }

  void setNewCategoryWithKor(String newCategory) {
    if (categoriesMapEngToKor.values.contains(newCategory)) {
      _selectedCategoryInEng = categoriesMapKorToEng[newCategory]!;
      notifyListeners();
    }
  }
}

const Map<String, String> categoriesMapEngToKor = {
  'none': '선택',
  'light': '가벼운 물건(~3kg)',
  'middle': '적당한 물건(3kg~7kg)',
  'heavy': '무거운 물건(7kg~)',
  'small': '부피가 작은 물건',
  'biggest': '부피가 큰 물건',
  'dangerous': '파손주의 물건',
  'fast': '긴급 배달 물건',
};

const Map<String, String> categoriesMapKorToEng = {
  '선택': 'none',
  '가벼운 물건(~3kg)': 'light',
  '적당한 물건(3kg~7kg)': 'middle',
  '무거운 물건(7kg~)': 'heavy',
  '부피가 작은 물건': 'small',
  '부피가 큰 물건': 'biggest',
  '파손주의 물건': 'dangerous',
  '긴급 배달 물건': 'fast',
};
