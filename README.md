# category_with_firebase

This Project is made for me.

## Getting Started

The Category Structure is as follows:

```dart
class InitCategory {
  InitCategory(
      {required this.name,
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

### CategoryCRUD
addCategory(InitCategory category, String? parentId = null)
getCategories()
getMain()
getSecondary(String parentId)
getTertiary(String parentId)
updateCategory(String id, String name)
deleteCategory(String id)


---
Provided by Luna Shechren
https://github.com/shechren