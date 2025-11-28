import 'package:dio/dio.dart';
import 'package:dorm_of_decents/data/models/meal_response.dart';
import 'package:dorm_of_decents/data/services/client/dio_client.dart';

class MealApi {
  Future<MealResponse> fetchMeals() async {
    try {
      final client = ApiClient();

      // Ensure tokens are loaded before making request
      await client.loadTokensFromStorage();

      final response = await client.get('/meals');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final mealResponse = MealResponse.fromJson(response.data);
        print(mealResponse.toJson());
        return mealResponse;
      } else {
        throw Exception(response.data['error'] ?? 'Failed to fetch meals');
      }
    } on DioException catch (e) {
      // Extract error message from response
      String errorMessage = 'Failed to fetch meals data. Please try again.';

      if (e.response?.data != null) {
        if (e.response!.data is Map && e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        } else if (e.response!.statusCode == 404) {
          errorMessage = 'Meals not found.';
        } else if (e.response!.statusCode == 401) {
          errorMessage = 'Unauthorized. Please login again.';
        } else if (e.response!.statusCode == 500) {
          errorMessage = 'Server error. Please try again later.';
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout. Please check your internet.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server response timeout. Please try again.';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'Network error. Please check your connection.';
      }

      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
