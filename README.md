# category_with_firebase

This library is made for individual projects to manage categories using Firebase Firestore.

## Getting Started

### InitCategory Fields

- `name`: Category Name
- `id`: Unique ID from Firebase database
- `parentPrimary`: Parent primary value from Firebase database
- `primary`: Unique identifier across all categories
- `ordinary`: Order of the category, unique within the same depth
- `depth`: Depth of the category. 1 is the top level category. You can increase the depth for more subcategories. Example: 1 = Main Category, 2 = Secondary Category, 3 = Tertiary Category

### CategoryCRUD

The `CategoryCRUD` class provides functions for Firebase database logic.

#### Methods

##### `addPrimary`

Adds a primary value to a category.

static Future<void> addPrimary({required String collection, required String id}) async

- **Parameters:**
    - `collection` (String): The name of the Firestore collection.
    - `id` (String): The document ID of the category.

- **Description:**
    - Retrieves all documents in the specified collection.
    - Finds the maximum primary value.
    - Sets the primary value of the specified document to `max + 1`.

##### `addOrdinary`

Adds an ordinary value to a category within the same depth.

static Future<void> addOrdinary({required String collection, required String id, required int depth}) async

- **Parameters:**
    - `collection` (String): The name of the Firestore collection.
    - `id` (String): The document ID of the category.
    - `depth` (int): The depth of the category.

- **Description:**
    - Retrieves all documents in the specified collection with the same depth.
    - Finds the maximum ordinary value within the same depth.
    - Sets the ordinary value of the specified document to `max + 1`.

##### `addCategory`

Adds a new category to the specified collection.

static Future<void> addCategory({
required String collection,
required InitCategory category,
int? parentPrimary
}) async

- **Parameters:**
    - `collection` (String): The name of the Firestore collection.
    - `category` (InitCategory): The category object to be added.
    - `parentPrimary` (int, optional): The parent primary value of the category.

- **Description:**
    - Adds a new document to the specified collection.
    - Updates the document with its own ID and the parent primary value.
    - Sets the primary and ordinary values.

##### `getCategories`

Retrieves all categories from the specified collection.

static Future<List<InitCategory>> getCategories({
required String collection
}) async

- **Parameters:**
    - `collection` (String): The name of the Firestore collection.

- **Returns:**
    - `Future<List<InitCategory>>`: A list of categories.

- **Description:**
    - Retrieves all documents in the specified collection.
    - Maps the documents to `InitCategory` objects.
    - Sorts the categories by their primary value.

##### `getMain`

Retrieves main categories from the specified collection.

static Future<List<InitCategory>> getMain({
required String collection
}) async

- **Parameters:**
    - `collection` (String): The name of the Firestore collection.

- **Returns:**
    - `Future<List<InitCategory>>`: A list of main categories.

- **Description:**
    - Retrieves all documents in the specified collection where the depth is 1.
    - Maps the documents to `InitCategory` objects.
    - Sorts the categories by their primary value.

##### `getSecondary`

Retrieves secondary categories from the specified collection.

static Future<List<InitCategory>> getSecondary({
required String collection,
required int parentPrimary
}) async

- **Parameters:**
    - `collection` (String): The name of the Firestore collection.
    - `parentPrimary` (int): The primary value of the parent category.

- **Returns:**
    - `Future<List<InitCategory>>`: A list of secondary categories.

- **Description:**
    - Retrieves all documents in the specified collection where the depth is 2 and the parent primary matches.
    - Maps the documents to `InitCategory` objects.
    - Sorts the categories by their primary value.

##### `getTertiary`

Retrieves tertiary categories from the specified collection.

static Future<List<InitCategory>> getTertiary({
required String collection,
required int parentPrimary
}) async

- **Parameters:**
    - `collection` (String): The name of the Firestore collection.
    - `parentPrimary` (int): The primary value of the parent category.

- **Returns:**
    - `Future<List<InitCategory>>`: A list of tertiary categories.

- **Description:**
    - Retrieves all documents in the specified collection where the depth is 3 and the parent primary matches.
    - Maps the documents to `InitCategory` objects.
    - Sorts the categories by their primary value.

##### `updateCategory`

Updates the name of a category.

static Future<void> updateCategory({
required String collection,
required String id,
required String name
}) async

- **Parameters:**
    - `collection` (String): The name of the Firestore collection.
    - `id` (String): The document ID of the category.
    - `name` (String): The new name of the category.

- **Description:**
    - Updates the specified document with the new name.

##### `deleteCategory`

Deletes a category from the specified collection.

static Future<void> deleteCategory({
required String collection,
required String id
}) async

- **Parameters:**
    - `collection` (String): The name of the Firestore collection.
    - `id` (String): The document ID of the category.

- **Description:**
    - Deletes the specified document from the collection.

Provided by Luna Shechren
https://github.com/shechren
https://shechren.github.io/lunetzsche/