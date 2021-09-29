import 'package:flutter/material.dart';

import '../app_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, // حجم خلية الغريد
          childAspectRatio: 7 / 8, // نسبة العرض إلى الارتفاع
          mainAxisSpacing: 10, //فراغات بين العناصر افقيا
          crossAxisSpacing: 10, // فراغات بين العناصر عموديا
        ),
        children: Categories_data.map(
            (categoryData) => // استدعاء قائمة البيانات الموجودة في ملف app_data.dart
                CategoryItem(
                  id: categoryData.id,
                  title: categoryData.title,
                  imageUrl: categoryData.imageUrl,
                )).toList(),
      
    );
  }
}
