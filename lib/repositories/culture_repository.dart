import '../models/culture_model.dart';
import '../services/api_service.dart';

class CultureRepository {
  final ApiService _apiService;

  CultureRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<List<CultureModel>> getCultures() async {
    return await _apiService.fetchCultures();
  }
}