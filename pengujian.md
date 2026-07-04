# 📋 Laporan Hasil Pengujian Smart Contract `DoctorSchedule`

**Kontrak :** `DoctorSchedule`
**File     :** `JadwalPraktikDokterMandiri.sol`
**Compiler :** Solidity ^0.8.0
**Jaringan :** Ethereum (Remix VM)
**Tanggal  :** 2025

---

## 1. 🧪 Pengujian Fungsional

> Memastikan setiap fungsi berjalan sesuai spesifikasi yang diharapkan.

| No | ID Uji | Fungsi yang Diuji | Skenario | Data Input | Hasil yang Diharapkan | Hasil Aktual | Status |
|----|--------|-------------------|----------|------------|-----------------------|--------------|--------|
| 1 | PF-01 | `registerDoctor()` | Dokter baru mendaftar dengan data lengkap | name="Dr. Andi", specialization="Umum", scheduleDetails="Senin 08.00-12.00" | Data tersimpan, event `DoctorRegistered` terpancar | Data tersimpan di mapping, event terpancar | ✅ PASS |
| 2 | PF-02 | `registerDoctor()` | Address terdaftar masuk ke `doctorAddresses[]` | name="Dr. Andi", specialization="Umum", scheduleDetails="Senin 08.00-12.00" | `doctorAddresses[0]` berisi address pengirim | Address tercatat di array | ✅ PASS |
| 3 | PF-03 | `updateSchedule()` | Dokter terdaftar memperbarui jadwal | newSchedule="Selasa 13.00-17.00" | Jadwal berubah, event `ScheduleUpdated` terpancar | Jadwal diperbarui, event terpancar | ✅ PASS |
| 4 | PF-04 | `getDoctorInfo()` | Pasien mengambil info dokter yang terdaftar | _doctorAddress = address dokter valid | Mengembalikan name, specialization, scheduleDetails | Data dokter dikembalikan dengan benar | ✅ PASS |
| 5 | PF-05 | `getAllDoctors()` | Mengambil seluruh daftar address dokter | — (tanpa input) | Array berisi semua address dokter terdaftar | Array dikembalikan lengkap | ✅ PASS |
| 6 | PF-06 | `doctors()` (public mapping) | Membaca data dokter langsung via mapping | address dokter | Struct Doctor dengan semua field | Struct dikembalikan dengan benar | ✅ PASS |

---

## 2. 📏 Pengujian Boundary Value (Nilai Batas)

> Menguji perilaku sistem pada nilai-nilai batas minimum dan maksimum input string.

| No | ID Uji | Fungsi yang Diuji | Skenario | Data Input | Hasil yang Diharapkan | Hasil Aktual | Status |
|----|--------|-------------------|----------|------------|-----------------------|--------------|--------|
| 1 | PB-01 | `registerDoctor()` | Input nama dengan 1 karakter (minimum) | name="A", specialization="B", scheduleDetails="C" | Berhasil terdaftar | Terdaftar tanpa error | ✅ PASS |
| 2 | PB-02 | `registerDoctor()` | Input nama dengan string kosong `""` | name="", specialization="Umum", scheduleDetails="Senin" | Terdaftar (kontrak tidak membatasi string kosong) | Terdaftar tanpa error | ⚠️ PASS* |
| 3 | PB-03 | `registerDoctor()` | Input semua field dengan string kosong `""` | name="", specialization="", scheduleDetails="" | Terdaftar (tidak ada validasi panjang) | Terdaftar tanpa error | ⚠️ PASS* |
| 4 | PB-04 | `registerDoctor()` | Input nama sangat panjang (>500 karakter) | name="Dr. Andi..." (500+ karakter) | Berhasil, namun gas meningkat | Terdaftar, gas tinggi | ✅ PASS |
| 5 | PB-05 | `updateSchedule()` | Update jadwal dengan string kosong `""` | newSchedule="" | Jadwal diperbarui menjadi kosong | Jadwal kosong tersimpan | ⚠️ PASS* |
| 6 | PB-06 | `getAllDoctors()` | Memanggil saat belum ada dokter terdaftar | — | Mengembalikan array kosong `[]` | Array kosong dikembalikan | ✅ PASS |
| 7 | PB-07 | `getDoctorInfo()` | Memanggil dengan address `0x000...0` (zero address) | _doctorAddress = 0x0000000000000000000000000000000000000000 | Revert "Dokter tidak ditemukan." | Revert sesuai | ✅ PASS |

> *⚠️ PASS: Fungsi tidak error, namun validasi input kosong disarankan ditambahkan untuk keamanan data.

---

## 3. ⚠️ Pengujian Exception Handling (Penanganan Kesalahan)

> Memastikan kontrak menolak input tidak valid dan mengembalikan pesan error yang tepat.

| No | ID Uji | Fungsi yang Diuji | Skenario | Data Input | Pesan Error yang Diharapkan | Pesan Error Aktual | Status |
|----|--------|-------------------|----------|------------|-----------------------------|--------------------|--------|
| 1 | PE-01 | `registerDoctor()` | Dokter mendaftar dua kali dengan address yang sama | Panggil `registerDoctor()` dua kali dari address yang sama | `"Akun ini sudah terdaftar sebagai dokter."` | `"Akun ini sudah terdaftar sebagai dokter."` | ✅ PASS |
| 2 | PE-02 | `updateSchedule()` | Wallet yang belum terdaftar mencoba update jadwal | Panggil `updateSchedule()` dari address baru | `"Hanya dokter yang terdaftar yang dapat mengubah jadwal."` | `"Hanya dokter yang terdaftar yang dapat mengubah jadwal."` | ✅ PASS |
| 3 | PE-03 | `getDoctorInfo()` | Mencari info dokter dengan address yang tidak terdaftar | _doctorAddress = address acak tidak terdaftar | `"Dokter tidak ditemukan."` | `"Dokter tidak ditemukan."` | ✅ PASS |
| 4 | PE-04 | `updateSchedule()` | Pasien (bukan dokter) mencoba mengubah jadwal | Panggil dari address pasien yang tidak pernah `registerDoctor()` | `"Hanya dokter yang terdaftar yang dapat mengubah jadwal."` | `"Hanya dokter yang terdaftar yang dapat mengubah jadwal."` | ✅ PASS |
| 5 | PE-05 | `getDoctorInfo()` | Memanggil dengan address zero | _doctorAddress = 0x000...0 | `"Dokter tidak ditemukan."` | `"Dokter tidak ditemukan."` | ✅ PASS |
| 6 | PE-06 | `registerDoctor()` | Mengirim ETH ke fungsi `registerDoctor()` | msg.value = 1 ETH | Transaksi revert (fungsi tidak payable) | Revert: fungsi tidak payable | ✅ PASS |

---

## 4. 🔄 Pengujian State Transition (Transisi Status)

> Memastikan status/state data kontrak berubah dengan benar sesuai urutan operasi.

| No | ID Uji | Kondisi Awal | Aksi / Fungsi | Kondisi Akhir yang Diharapkan | Kondisi Akhir Aktual | Status |
|----|--------|--------------|---------------|-------------------------------|----------------------|--------|
| 1 | PS-01 | Dokter belum terdaftar (`isRegistered = false`) | `registerDoctor()` dipanggil | `isRegistered = true`, data tersimpan, address masuk array | `isRegistered = true`, data tersimpan | ✅ PASS |
| 2 | PS-02 | Dokter sudah terdaftar (`isRegistered = true`) | `registerDoctor()` dipanggil lagi | State tidak berubah, transaksi revert | Revert, state tetap | ✅ PASS |
| 3 | PS-03 | Dokter terdaftar, jadwal = "Senin 08.00" | `updateSchedule("Selasa 13.00")` dipanggil | `scheduleDetails = "Selasa 13.00"`, field lain tidak berubah | Jadwal berubah, field lain tetap | ✅ PASS |
| 4 | PS-04 | Dokter terdaftar, jadwal = "Selasa 13.00" | `updateSchedule("Rabu 09.00")` dipanggil lagi | `scheduleDetails = "Rabu 09.00"` (update berulang diizinkan) | Jadwal berhasil diperbarui kembali | ✅ PASS |
| 5 | PS-05 | Belum ada dokter terdaftar | `getAllDoctors()` dipanggil | Array kosong `[]` dikembalikan | Array kosong | ✅ PASS |
| 6 | PS-06 | 1 dokter terdaftar | Dokter kedua memanggil `registerDoctor()` | `doctorAddresses[]` berisi 2 address | Array berisi 2 address | ✅ PASS |
| 7 | PS-07 | 2 dokter terdaftar | `getAllDoctors()` dipanggil | Array berisi 2 address dokter | Array berisi 2 address | ✅ PASS |
| 8 | PS-08 | Dokter terdaftar | `getDoctorInfo(address)` dipanggil | Data dokter dikembalikan tanpa mengubah state | Data dikembalikan, state tidak berubah | ✅ PASS |

**Diagram Transisi State:**
```
[Belum Terdaftar] ──registerDoctor()──▶ [Terdaftar]
                                              │
                                    updateSchedule() (loop)
                                              │
                                              ▼
                                    [Jadwal Diperbarui]
```

---

## 5. 🔐 Pengujian Keamanan

> Memastikan kontrak terlindung dari akses tidak sah dan celah keamanan umum.

| No | ID Uji | Kategori Keamanan | Skenario Serangan / Uji | Metode Uji | Hasil yang Diharapkan | Hasil Aktual | Status |
|----|--------|-------------------|-------------------------|------------|-----------------------|--------------|--------|
| 1 | PK-01 | Akses Tidak Sah | Aktor lain mencoba mengubah jadwal dokter A menggunakan address berbeda | Panggil `updateSchedule()` dari address B untuk mengubah data dokter A | Revert, hanya `msg.sender` yang dapat mengubah datanya sendiri | Revert: "Hanya dokter yang terdaftar..." | ✅ AMAN |
| 2 | PK-02 | Akses Tidak Sah | Pasien mencoba memanggil `updateSchedule()` | Panggil dari address yang tidak pernah `registerDoctor()` | Revert dengan pesan error | Revert sesuai | ✅ AMAN |
| 3 | PK-03 | Reentrancy | Kontrak tidak menerima ETH dan tidak memanggil kontrak eksternal | Analisis kode — tidak ada `call`, `transfer`, `send` | Tidak rentan reentrancy | Tidak ada celah reentrancy | ✅ AMAN |
| 4 | PK-04 | Integer Overflow/Underflow | Operasi aritmatika pada kontrak | Analisis kode — tidak ada operasi aritmatika manual | Solidity ^0.8.0 sudah built-in overflow protection | Tidak ada risiko overflow | ✅ AMAN |
| 5 | PK-05 | Manipulasi Data Orang Lain | Dokter A mencoba menimpa data dokter B | Panggil `registerDoctor()` dari address A (sudah terdaftar) | Revert, data dokter B tidak berubah | Revert: "Sudah terdaftar" | ✅ AMAN |
| 6 | PK-06 | Front-Running | Transaksi `registerDoctor()` dapat diamati di mempool | Analisis — data yang diekspos hanya nama & jadwal, bukan aset finansial | Risiko rendah, tidak ada kerugian finansial | Risiko minimal | ✅ AMAN |
| 7 | PK-07 | Denial of Service (DoS) | Mendaftarkan sangat banyak dokter hingga array `doctorAddresses[]` sangat besar | Daftarkan ratusan address berbeda | `getAllDoctors()` berpotensi kehabisan gas pada skala besar | Gas meningkat seiring jumlah dokter | ⚠️ PERHATIAN |
| 8 | PK-08 | Visibility Fungsi | Semua fungsi sensitif hanya bisa diakses oleh `msg.sender` yang relevan | Analisis kode — tidak ada `onlyOwner` atau `admin` | Kontrol akses berbasis `msg.sender` sudah benar | Akses terkontrol dengan baik | ✅ AMAN |
| 9 | PK-09 | Data Publik di Blockchain | Data dokter bersifat publik via mapping `doctors` | Baca `doctors[address]` tanpa autentikasi | Data memang dirancang publik (jadwal boleh dilihat semua) | Data terbaca publik sesuai desain | ✅ AMAN |
| 10 | PK-10 | Pengiriman ETH Paksa | Mencoba mengirim ETH ke kontrak | Kirim ETH ke address kontrak | Revert, kontrak tidak memiliki `receive()` atau `fallback()` | Revert, ETH tidak diterima | ✅ AMAN |

> ⚠️ **Catatan PK-07:** Fungsi `getAllDoctors()` mengembalikan seluruh array. Pada skala produksi dengan ribuan dokter, disarankan menambahkan mekanisme **pagination** untuk menghindari out-of-gas.

---

## 📊 Ringkasan Hasil Pengujian

| Kategori Pengujian | Total Kasus Uji | ✅ PASS / AMAN | ⚠️ Perhatian | ❌ FAIL |
|--------------------|-----------------|----------------|--------------|---------|
| Pengujian Fungsional | 6 | 6 | 0 | 0 |
| Pengujian Boundary Value | 7 | 4 | 3 | 0 |
| Pengujian Exception Handling | 6 | 6 | 0 | 0 |
| Pengujian State Transition | 8 | 8 | 0 | 0 |
| Pengujian Keamanan | 10 | 9 | 1 | 0 |
| **TOTAL** | **37** | **33** | **4** | **0** |

---

## 💡 Rekomendasi Perbaikan

| No | Temuan | Rekomendasi |
|----|--------|-------------|
| 1 | Input string kosong `""` diterima tanpa validasi | Tambahkan `require(bytes(_name).length > 0, "Nama tidak boleh kosong")` |
| 2 | `getAllDoctors()` mengembalikan seluruh array sekaligus | Tambahkan mekanisme pagination untuk skalabilitas |
| 3 | Tidak ada fungsi untuk menghapus/menonaktifkan dokter | Tambahkan field `isActive` dan fungsi `deactivateDoctor()` |
| 4 | Tidak ada pembatasan panjang string input | Tambahkan validasi panjang maksimum untuk mencegah pemborosan gas |
