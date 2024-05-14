# category_with_firebase

This Library is made for me for individual Project.

## Getting Started

The Category Structure is as follows:

```dart
class InitCategory {
  InitCategory({required this.name,
    required this.depth,
    this.id,
    this.parentId,
    this.ordinary});

  final String name;
  final int depth;
  final String? id;
  final String? parentId;
  final int? ordinary;

  Map<String, dynamic> makeMap() {
    return {
      'name': name,
      'depth': depth,
      'id': id ?? '',
      'parentId': parentId ?? '',
      'ordinary': ordinary ?? 0,
    };
  }
}
```

### InitCategory

name = Category Name
id = Unique ID from firebase database
parentId = Parent ID from firebase database
ordinary = Order of the category, Unique.
depth = Depth of the category, 1 is the top level category. you can increase more sub categories.
example: 1 = Main Category, 2 = Secondary Category, 3 = Tertiary Category

### CategoryCRUD
// for firebase database logic
addCategory(collection, category, parentId = null)
getCategories(collection)
getMain(collection)
getSecondary(collection, parentId)
getTertiary(collection, parentId)
updateCategory(collection, String id, String name)
deleteCategory(collection, String id)


---
Provided by Luna Shechren
https://github.com/shechren
https://shechren.github.io/lunetzsche/