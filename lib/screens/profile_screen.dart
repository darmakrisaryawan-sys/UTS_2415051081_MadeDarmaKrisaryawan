import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengembang')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFF8B1E1E),
                child: Icon(Icons.person, size: 54, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'Made Darma Krisaryawan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'NIM: 2415051081 • Kelas: PTI 5B',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pendidikan Teknik Informatika - Undiksha',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const Divider(height: 36),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'BaliCulture Mini Project UTS',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Aplikasi katalog warisan budaya Bali dan pencatatan jurnal kunjungan berbasis Flutter, Provider, REST API, dan Supabase.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}