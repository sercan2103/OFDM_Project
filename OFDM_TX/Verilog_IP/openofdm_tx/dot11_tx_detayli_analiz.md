# dot11_tx.v Modülünün Kapsamlı ve Detaylı Analizi

Bu doküman, `dot11_tx.v` Verilog modülünün işlevselliğini, mimarisini ve içindeki ana bileşenleri **adım adım ve detaylı bir şekilde** açıklamaktadır.

## Bölüm 1: Genel Bakış

### 1.1. Modül Tanımı ve G/Ç Portları

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

### 1.2. Dahili Durumlar ve Parametreler

Modül, karmaşık bir işlemi yönetmek için üç ana Sonlu Durum Makinesi (FSM) kullanır ve çeşitli dahili `reg` (register) ve `localparam` (sabit) tanımlamaları içerir.

- **FSM1 (Veri Toplama Durumları - `state1`, `state11`)**: Bu FSM, BRAM'den paket verilerini okumak, PLCP (Physical Layer Convergence Procedure) başlığını işlemek ve veri bitlerini hazırlamaktan sorumludur.
- **FSM2 (IQ Örneği Üretim Durumları - `state2`)**: Bu FSM, kodlanmış bitleri alır, modülasyon, pilot ekleme ve IFFT (Ters Hızlı Fourier Dönüşümü) işlemlerini yönetir.
- **FSM3 (IQ Örneği İletim Durumları - `state3`)**: Bu FSM, üretilen I/Q örneklerini ve preample'ları (ön ek) doğru sırada dışarıya göndermeyi yönetir.

Bu yapı, bir 802.11 Wi-Fi paketinin fiziksel katmanda nasıl adım adım oluşturulduğunu ve gönderildiğini yöneten karmaşık bir boru hattı (pipeline) mimarisini ortaya koyar. Her FSM, bu boru hattının belirli bir aşamasından sorumludur.

## Bölüm 2: Veri Hazırlama ve Kodlama Aşaması (FSM1 Kontrolü)

### 2.1. Preample (Ön Ek) Üretim Mantığı
- **Amaç**: Alıcının sinyali algılaması, senkronize olması ve kanal durumunu tahmin etmesi için gerekli olan standart sinyalleri üretmek.
- **Yöntem**: Legacy (L-STF, L-LTF) ve High Throughput (HT-STF, HT-LTF) preample'ları için gereken sabit I/Q değerleri, verimlilik için önceden hesaplanıp ROM'larda (`l_stf_rom`, `l_ltf_rom` vb.) saklanır. FSM3, paket türüne göre doğru ROM'u seçer ve bu sinyalleri paketin en başına ekler.

### 2.2. CRC32/FCS Bloğu
- **Amaç**: Veri bütünlüğünü sağlamak.
- **Yöntem**: FSM1, BRAM'den okunan kullanıcı verisi (PSDU) üzerinden `crc32_tx` modülünü kullanarak 32-bit'lik bir Döngüsel Artıklık Kontrolü (CRC) değeri hesaplar. Bu değere Çerçeve Kontrol Dizisi (FCS) denir ve veri bloğunun sonuna eklenir. Alıcı, aynı hesaplamayı yaparak verinin iletim sırasında bozulup bozulmadığını kontrol eder.

### 2.3. Scrambler (Karıştırıcı) Operasyonu
- **Amaç**: Veri akışındaki uzun '0' veya '1' dizilerini ortadan kaldırarak sinyalin istatistiksel özelliklerini iyileştirmek.
- **Yöntem**: Veri bitleri (SERVICE, PSDU, CRC, PAD), standartta tanımlanmış bir LFSR (Doğrusal Geri Beslemeli Kaydırmalı Yazmaç) devresinden geçirilir. Bu işlem, her biti LFSR'nin o anki çıkışıyla XOR'layarak bitlerin sırasını "karıştırır". PLCP başlık alanları ve TAIL bitleri bu işleme tabi tutulmaz.

### 2.4. Konvolüsyonel Kodlayıcı
- **Amaç**: İletim sırasındaki hataları düzeltebilmek için veriye fazlalık (redundancy) eklemek (İleri Hata Düzeltme - FEC).
- **Yöntem**: Karıştırılmış bitler, `convenc` modülü aracılığıyla 1/2 oranında çalışan bir konvolüsyonel kodlayıcıya beslenir. Yani her bir giriş biti için iki çıkış biti üretilir. Bu, kablosuz kanalın gürültülü doğasına karşı sinyali daha dayanıklı hale getirir.

### 2.5. Sonlu Durum Makinesi 1 (FSM1) Detayları
- **Görevi**: Tüm veri hazırlama sürecinin beynidir. BRAM'de saklanan ham paket bilgisini okuyup, standartlara uygun, sıralı bir bit akışına dönüştürür.
- **İşleyişi**:
  1. **`S1_WAIT_PKT`**: `phy_tx_start` sinyalini bekler.
  2. **`S1_L_SIG`**: 24 bitlik L-SIG alanını okur, buradan veri hızı (`RATE`), `N_BPSC`, `N_DBPS` ve paket uzunluğu gibi kritik parametreleri çıkarır. Paketin HT formatında olup olmadığını (`PKT_TYPE`) belirler.
  3. **`S1_HT_SIG`**: Eğer paket HT ise, 48 bitlik HT-SIG alanını okuyarak MCS, Kısa Koruma Aralığı (`S_GI`) gibi HT'ye özgü parametreleri belirler.
  4. **`S1_DATA`**: `state11` alt durum makinesini kullanarak paketin gövdesini oluşturur: SERVICE, PSDU, CRC, TAIL ve PAD bitlerini sırayla işler ve akışa ekler. Bu sırada `bram_addr`'yi güncelleyerek BRAM'den yeni veriler çeker.

## Bölüm 3: OFDM Sembol Üretim Aşaması (FSM2 Kontrolü)

### 3.1. Bit Depolama FIFO'su (`bits_enc_fifo`)
- **Amaç**: FSM1 (veri hazırlama) ve FSM2 (IQ üretimi) arasındaki asenkronluğu yöneten bir arabellek (buffer) görevi görmek.
- **Yöntem**: FSM1'in ürettiği 2-bit'lik kodlanmış bitler bu FIFO'ya yazılır. FSM2, ihtiyaç duyduğunda buradan okuma yapar. Bu FIFO, FSM'ler arasındaki hız farkını dengeleyen bir "decoupling" (ayrıştırma) elemanıdır.

### 3.2. Puncturing (Delme) ve Interleaving (Serpiştirme)
- **Amaç**: Veri hızını ayarlamak ve kanal hatalarına karşı dayanıklılığı artırmak.
- **Yöntem**:
  - **Puncturing**: 1/2'den daha yüksek kodlama oranları (örn. 3/4) elde etmek için, `punc_interlv_lut` tablosundan gelen bilgiye göre kodlanmış bit akışından bazı bitler sistematik olarak atılır.
  - **Interleaving**: Kanaldaki ardışık hataların etkisini dağıtmak için, bitlerin sırası yine `punc_interlv_lut` tablosundan gelen adreslere göre `bits_ram` adlı küçük bir RAM'e yazılarak karıştırılır.
  
### 3.3. Modülasyon Bloğu
- **Amaç**: Dijital bit gruplarını, OFDM alt taşıyıcılarına yüklenecek analog I/Q sembollerine dönüştürmek.
- **Yöntem**: `bits_ram`'den okunan bit grupları, `N_BPSC` (alt taşıyıcı başına bit sayısı) parametresine göre `modulation` modülü tarafından BPSK, QPSK, 16-QAM veya 64-QAM gibi şemalar kullanılarak I/Q takımyıldız diyagramındaki bir noktaya haritalanır.

### 3.4. Pilot/DC/Yan Bant Eklenmesi
- **Amaç**: IFFT'ye giriş olarak verilecek olan tam bir OFDM sembolünü (64 alt taşıyıcı) oluşturmak.
- **Yöntem**: Modüle edilmiş veri taşıyıcılarına ek olarak, alıcının kanal takibi yapması için bilinen **Pilot Taşıyıcılar**, merkez frekansı boş bırakmak için **DC Taşıyıcı** (sıfır) ve komşu kanallara paraziti önlemek için **Yan Bant (Guard) Taşıyıcıları** (sıfır) eklenir.

### 3.5. Ters Hızlı Fourier Dönüşümü (IFFT) Bloğu
- **Amaç**: OFDM'in temelini oluşturan işlem; frekans domenindeki 64 alt taşıyıcıyı, zaman domenindeki 64 I/Q örneğine dönüştürmek.
- **Yöntem**: `ifftmain` modülü, 64 noktalı bir IFFT işlemi gerçekleştirerek zaman domeni sinyalini üretir. Bu 64 örnek, bir OFDM sembolünün "gövdesini" oluşturur.

### 3.6. Sonlu Durum Makinesi 2 (FSM2) Detayları
- **Görevi**: Bir OFDM sembolünün frekans domeninden zaman domenine dönüştürülme sürecini yönetir.
- **İşleyişi**:
  1. **`S2_PUNC_INTERLV`**: Bir sembol için gereken tüm bitleri `bits_enc_fifo`'dan okur, delme/serpiştirme işlemlerini uygular ve sonucu `bits_ram`'e yazar.
  2. **`S2_PILOT_DC_SB`**: Bir sonraki sembol için kullanılacak pilot değerlerini hesaplar.
  3. **`S2_MOD_IFFT_INPUT`**: `iq_cnt` sayacı ile 64 alt taşıyıcıyı oluşturur. Veri için `bits_ram`'den okuyup modüle eder, pilot/DC/yan bantları ekler ve sonucu IFFT'ye besler.
  4. **`S2_RESET`**: Bir sembolün işlenmesi bittiğinde, FSM1'den gelen daha fazla sembol varsa döngünün başına döner.

## Bölüm 4: Paket Oluşturma ve İletim Aşaması (FSM3 Kontrolü)

### 4.1. Döngüsel Ön Ek (CP) ve Paket FIFO'ları
- **Amaç**: Semboller arası girişimi (ISI) önlemek için Döngüsel Ön Ek (Cyclic Prefix - CP) eklemek.
- **Yöntem**: IFFT'den çıkan 64 örneklik sembolün tamamı `pkt_fifo`'ya yazılırken, aynı anda sembolün son 16 (veya 8) örneği de `CP_fifo`'ya yazılır. FSM3, sembolü gönderirken önce `CP_fifo`'yu, sonra `pkt_fifo`'yu okuyarak CP'yi sembolün başına otomatik olarak eklemiş olur. Bu, verimli bir donanım tekniğidir.

### 4.2. Sonlu Durum Makinesi 3 (FSM3) Detayları
- **Görevi**: Tüm paketin zaman içindeki sıralamasını yöneten "orkestra şefidir".
- **İşleyişi**:
  1. **`S3_WAIT_PKT`**: `phy_tx_start` sinyalini bekler.
  2. **Preamble Durumları (`S3_L_STF`, `S3_L_LTF`, vb.)**: `preamble_addr` sayacını kullanarak ilgili ROM'lardan preample I/Q örneklerini okur ve çıkışa yönlendirir.
  3. **SIGNAL/DATA Durumları (`S3_L_SIG`, `S3_DATA`, vb.)**: I/Q örneklerini önce `CP_fifo`'dan, sonra `pkt_fifo`'dan okuyarak CP eklenmiş tam OFDM sembollerini gönderir.
  4. **Paket Sonu**: Gönderilmesi gereken toplam I/Q örneği sayısına ulaşıldığında `phy_tx_done` sinyalini '1' yapar ve tüm modülü bir sonraki paket için sıfırlayan `FSM3_reset` sinyalini üretir.

### 4.3. Son Çıkış Ataması
- **Amaç**: FSM3'ün kararlarına göre doğru I/Q kaynağını modülün nihai çıkışına yönlendirmek.
- **Yöntem**: `assign` ifadeleri ile yapılan büyük bir çoklayıcı (multiplexer) yapısıdır. `state3`'ün o anki durumuna göre çıkışa ya bir preamble ROM'undan (`l_stf`, `l_ltf` vb.) gelen değeri ya da `fifo_turn`'e bağlı olarak `pkt_fifo_odata` veya `CP_fifo_odata` değerini atar. `result_iq_valid` sinyali de benzer şekilde, seçilen kaynağın geçerli bir veri sağlayıp sağlamadığına göre ayarlanır.

## Bölüm 5: Özet ve Genel İşlevsellik

`dot11_tx.v` modülü, modern bir 802.11 vericisinin dijital temel bant işlemlerini gerçekleştiren, iyi yapılandırılmış ve oldukça karmaşık bir donanım tasarımıdır. Üç ana FSM'nin yönettiği boru hattı mimarisi, ham veriden I/Q sinyallerine kadar olan tüm dönüşüm sürecini verimli bir şekilde yönetir.

**Özetle, modülün yaptığı iş şudur**:
1.  Bir paket gönderme komutu alır.
2.  Paketin hızını ve uzunluğunu başlığından okur.
3.  Veriyi hata kontrolü (CRC) ve hata düzeltme (Konvolüsyonel Kodlama) için hazırlar.
4.  Veriyi karıştırır (Scrambling), hızını ayarlar (Puncturing) ve hatalara karşı dayanıklılığını artırır (Interleaving).
5.  Bitleri I/Q sembollerine modüle eder.
6.  Bu sembolleri, pilot ve diğer kontrol taşıyıcılarıyla birleştirerek frekans domeninde OFDM sembolleri oluşturur.
7.  IFFT ile bu sembolleri zaman domenine çevirir.
8.  Çok yollu sönümlemeye karşı korumak için Döngüsel Ön Ek (CP) ekler.
9.  Paketin en başına alıcı senkronizasyonu için Preample'ları ekler.
10. Tüm bu bileşenleri doğru sırada birleştirerek nihai I/Q sinyalini üretir ve bir sonraki aşama olan DAC'a gönderir.
