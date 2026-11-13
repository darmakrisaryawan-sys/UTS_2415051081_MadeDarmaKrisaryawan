# BaliCulture — Aplikasi Katalog & Jurnal Warisan Budaya Bali

Aplikasi mobile dan web berbasis **Flutter** dan **Supabase** untuk menjelajahi warisan seni dan budaya Pulau Dewata (Tari, Pura, Upacara, Musik, dan Tradisi) sekaligus mencatat jurnal kunjungan pribadi pengguna.

---

## Identitas Pengembang (UTS Pemrograman Mobile)
* **Nama:** Made Darma Krisaryawan
* **NIM:** 2415051081
* **Kelas:** PTI 5B
* **Program Studi:** Pendidikan Teknik Informatika — Fakultas Teknik dan Kejuruan, Universitas Pendidikan Ganesha (Undiksha)


## Unduh Aplikasi (Android APK)
Aplikasi versi rilis siap pasang (`app-release.apk`) dapat diunduh melalui tautan Google Drive berikut:
* **[Unduh BaliCulture APK (Google Drive)](https://drive.google.com/file/d/1Wvu2QWVEHqogh2IIRAZUq69A61WLPhwc/view?usp=sharing)**
---

## Fitur Utama Aplikasi
1. **Katalog Budaya Bali Terkategori (REST API):**
   * Menampilkan 15 warisan budaya Bali yang terbagi ke dalam 5 kategori utama: **Tari**, **Pura**, **Upacara**, **Musik**, dan **Tradisi**.
   * Mendukung filter kategori interaktif (*Category Chips*), pencarian (*Search Bar*) berdasarkan nama maupun lokasi, serta *pull-to-refresh*.
2. **Halaman Detail Interaktif:**
   * **Galeri Multi-Foto:** *Slide* gambar interaktif (`PageView`) dilengkapi deretan thumbnail foto yang dapat dipilih.
   * **Integrasi Google Maps:** Tombol navigasi langsung menuju titik lokasi budaya di aplikasi/web Google Maps menggunakan `url_launcher`.
   * **Deskripsi & Sejarah Lengkap:** Informasi mendalam seputar latar belakang budaya.
3. **Jurnal & Favorit Kunjungan (Full CRUD Database Supabase):**
   * **Create:** Menambahkan catatan kunjungan baru beserta rating pengalaman (1–5 bintang).
   * **Read:** Memuat daftar jurnal tersimpan secara *real-time* dari tabel `culture_journals`.
   * **Update:** Mengubah judul, catatan, dan rating jurnal yang sudah tersimpan.
   * **Delete:** Menghapus jurnal dengan dialog konfirmasi keamanan (`AlertDialog`).
4. **Profil Pengguna Dinamis:**
   * Menampilkan statistik jumlah jurnal tersimpan dan total katalog budaya secara langsung.
   * Mendukung perubahan foto profil dari galeri maupun kamera (`image_picker`) serta pembaruan nama dan bio pengguna.
5. **Desain Responsif & Penanganan Error:**
   * Tata letak adaptif (`LayoutBuilder`) yang menyesuaikan tampilan *ListView* pada layar ponsel dan *GridView* pada layar tablet/web.
   * Validasi jaringan, batas waktu koneksi (*timeout*), serta umpan balik visual (*loading indicator*, *empty state*, *error state*, dan `SnackBar`).

---

## Arsitektur & Teknologi
Aplikasi dibangun menggunakan pola arsitektur berlapis (*Clean Layered Architecture*):
* **Presentation Layer (UI):** Flutter Material 3 (`Screens` & reusable `Widgets`).
* **State Management:** `Provider` + `ChangeNotifier` (`CultureProvider` dan `JournalProvider`).
* **Data Layer:** `Repository Pattern` (`CultureRepository`, `JournalRepository`) & `Service Layer` (`ApiService`, `SupabaseService`).
* **Backend & Cloud Storage:**
  * **Supabase REST API & PostgreSQL Database** (tabel `bali_cultures` dan `culture_journals`).
  * **Supabase Storage** untuk penyimpanan aset gambar publik.
* **Packages Utama:** `provider`, `http`, `supabase_flutter`, `flutter_dotenv`, `url_launcher`, `image_picker`, `flutter_launcher_icons`.

---

## Struktur Folder Proyek
```text
lib/
├── main.dart                     # Entry point, inisialisasi .env, Supabase, & MultiProvider
├── models/                       # Dart Data Models (null-safe & JSON serialization)
│   ├── culture_model.dart
│   └── journal_model.dart
├── providers/                    # State Management (ChangeNotifier)
│   ├── culture_provider.dart
│   └── journal_provider.dart
├── repositories/                 # Abstraksi akses data antara Provider dan Service
│   ├── culture_repository.dart
│   └── journal_repository.dart
├── services/                     # Komunikasi jaringan (HTTP REST API & Supabase SDK)
│   ├── api_service.dart
│   └── supabase_service.dart
├── screens/                      # Halaman utama aplikasi
│   ├── main_navigation_screen.dart
│   ├── home_screen.dart
│   ├── culture_list_screen.dart
│   ├── culture_detail_screen.dart
│   ├── journal_list_screen.dart
│   ├── add_journal_screen.dart
│   ├── edit_journal_screen.dart
│   └── profile_screen.dart
└── widgets/                      # Komponen UI reusable
    ├── category_chip.dart
    ├── culture_card.dart
    └── state_feedback_widget.dart