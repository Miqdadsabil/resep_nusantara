# 🍛 Resep Nusantara

Aplikasi mobile katalog resep masakan Indonesia berbasis Flutter.
UTS Mobile Programming, Semester Ganjil 2025/2026.

| | |
|---|---|
| **Nama** | Mukhammad Miqdad Ibnu Sabil |
| **NIM** | 240605110103 |
| **Mobile Programming Praktikum** | [F] |

## Tema dan Tujuan
Resep Nusantara membantu pengguna menemukan resep masakan khas Indonesia
berdasarkan kategori, lengkap dengan bahan dan langkah memasak. Data saat ini
berupa data dummy JSON lokal dan dirancang agar mudah diganti dengan API.

## Daftar Halaman
| Halaman | Berkas | Fungsi |
|---|---|---|
| Beranda | `lib/screens/home_screen.dart` | Sapaan, pencarian, kategori, resep populer dan terbaru |
| Daftar Resep | `lib/screens/list_screen.dart` | Filter kategori, pencarian, tampilan list/grid responsif |
| Detail Resep | `lib/screens/detail_screen.dart` | Info, bahan, langkah memasak, tombol favorit |

Navigasi memakai `BottomNavigationBar` (Beranda dan Resep) dan `Navigator.push`
(ke Daftar dan Detail).

## Struktur Folder
​```
lib/
├── main.dart
├── core/app_theme.dart
├── models/ (recipe.dart, category_item.dart)
├── services/ (recipe_service.dart, favorite_store.dart)
├── widgets/ (recipe_image.dart, recipe_cards.dart)
└── screens/ (main_shell, home_screen, list_screen, detail_screen)
assets/data/recipes.json
​```

## Cara Menjalankan
1. Pasang Flutter SDK, lalu cek dengan `flutter doctor`.
2. `git clone https://github.com/Miqdadsabil/resep_nusantara.git`
3. `cd resep_nusantara`
4. `flutter pub get`
5. `flutter run` (pilih device: emulator Android, HP, atau Windows)

## Rencana Pengembangan
- Mengganti `RecipeService` dengan request API memakai paket `http`
- Menyimpan favorit secara permanen
- Halaman Favorit dan mode gelap
