import 'package:equatable/equatable.dart';

class MealResponse extends Equatable {
  final bool success;
  final List<Meal> meals;

  const MealResponse({required this.success, required this.meals});

  factory MealResponse.fromJson(Map<String, dynamic> json) {
    var mealsJson = json['meals'] as List;
    List<Meal> mealsList = mealsJson.map((mealJson) => Meal.fromJson(mealJson)).toList();

    return MealResponse(
      success: json['success'],
      meals: mealsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'meals': meals.map((meal) => meal.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [success, meals];
}

class Meal extends Equatable {
  final String id;
  final int mealCount;
  final DateTime date;
  final DateTime createdAt;
  final String userId;
  final String monthId;
  final MealProfile profiles;

  const Meal({
    required this.id,
    required this.mealCount,
    required this.date,
    required this.createdAt,
    required this.userId,
    required this.monthId,
    required this.profiles,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      mealCount: json['meal_count'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      monthId: json['month_id'],
      profiles: MealProfile.fromJson(json['profiles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal_count': mealCount,
      'date': date.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'month_id': monthId,
      'profiles': profiles.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, mealCount, date, createdAt, userId, monthId, profiles];
}

class MealProfile extends Equatable {
  final String id;
  final String name;
  const MealProfile({required this.id,  required this.name});

  factory MealProfile.fromJson(Map<String, dynamic> json) {
    return MealProfile(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];

}