# Zaman Serileri Analizi 

## Hacettepe Üniversitesi Fen Fakültesi İstatistik Bölümü

### İsmail KILIÇ 


---

## İçindekiler

1. [Veri Setinin Tanıtımı](#veri-setinin-tanıtımı)
2. [Veriye Ait Grafikler](#veriye-ait-grafikler)
    - [Gecikme Grafiği](#gecikme-grafiği)
    - [ACF ve PACF Grafikleri](#acf-ve-pacf-grafikleri)
        - [Farka Ait ACF ve PACF Grafikleri](#farka-ait-acf-ve-pacf-grafikleri)
3. [Ayrıştırma Yöntemleri](#ayrıştırma-yöntemleri)
    - [Toplamsal Ayrıştırma](#toplamsal-ayrıştırma)
    - [Çarpımsal Ayrıştırma](#çarpımsal-ayrıştırma)
4. [Mevsimsel Zaman Serilerinde Regresyon Analizi](#mevsimsel-zaman-serilerinde-regresyon-analizi)
    - [Toplamsal Regresyon](#toplamsal-regresyon)
    - [Çarpımsal Regresyon](#çarpımsal-regresyon)
5. [Üstel Düzleştirme Yöntemi](#üstel-düzleştirme-yöntemi)
    - [Winters Üstel Düzleştirme Yöntemi](#winters-üstel-düzleştirme-yöntemi)
        - [Toplamsal Winters Üstel Düzleştirme Yöntemi](#toplamsal-winters-üstel-düzleştirme-yöntemi)
        - [Çarpımsal Winters Üstel Düzleştirme Yöntemi](#çarpımsal-winters-üstel-düzleştirme-yöntemi)
6. [Box-Jenkins Modeli ile Tahmin ve Öngörü](#box-jenkins-modeli-ile-tahmin-ve-öngörü)
    - [Model Seçimi ve İncelemesi](#model-seçimi-ve-incelenmesi)
    - [Modelin Tahmini](#modelin-tahmini)
    - [Modelin Öngörüsü](#modelin-öngörüsü)
7. [Kaynakça](#kaynakça)

---

## Veri Setinin Tanıtımı

1.01.2012 - 1.09.2018 tarihleri arasında havadaki karbondioksit oranı incelenip tahmin modeli geliştirilmiştir.

| Tarih      | CO2 PPM |
|------------|---------|
| 1.01.2012  | 39312   |
| 1.02.2012  | 39386   |
| 1.03.2012  | 3944    |
| 1.04.2012  | 39618   |
| ...        | ...     |
| 1.05.2018  | 41124   |
| 1.06.2018  | 41079   |
| 1.07.2018  | 40871   |
| 1.08.2018  | 40699   |
| 1.09.2018  | 40551   |

## Veriye Ait Grafikler
!([https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png](https://github.com/klc-ismail/Zaman-Serileri-ile-Havadaki-CO2-Tahmini/blob/main/grafikler/grafik1.jpg))
Grafik incelendiğinde mevsimsellik ve yukarı yönlü trend gözlemlenmektedir.

### Gecikme Grafiği

### ACF ve PACF Grafikleri

ACF grafiği incelendiğinde ilk dört veri güven sınırları dışarısında olup seride trend olduğunu desteklemektedir. Yine ACF grafiğine bakıldığında baskın mevsimsellik gözlemlenmiştir.

### Farka Ait ACF ve PACF Grafikleri

Seride trend ve baskın mevsimsellik kalmamış, durağanlaştırılmıştır.

## Ayrıştırma Yöntemleri

### Toplamsal Ayrıştırma

Veriler ile tahmin serisi uyumlu gözükmektedir. Ancak Box-Ljung testi ve ACF grafiği incelendiğinde hata serisi akgürültü serisi olmadığı için Toplamsal Ayrıştırma Yöntemi’nin uygun olmadığı görülmektedir.

### Çarpımsal Ayrıştırma

Veriler ile tahmin serisi uyumlu gözükmektedir. Ancak Box-Ljung testi ve ACF grafiği incelendiğinde hata serisi akgürültü serisi olmadığı için Çarpımsal Ayrıştırma Yöntemi’nin de uygun olmadığı görülmektedir.

## Mevsimsel Zaman Serilerinde Regresyon Analizi

### Toplamsal Regresyon

Regresyon katsayılarının tamamı anlamlı olduğu için 2. harmonik işlem uygulanır.

#### 2. Harmonik İşlem Modeli

2. harmonik işlem modelinde regresyon katsayıları anlamlı çıkmaya devam etmiştir. 3. Harmonik işlem modeli uygulanır.

#### 3. Harmonik İşlem Modeli

3. harmonik işlem modelinde “sin3” ve “cos3” regresyon katsayısı anlamsız çıkmıştır. Bütün regresyon katsayıları anlamlı olmadığı için 2. modele geri dönülür. 2. Harmonik işlem modeli uygulanır.

Durbin-Watson testi incelendiğinde istatistiği 0.83048 olarak hesaplanmış olup pozitif otokorelasyon olduğunu söyleyebiliriz. P değeri 0.05’ten küçük olduğu için yokluk hipotezi (H0<0.05) reddedilir modelin anlamlı olduğu söylenebilir.

Box-Ljung testi incelendiğinde P değeri 0.05’ten küçük olduğu için yokluk hipotezi (HS<0.05) reddedilir, hata terimleri arasında anlamlı bir otokorelasyon bulunmaktadır. ACF grafiği incelendiğinde de hataların akgürültü olmadığı gözlemlenmiştir. Toplamsal Regresyon Modeli’nin anlamlı olmadığı söylenebilir.

### Çarpımsal Regresyon

Regresyon katsayılarının tamamı anlamlı olduğu için 2. harmonik işlem uygulanır.

#### 2. Harmonik İşlem Modeli

2. harmonik işlem modelinde “sinx2” regresyon katsayısı anlamsız çıkmıştır. Bütün regresyon katsayıları anlamlı olmadığı için 1. modele geri dönülür. 1. Harmonik işlem modeli uygulanır.

Durbin-Watson testi incelendiğinde istatistiği 0.51901 olarak hesaplanmış olup pozitif otokorelasyon belirtisi olduğunu söyleyebiliriz. P değeri 0.05’ten küçük olduğu için yokluk hipotezi (HS<0.05) reddedilir modelin anlamlı olduğu söylenebilir.

Box-Ljung testi incelendiğinde P değeri 0.05’ten küçük olduğu için yokluk hipotezi (HS<0.05) reddedilir, hata terimleri arasında anlamlı bir otokorelasyon bulunmaktadır. ACF grafiği incelendiğinde de hataların akgürültü olmadığı gözlemlenmiştir. Çarpımsal Regresyon Modeli’nin anlamlı olmadığı söylenebilir.

## Üstel Düzleştirme Yöntemi

### Winters Üstel Düzleştirme Yöntemi

#### Toplamsal Winters Üstel Düzleştirme Yöntemi

Winters üstel düzleştirme yöntemine göre ortalama düzeyin başlangıç değeri 392.9168; eğimin başlangıç değeri 0.2023; mevsimsel terimin başlangıç değerleri sırasıyla:

- M10 = -0.673
- M20 = -1.9801
- M30 = -3.4701
- M40 = -3.654
- M50 = -1.8863
- M60 = 0.4189
- M70 = 2.3747
- M80 = 3.5112
- M90 = 2.9576
- M100 = 1.5358
- M110 = 0.7112
- M120 = 0.1545

Bu başlangıç değerleri kullanılarak optimal düzleştirme katsayıları α = 0.4623; β = 1e-04; γ ≅ 1e-04 olarak elde edilmiştir. Toplamsal Winters Yöntemi için HKO değerinin karekökü 0.3189255 BIC değeri 245.5314 olarak bulunmuştur.

#### Çarpımsal Winters Üstel Düzleştirme Yöntemi 

Winters üstel düzleştirme yöntemine göre ortalama düzeyin başlangıç değeri 392.4746; eğimin başlangıç değeri 0.2579; mevsimsel terimin başlangıç değerleri sırasıyla:

- M10 = 0.9983
- M20 = 0.9951
- M30 = 0.
