# dot11_tx.v Modülünün Detaylı Analizi

Bu doküman, `dot11_tx.v` Verilog modülünün işlevselliğini, mimarisini ve içindeki ana bileşenleri adım adım açıklamaktadır.

## 1. Modül Tanımı ve G/Ç Portları

Modül, bir 802.11 (Wi-Fi) vericisinin dijital temel bant (baseband) işlemcisinin çekirdeğini oluşturur. Görevi, üst katmandan (MAC) gelen paket verilerini alıp, standartlara uygun olarak işleyerek bir DAC (Dijital-Analog Çevirici) tarafından gönderilebilecek I/Q (In-phase ve Quadrature) sinyal örneklerine dönüştürmektir.

- **Girişler**:
  - `clk`, `phy_tx_arest`: Temel saat ve reset sinyalleri.
  - `phy_tx_start`: Veri gönderme işlemini başlatan tetikleyici.
  - `init_pilot_scram_state`, `init_data_scram_state`: Scrambler (karıştırıcı) devrelerinin başlangıç durumları.
  - `bram_din`: Gönderilecek paketin verilerini içeren Blok RAM'den gelen veri.
  - `result_iq_ready`: Bir sonraki modülün (DAC arayüzü) yeni bir I/Q örneği almaya hazır olduğunu belirtir.

- **Çıkışlar**:
  - `phy_tx_done`, `phy_tx_started`: Gönderme işleminin başladığını ve bittiğini bildiren durum sinyalleri.
  - `bram_addr`: Blok RAM'den veri okumak için kullanılan adres.
  - `result_iq_valid`: Çıkıştaki I/Q örneğinin geçerli olduğunu belirtir.
  - `result_i`, `result_q`: Üretilen 16-bit'lik I ve Q sinyal örnekleri.

## 2. Genel Mimarisi ve Sonlu Durum Makineleri (FSM)

Modül, karmaşık gönderme sürecini yönetmek için üç ana Sonlu Durum Makinesi (FSM) üzerine kurulu bir boru hattı (pipeline) mimarisi kullanır:

- **FSM1 (Veri Hazırlama)**: BRAM'den ham veriyi okur, paketin başlığını (PLCP header) analiz eder, hız ve uzunluk gibi parametreleri belirler ve standartlara uygun olarak SERVICE, PSDU (asıl veri), CRC, TAIL ve PAD bitlerinden oluşan sıralı bir bit akışı oluşturur.
- **FSM2 (IQ Örneği Üretimi)**: FSM1'den gelen bit akışını alır ve bir OFDM sembolünü oluşturmak için gereken tüm işlemleri (Puncturing, Interleaving, Modülasyon, Pilot Ekleme, IFFT) yönetir.
- **FSM3 (IQ Örneği İletimi)**: Üretilen I/Q örneklerini ve preample (ön ek) sinyallerini doğru sırada birleştirerek modülün çıkışına gönderir.

Bu FSM'ler arasındaki veri akışı, FIFO'lar (First-In, First-Out tampon bellekler) aracılığıyla yönetilir, bu da her bir FSM'nin kendi hızında çalışmasına olanak tanıyarak sistemin verimliliğini artırır.

## 3. Adım Adım Veri Akışı ve İşlemler

### Adım 1: Preample (Ön Ek) Üretimi
- **Amaç**: Alıcının sinyali algılaması, senkronize olması ve kanal durumunu tahmin etmesi için gerekli olan standart sinyalleri üretmek.
- **Yöntem**: Legacy (L-STF, L-LTF) ve High Throughput (HT-STF, HT-LTF) preample'ları için gereken sabit I/Q değerleri, verimlilik için önceden hesaplanıp ROM'larda (Read-Only Memory) saklanır. FSM3, paket türüne göre doğru ROM'u seçer ve bu sinyalleri paketin en başına ekler.

### Adım 2: CRC32/FCS Hesaplama
- **Amaç**: Veri bütünlüğünü sağlamak.
- **Yöntem**: FSM1, BRAM'den okunan kullanıcı verisi (PSDU) üzerinden 32-bit'lik bir Döngüsel Artıklık Kontrolü (CRC) değeri hesaplar. Bu değere Çerçeve Kontrol Dizisi (FCS) denir ve veri bloğunun sonuna eklenir. Alıcı, aynı hesaplamayı yaparak verinin iletim sırasında bozulup bozulmadığını kontrol eder.

### Adım 3: Scrambling (Karıştırma)
- **Amaç**: Veri akışındaki uzun '0' veya '1' dizilerini ortadan kaldırarak sinyalin istatistiksel özelliklerini iyileştirmek.
- **Yöntem**: Veri bitleri (SERVICE, PSDU, CRC, PAD), standartta tanımlanmış bir LFSR (Doğrusal Geri Beslemeli Kaydırmalı Yazmaç) devresinden geçirilir. Bu işlem, her biti LFSR'nin o anki çıkışıyla XOR'layarak bitlerin sırasını "karıştırır". PLCP başlık alanları ve TAIL bitleri bu işleme tabi tutulmaz.

### Adım 4: Konvolüsyonel Kodlama
- **Amaç**: İletim sırasındaki hataları düzeltebilmek için veriye fazlalık (redundancy) eklemek (İleri Hata Düzeltme - FEC).
- **Yöntem**: Karıştırılmış bitler, 1/2 oranında çalışan bir konvolüsyonel kodlayıcıya beslenir. Yani her bir giriş biti için iki çıkış biti üretilir. Bu, kablosuz kanalın gürültülü doğasına karşı sinyali daha dayanıklı hale getirir.

### Adım 5: Puncturing (Delme) ve Interleaving (Serpiştirme)
- **Amaç**: Veri hızını ayarlamak ve kanal hatalarına karşı dayanıklılığı artırmak.
- **Yöntem**:
  - **Puncturing**: 1/2'den daha yüksek kodlama oranları (örn. 3/4) elde etmek için, konvolüsyonel kodlayıcıdan çıkan bazı bitler sistematik olarak atılır.
  - **Interleaving**: Kanaldaki ardışık hataların etkisini dağıtmak için, bitlerin sırası belirli bir kalıba göre karıştırılır. Bu, alıcıdaki kod çözücünün performansını artırır.
- Bu iki işlem, veri hızına bağlı olarak bir Arama Tablosu (LUT) tarafından kontrol edilir.

### Adım 6: Modülasyon
- **Amaç**: Dijital bit gruplarını, OFDM alt taşıyıcılarına yüklenecek analog I/Q sembollerine dönüştürmek.
- **Yöntem**: Puncturing ve Interleaving sonrası elde edilen bitler, `N_BPSC` (alt taşıyıcı başına bit sayısı) parametresine göre gruplanır. Bu gruplar, BPSK, QPSK, 16-QAM veya 64-QAM gibi modülasyon şemaları kullanılarak I/Q takımyıldız diyagramındaki bir noktaya haritalanır.

### Adım 7: Alt Taşıyıcı Ataması (Pilot, DC, Yan Bant Ekleme)
- **Amaç**: IFFT'ye giriş olarak verilecek olan tam bir OFDM sembolünü (64 alt taşıyıcı) oluşturmak.
- **Yöntem**: Modüle edilmiş veri taşıyıcılarına ek olarak:
  - **Pilot Taşıyıcılar**: Alıcının kanal takibi yapması için bilinen referans sinyalleri eklenir.
  - **DC Taşıyıcı**: Merkez frekans (0 Hz) boş bırakılır.
  - **Yan Bant (Guard) Taşıyıcıları**: Kanalın kenarlarındaki taşıyıcılar, komşu kanallara paraziti önlemek için boş bırakılır.

### Adım 8: Ters Hızlı Fourier Dönüşümü (IFFT)
- **Amaç**: OFDM'in temelini oluşturan işlem; frekans domenindeki 64 alt taşıyıcıyı, zaman domenindeki 64 I/Q örneğine dönüştürmek.
- **Yöntem**: 64 noktalı bir IFFT donanım bloğu, hazırlanan alt taşıyıcıları alarak zaman domeni sinyalini üretir. Bu 64 örnek, bir OFDM sembolünün "gövdesini" oluşturur.

### Adım 9: Döngüsel Ön Ek (Cyclic Prefix - CP) Ekleme
- **Amaç**: Semboller arası girişimi (ISI) önlemek.
- **Yöntem**: IFFT'den çıkan 64 örneklik sembol gövdesinin son 16 örneği (veya kısa koruma aralığı için 8) kopyalanarak sembolün başına eklenir. Bu işlem, iki ayrı FIFO kullanılarak akıllıca ve verimli bir şekilde gerçekleştirilir.

### Adım 10: Çıkış Yönetimi
- **Amaç**: Tüm paket bileşenlerini doğru sırada birleştirip çıkışa göndermek.
- **Yöntem**: FSM3, orkestra şefi olarak görev yapar. `phy_tx_start` ile başlayarak, önce Preample ROM'larından okuma yapar. Ardından, FSM2 tarafından üretilip FIFO'larda depolanan L-SIG, HT-SIG ve DATA sembollerini (CP + gövde) sırayla okuyarak `result_i` ve `result_q` çıkışlarına yönlendirir. Tüm paket gönderildiğinde `phy_tx_done` sinyalini üretir.

## 4. Sonuç

`dot11_tx.v` modülü, modern bir 802.11 vericisinin dijital temel bant işlemlerini gerçekleştiren, iyi yapılandırılmış ve oldukça karmaşık bir donanım tasarımıdır. Üç ana FSM'nin yönettiği boru hattı mimarisi, ham veriden I/Q sinyallerine kadar olan tüm dönüşüm sürecini verimli bir şekilde yönetir. Her bir alt blok (CRC, Scrambler, Kodlayıcı, IFFT vb.), Wi-Fi standardının fiziksel katman (PHY) gereksinimlerini karşılamak üzere dikkatlice tasarlanmıştır.
