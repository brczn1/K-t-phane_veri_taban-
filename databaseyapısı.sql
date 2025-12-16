-- Database: database_ödevi

-- 1. Tabloları oluştur
CREATE TABLE yazarlar (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(100) NOT NULL,
    soyad VARCHAR(100) NOT NULL
);

CREATE TABLE "yayinevleri"(
    "id" SERIAL NOT NULL,
    "ad" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "yayinevleri" ADD PRIMARY KEY("id");


CREATE TABLE kategoriler (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(100) NOT NULL
);

CREATE TABLE uyeler (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(100) NOT NULL,
    soyad VARCHAR(100) NOT NULL
);
Alter table uyeler 
add "eposta" VARCHAR(255),
add  "telefon" VARCHAR(20);


CREATE TABLE kitaplar (
    id SERIAL PRIMARY KEY,
    baslik VARCHAR(300) NOT NULL,
    yazar_id INTEGER REFERENCES yazarlar(id),
    kategori_id INTEGER REFERENCES kategoriler(id),
    stok INTEGER DEFAULT 1
);
alter table kitaplar 
add "yayinevi_id" INTEGER,
add "isbn" VARCHAR(20);

CREATE TABLE odunc_kayitlari (
    id SERIAL PRIMARY KEY,
    kitap_id INTEGER REFERENCES kitaplar(id),
    uye_id INTEGER REFERENCES uyeler(id),
    odunc_alma_tarihi DATE DEFAULT CURRENT_DATE,
    planlanan_iade_tarihi DATE
);

-- Doğru tablo ismiyle kolon ekle
ALTER TABLE odunc_kayitlari  -- ✔ DOĞRU: "odunc_kayitlari"
ADD COLUMN gercek_iade_tarihi DATE;


CREATE TABLE "rezervasyonlar"(
    "id" SERIAL NOT NULL,
    "kitap_id" INTEGER NOT NULL,
    "uye_id" INTEGER NOT NULL,
    "rezervasyon_tarihi" DATE DEFAULT CURRENT_DATE,
    "durum" VARCHAR(20) DEFAULT 'beklemede'
);
ALTER TABLE
    "rezervasyonlar" ADD PRIMARY KEY("id");

CREATE TABLE "ceza_kayitlari"(
    "id" SERIAL NOT NULL,
    "odunc_id" INTEGER NOT NULL,
    "ceza_miktari" DECIMAL(10, 2) NOT NULL,
    "odeme_durumu" VARCHAR(20) DEFAULT 'odenmedi'
);
ALTER TABLE
    "ceza_kayitlari" ADD PRIMARY KEY("id");

-- 2. Örnek veri ekle
INSERT INTO yazarlar (ad, soyad) VALUES ('Yazar1', 'Soyad1'), ('Yazar2', 'Soyad2');
INSERT INTO kategoriler (ad) VALUES ('Roman'), ('Şiir');
INSERT INTO uyeler (ad, soyad) VALUES ('Ahmet', 'Yılmaz'), ('Ayşe', 'Kaya');
INSERT INTO kitaplar (baslik, yazar_id, kategori_id, stok) 
VALUES ('Kitap 1', 1, 1, 5), ('Kitap 2', 2, 2, 3);

-- 3. Kontrol et
SELECT * FROM yazarlar;
SELECT * FROM kitaplar;


-- FOREIGN KEY KISITLAMALARI
ALTER TABLE
    "kitaplar" ADD CONSTRAINT "kitaplar_yazar_id_foreign" FOREIGN KEY("yazar_id") REFERENCES "yazarlar"("id");
ALTER TABLE
    "kitaplar" ADD CONSTRAINT "kitaplar_yayinevi_id_foreign" FOREIGN KEY("yayinevi_id") REFERENCES "yayinevleri"("id");
ALTER TABLE
    "kitaplar" ADD CONSTRAINT "kitaplar_kategori_id_foreign" FOREIGN KEY("kategori_id") REFERENCES "kategoriler"("id");

ALTER TABLE
    "odunc_kayitlari" ADD CONSTRAINT "odunc_kayitlari_kitap_id_foreign" FOREIGN KEY("kitap_id") REFERENCES "kitaplar"("id");
ALTER TABLE
    "odunc_kayitlari" ADD CONSTRAINT "odunc_kayitlari_uye_id_foreign" FOREIGN KEY("uye_id") REFERENCES "uyeler"("id");

ALTER TABLE
    "rezervasyonlar" ADD CONSTRAINT "rezervasyonlar_kitap_id_foreign" FOREIGN KEY("kitap_id") REFERENCES "kitaplar"("id");
ALTER TABLE
    "rezervasyonlar" ADD CONSTRAINT "rezervasyonlar_uye_id_foreign" FOREIGN KEY("uye_id") REFERENCES "uyeler"("id");

ALTER TABLE
    "ceza_kayitlari" ADD CONSTRAINT "ceza_kayitlari_odunc_id_foreign" FOREIGN KEY("odunc_id") REFERENCES "odunc_kayitlari"("id");

-- TEKLİ KISITLAMALAR
ALTER TABLE
    "ceza_kayitlari" ADD CONSTRAINT "ceza_kayitlari_odunc_id_unique" UNIQUE("odunc_id");



	-- 1. YAZARLAR - 10 yazar ekle
INSERT INTO yazarlar (ad, soyad) VALUES
('Sabahattin', 'Ali'),
('Orhan', 'Pamuk'),
('Elif', 'Şafak'),
('Yaşar', 'Kemal'),
('Ahmet', 'Hamdi Tanpınar'),
('Halide Edib', 'Adıvar'),
('Reşat Nuri', 'Güntekin'),
('Oğuz', 'Atay'),
('Sait Faik', 'Abasıyanık'),
('Nazım', 'Hikmet');

-- 2. YAYINEVLERİ - 5 yayınevi
INSERT INTO yayinevleri (ad) VALUES
('Yapı Kredi Yayınları'),
('İletişim Yayınları'),
('Can Yayınları'),
('İş Bankası Kültür Yayınları'),
('Everest Yayınları');

-- 3. KATEGORİLER - 8 kategori
INSERT INTO kategoriler (ad) VALUES
('Roman'),
('Şiir'),
('Öykü'),
('Biyografi'),
('Tarih'),
('Bilim Kurgu'),
('Polisiye'),
('Çocuk Kitapları');

-- 4. ÜYELER - 15 üye (telefon ve email ile)
INSERT INTO uyeler (ad, soyad, eposta, telefon) VALUES
('Ahmet', 'Yılmaz', 'ahmet.yilmaz@email.com', '5551112233'),
('Ayşe', 'Kaya', 'ayse.kaya@email.com', '5552223344'),
('Mehmet', 'Demir', 'mehmet.demir@email.com', '5553334455'),
('Fatma', 'Çelik', 'fatma.celik@email.com', '5554445566'),
('Ali', 'Şahin', 'ali.sahin@email.com', '5555556677'),
('Zeynep', 'Arslan', 'zeynep.arslan@email.com', '5556667788'),
('Can', 'Yıldız', 'can.yildiz@email.com', '5557778899'),
('Seda', 'Koç', 'seda.koc@email.com', '5558889900'),
('Burak', 'Polat', 'burak.polat@email.com', '5559990011'),
('Deniz', 'Tekin', 'deniz.tekin@email.com', '5550001122'),
('Ebru', 'Aksoy', 'ebru.aksoy@email.com', '5551122334'),
('Cem', 'Öztürk', 'cem.ozturk@email.com', '5552233445'),
('Gizem', 'Korkmaz', 'gizem.korkmaz@email.com', '5553344556'),
('Hakan', 'Erdoğan', 'hakan.erdogan@email.com', '5554455667'),
('İrem', 'Çetin', 'irem.cetin@email.com', '5555566778');

-- 5. KİTAPLAR - 20 kitap (gerçek Türk edebiyatı kitapları)
INSERT INTO kitaplar (baslik, yazar_id, yayinevi_id, kategori_id, isbn, stok) VALUES
('Kürk Mantolu Madonna', 1, 1, 1, '9789753638020', 5),
('Kara Kitap', 2, 2, 1, '9789754703641', 3),
('Aşk', 3, 3, 1, '9789750719899', 4),
('İnce Memed', 4, 4, 1, '9789750807947', 6),
('Saatleri Ayarlama Enstitüsü', 5, 5, 1, '9789754589192', 2),
('Sinekli Bakkal', 6, 4, 1, '9786052954392', 3),
('Çalıkuşu', 7, 3, 1, '9789750701658', 7),
('Tutunamayanlar', 8, 2, 1, '9789754700114', 2),
('Medarı Maişet Motoru', 9, 1, 3, '9789753638051', 4),
('Memleketimden İnsan Manzaraları', 10, 4, 2, '9789754588874', 3),
('Serenad', 3, 5, 1, '9789752898342', 5),
('Benim Adım Kırmızı', 2, 1, 1, '9789750807558', 4),
('Mai ve Siyah', 5, 4, 1, '9789754588447', 2),
('Araba Sevdası', 5, 3, 1, '9789754588263', 3),
('Huzur', 5, 2, 1, '9789754700138', 2),
('Masumiyet Müzesi', 2, 1, 1, '9789750820564', 4),
('Kuyucaklı Yusuf', 1, 4, 1, '9789754588812', 3),
('Yaban', 6, 3, 1, '9789754588317', 2),
('Fahrenheit 451', NULL, 2, 6, '9789750824289', 5), -- Yabancı yazar
('Sherlock Holmes', NULL, 5, 7, '9786051736787', 4); -- Yabancı yazar

-- 6. ÖDÜNÇ KAYITLARI - 25 kayıt
INSERT INTO odunc_kayitlari (kitap_id, uye_id, odunc_alma_tarihi, planlanan_iade_tarihi, gercek_iade_tarihi) VALUES
-- Aktif ödünçler (henüz iade edilmemiş)
(1, 1, '2024-01-10', '2024-01-24', NULL),
(3, 2, '2024-01-15', '2024-01-29', NULL),
(5, 3, '2024-01-18', '2024-02-01', NULL),

-- Zamanında iade edilenler
(2, 4, '2023-12-01', '2023-12-15', '2023-12-14'),
(4, 5, '2023-12-05', '2023-12-19', '2023-12-18'),
(6, 6, '2023-12-10', '2023-12-24', '2023-12-23'),

-- Gecikmeli iade edilenler (ceza olacak)
(7, 7, '2023-11-01', '2023-11-15', '2023-11-20'), -- 5 gün gecikme
(8, 8, '2023-11-10', '2023-11-24', '2023-12-05'), -- 11 gün gecikme
(9, 9, '2023-11-15', '2023-11-29', '2023-12-10'), -- 11 gün gecikme

-- Diğer örnek kayıtlar
(10, 10, '2023-10-01', '2023-10-15', '2023-10-14'),
(11, 11, '2023-10-05', '2023-10-19', '2023-10-18'),
(12, 12, '2023-10-10', '2023-10-24', '2023-10-23'),
(13, 13, '2023-10-15', '2023-10-29', '2023-10-28'),
(14, 14, '2023-10-20', '2023-11-03', '2023-11-02'),
(15, 15, '2023-10-25', '2023-11-08', '2023-11-07'),
(16, 1, '2023-09-01', '2023-09-15', '2023-09-14'),
(17, 2, '2023-09-05', '2023-09-19', '2023-09-18'),
(18, 3, '2023-09-10', '2023-09-24', '2023-09-23'),
(19, 4, '2023-09-15', '2023-09-29', '2023-09-28'),
(20, 5, '2023-09-20', '2023-10-04', '2023-10-03'),
(1, 6, '2023-08-01', '2023-08-15', '2023-08-14'),
(2, 7, '2023-08-05', '2023-08-19', '2023-08-18'),
(3, 8, '2023-08-10', '2023-08-24', '2023-08-23'),
(4, 9, '2023-08-15', '2023-08-29', '2023-08-28');

-- 7. REZERVASYONLAR - 8 rezervasyon
INSERT INTO rezervasyonlar (kitap_id, uye_id, rezervasyon_tarihi, durum) VALUES
-- Beklemede olanlar
(1, 7, '2024-01-20', 'beklemede'),  -- Kürk Mantolu Madonna rezerve
(3, 8, '2024-01-18', 'beklemede'),  -- Aşk rezerve
(5, 9, '2024-01-16', 'beklemede'),  -- Saatleri Ayarlama Enstitüsü rezerve

-- Onaylanmış
(2, 10, '2024-01-10', 'onaylandi'), -- Kara Kitap
(4, 11, '2024-01-12', 'onaylandi'), -- İnce Memed

-- İptal edilmiş
(6, 12, '2024-01-05', 'iptal'),     -- Sinekli Bakkal
(7, 13, '2024-01-03', 'iptal'),     -- Çalıkuşu

-- Aktif rezervasyon
(8, 14, '2024-01-22', 'beklemede'); -- Tutunamayanlar

-- 8. CEZA KAYITLARI - 3 ceza kaydı (gecikmeli iadeler için)
INSERT INTO ceza_kayitlari (odunc_id, ceza_miktari, odeme_durumu) VALUES
(7, 25.00, 'odenmedi'),  -- 5 gün gecikme (5*5=25 TL)
(8, 55.00, 'odendi'),    -- 11 gün gecikme (11*5=55 TL)
(9, 55.00, 'odenmedi');  -- 11 gün gecikme
