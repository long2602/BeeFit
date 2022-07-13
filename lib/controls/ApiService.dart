import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/nutrition/Ingredient.dart';
import '../models/nutrition/MealPlan.dart';
import '../models/nutrition/MealRecipe.dart';

class ApiService {
  //The API service will be a singleton, therefore create a private constructor
  //ApiService._instantiate(), and a static instance variable
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();

  //Add base URL for the spoonacular API, endpoint and API Key as a constant
  final String _baseURL = "api.spoonacular.com";
  // static const String API_KEY = "9c83f17333b84312a5886843a1b1c750";
  static const String API_KEY = "a0e2facd85ca40caaed051c6767e0974";
  Future<MealPlan> generateMealPlan(
      {required int targetCalories, required String diet}) async {
    if (diet == 'None') diet = '';
    Map<String, String> parameters = {
      'timeFrame': 'day', //to get 3 meals
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseURL,
      '/recipes/mealplans/generate',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    try {
      //http.get to retrieve the response
      var response = await http.get(uri, headers: headers);
      //decode the body of the response into a map
      Map<String, dynamic> data = json.decode(response.body);
      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<Ingredient> fetchIngredient(String id) async {
    //https://api.spoonacular.com/food/ingredients/9266/information?amount=1&apiKey=9c83f17333b84312a5886843a1b1c750
    //https://api.spoonacular.com/food/ingredients/9266/?amount=1&apiKey=9c83f17333b84312a5886843a1b1c750
    Map<String, String> parameters = {
      'amount': 1.toString(),
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseURL,
      'food/ingredients/$id/information',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Ingredient ingredient = Ingredient.fromMap(data);
      return ingredient;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<Recipe> fetchRecipe(String id) async {
    Map<String, String> parameters = {
      // 'amount': '1',
      // 'unit':'g',
      'includeNutrition': 'false',
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseURL,
      '/recipes/$id/information',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe.fromMap(data);
      return recipe;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<ResultIngredients> searchIngredient(String keyword) async {
    Map<String, String> parameters = {
      'query': keyword,
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/food/ingredients/search',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      ResultIngredients ingredients = ResultIngredients.fromMap(data);
      return ingredients;
    } catch (err) {
      throw err.toString();
    }
  }
}
