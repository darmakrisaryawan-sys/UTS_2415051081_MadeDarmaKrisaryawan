import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/culture_model.dart';

class ApiService {
  final String _baseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final String _anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  Future<List<CultureModel>> fetchCultures() async {
    if (_baseUrl.isEmpty || _anonKey.isEmpty) {
      throw Exception('Konfigurasi SUPABASE_URL atau SUPABASE_ANON_KEY belum diatur di .env');
    }

    final uri = Uri.parse('$_baseUrl/rest/v1/bali_cultures?select=*&order=id.asc');

    try {
      final response = await http.get(
        uri,
        headers: {
          'apikey': _anonKey,
          'Authorization': 'Bearer $_anonKey',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => CultureModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mengambil data API (Kode: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan koneksi API: $e');
    }
  }
}