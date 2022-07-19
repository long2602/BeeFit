class WeightPerServing {
  final int amount;
  final String unit;

  WeightPerServing({required this.amount, required this.unit});

  factory WeightPerServing.fromMap(Map<String, dynamic> map) {
    return WeightPerServing(
      unit: map['unit'],
      amount: map['amount'],
    );
  }
}

class CaloricBreakdown {
  final double percentProtein;
  final double percentFat;
  final double percentCarbs;

  CaloricBreakdown(
      {required this.percentProtein,
      required this.percentFat,
      required this.percentCarbs});

  factory CaloricBreakdown.fromMap(Map<String, dynamic> map) {
    return CaloricBreakdown(
        percentProtein: map['percentProtein'],
        percentFat: map['percentFat'],
        percentCarbs: map['percentCarbs']);
  }

  static List<Map<String, dynamic>> convertToMap(
      CaloricBreakdown caloricBreakdown) {
    List<Map<String, dynamic>> result = [];
    Map<String, dynamic> a = {};
    a['domain'] = 'Protein';
    a['measure'] = caloricBreakdown.percentProtein;
    Map<String, dynamic> b = {};
    b['domain'] = 'Fat';
    b['measure'] = caloricBreakdown.percentFat;
    Map<String, dynamic> c = {};
    c['domain'] = 'Carbs';
    c['measure'] = caloricBreakdown.percentCarbs;
    result.add(a);
    result.add(b);
    result.add(c);
    return result;
  }
}

class Nutrient {
  final String name;
  final double amount;
  final String unit;
  final double percentOfDailyNeeds;

  Nutrient({
    required this.name,
    required this.amount,
    required this.unit,
    required this.percentOfDailyNeeds,
  });

  factory Nutrient.fromMap(Map<String, dynamic> map) {
    //Meal object
    return Nutrient(
      name: map['name'],
      amount: map['amount'],
      unit: map['unit'],
      percentOfDailyNeeds: map['percentOfDailyNeeds'],
    );
  }
}

class Nutrition {
  final List<Nutrient> Nutrients;
  final CaloricBreakdown caloricBreakdown;
  final WeightPerServing weightPerServing;
  Nutrition(
      {required this.Nutrients,
      required this.caloricBreakdown,
      required this.weightPerServing});

  factory Nutrition.fromMap(Map<String, dynamic> map) {
    List<Nutrient> list = [];
    map['nutrients']
        .forEach((nutrient) => list.add(Nutrient.fromMap(nutrient)));
    //Meal object
    return Nutrition(
      caloricBreakdown: CaloricBreakdown.fromMap(map['caloricBreakdown']),
      weightPerServing: WeightPerServing.fromMap(map['weightPerServing']),
      Nutrients: list,
    );
  }
}

class Ingredient {
  final int id;
  final String name;
  final double? amount;
  final String image;
  final Nutrition? nutrition;
  final List<String>? possibleUnits;

  Ingredient({
    required this.id,
    required this.name,
    this.amount,
    required this.image,
    this.nutrition,
    this.possibleUnits,
  });

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    List<String> list = [];
    map['possibleUnits'].forEach((unit) => list.add(unit));
    //Meal object
    return Ingredient(
      name: map['name'],
      id: map['id'],
      amount: map['amount'],
      image: 'https://spoonacular.com/cdn/ingredients_500x500/' + map['image'],
      nutrition:
          map['nutrition'] != null ? Nutrition.fromMap(map['nutrition']) : null,
      possibleUnits: list,
    );
  }
}

class ResultIngredients {
  final List<Ingredient> ingredients;
  final int amount;
  final int totalResult;
  final int offset;

  ResultIngredients({
    required this.ingredients,
    required this.amount,
    required this.totalResult,
    required this.offset,
  });

  factory ResultIngredients.fromMap(Map<String, dynamic> map) {
    List<Ingredient> list = [];
    map['results']
        .forEach((nutrient) => list.add(Ingredient.fromMap(nutrient)));
    return ResultIngredients(
        amount: map['number'],
        offset: map['offset'],
        totalResult: map['totalResults'],
        ingredients: list);
  }
}
