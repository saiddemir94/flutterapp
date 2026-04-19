# Mini Katalog Uygulamasi

Flutter egitimi icin hazirlanmis basit fakat duzenli bir mini katalog uygulamasidir. Proje; urun listeleme, grid kart tasarimi, detay sayfasi, sayfalar arasi veri tasima, JSON simulasyonu ve basit sepet state guncellemesini icerir.

## Ozellikler

- Ayri ana sayfa, urun listesi ve urun detay ekrani
- Ana sayfa ve urunler icin alt navbar
- Urun detay sayfasi
- `Navigator.pushNamed` ile sayfa gecisi
- `RouteSettings.arguments` mantigi icin detay sayfasina urun nesnesi tasima
- `assets/data/products.json` dosyasindan veri okuma
- `assets/images` klasorunden `Image.asset` ile gercek urun fotograflari kullanma
- Model sinifi ile `fromJson` ve `toJson` ornegi
- Urun arama ve kategoriye gore filtreleme
- Urun kartlarinda puan, fiyat ve sepet aksiyonu
- Urun kartina tiklayinca detay sayfasinda urun ozelliklerini gosterme
- Basit sepet ekle/cikar simulasyonu

## Klasor Yapisi

```text
lib/
  data/
    product_repository.dart
  models/
    product.dart
  screens/
    home_screen.dart
    shell_screen.dart
    product_list_screen.dart
    product_detail_screen.dart
  widgets/
    product_card.dart
  main.dart
assets/
  data/
    products.json
  images/
    headphones.png
    watch.png
    bag.png
    camera.png
    thermos.png
    speaker.png
```

## Kullanilan Flutter Surumu

Bu proje Flutter 3.x ve Dart 3.x ile calisacak sekilde hazirlanmistir.

## Calistirma

Bilgisayarda Flutter SDK kurulu ve PATH'e ekli olmalidir.

```bash
flutter pub get
flutter run
```

Testleri calistirmak icin:

```bash
flutter test
```

## Not

Bu klasorde Flutter SDK komutu bulunamadigi icin proje dosyalari elle olusturuldu. Gerekirse platform klasorlerini yenilemek icin Flutter kurulu bir ortamda su komut kullanilabilir:

```bash
flutter create .
```

Web hedefi icin temel `web/` klasoru eklendi. Android veya iOS platform dosyalari gerekiyorsa yukaridaki komut Flutter tarafindan standart klasorleri olusturur.
