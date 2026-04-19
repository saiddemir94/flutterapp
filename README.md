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
Alternatif olarak firebase studio da flutter web server ile çalıştırılabilir.

## Görseller

<img width="1684" height="802" alt="flss1" src="https://github.com/user-attachments/assets/d96e0bb7-7248-4cc8-92eb-33c026a29cf7" />

<img width="1716" height="806" alt="flss2" src="https://github.com/user-attachments/assets/52efd74d-8339-4b5a-aab5-f50b4394cc85" />

<img width="1729" height="797" alt="flss33" src="https://github.com/user-attachments/assets/7f1013ce-ce78-4aee-817d-5531b98d9902" />



