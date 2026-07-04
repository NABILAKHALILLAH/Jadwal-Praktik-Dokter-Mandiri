# 📐 Diagram Use Case — Smart Contract `DoctorSchedule`

## Legenda Simbol Use Case

```
  Simbol          Nama                  Keterangan
  ──────────────────────────────────────────────────────────
  [Nama Aktor]    Aktor                 Pengguna sistem (orang/entitas luar)
  (Nama Use Case) Use Case              Fungsionalitas / layanan sistem
  ──────────────  Garis Asosiasi        Aktor terhubung ke use case
  - - - ->        <<include>>           Use case selalu memanggil use case lain
  - - - ->        <<extend>>            Use case opsional memperluas use case lain
  [  Sistem  ]    Batas Sistem          Kotak pembatas ruang lingkup sistem
```

---

## 🗂️ Diagram Use Case

```
+------------------------------------------------------------------+
|              SISTEM JADWAL PRAKTIK DOKTER MANDIRI                |
|                     (DoctorSchedule Contract)                    |
|                                                                  |
|                                                                  |
|   [Dokter]                                                       |
|      |                                                           |
|      |── asosiasi ──▶ ( Mendaftarkan Diri sebagai Dokter  )     |
|      |                           |                               |
|      |                           | <<include>>                   |
|      |                           ▼                               |
|      |                 ( Validasi Belum Terdaftar )              |
|      |                                                           |
|      |── asosiasi ──▶ ( Memperbarui Jadwal Praktik )            |
|      |                           |                               |
|      |                           | <<include>>                   |
|      |                           ▼                               |
|      |                 ( Validasi Sudah Terdaftar )              |
|      |                                                           |
|      |                                                           |
|   [Pasien]                                                       |
|      |                                                           |
|      |── asosiasi ──▶ ( Melihat Info & Jadwal Dokter )          |
|      |                           |                               |
|      |                           | <<include>>                   |
|      |                           ▼                               |
|      |                 ( Validasi Dokter Terdaftar )             |
|      |                                                           |
|      |── asosiasi ──▶ ( Melihat Semua Daftar Dokter )           |
|      |                                                           |
|      |                                                           |
|   [Blockchain / Smart Contract]                                  |
|      |                                                           |
|      |── asosiasi ──▶ ( Menyimpan Data Dokter )                 |
|      |                    ▲              ▲                       |
|      |              <<extend>>      <<extend>>                   |
|      |                    |              |                       |
|      |   ( Emit Event DoctorRegistered ) |                       |
|      |                       ( Emit Event ScheduleUpdated )      |
|                                                                  |
+------------------------------------------------------------------+
```

---

## 👤 Deskripsi Aktor

| Aktor | Peran |
|-------|-------|
| **Dokter** | Pengguna yang mendaftarkan diri dan mengelola jadwal praktiknya sendiri via wallet address |
| **Pasien** | Pengguna yang mencari dan melihat informasi serta jadwal dokter |
| **Blockchain / Smart Contract** | Entitas sistem yang menyimpan data secara permanen dan memancarkan event |

---

## 📋 Deskripsi Use Case

| No | Use Case | Aktor | Tipe | Deskripsi |
|----|----------|-------|------|-----------|
| UC-01 | Mendaftarkan Diri sebagai Dokter | Dokter | Primary | Dokter mendaftarkan nama, spesialisasi, dan jadwal ke blockchain |
| UC-02 | Validasi Belum Terdaftar | Sistem | <<include>> | Memastikan wallet belum pernah mendaftar sebelumnya |
| UC-03 | Memperbarui Jadwal Praktik | Dokter | Primary | Dokter mengubah detail jadwal praktiknya |
| UC-04 | Validasi Sudah Terdaftar | Sistem | <<include>> | Memastikan hanya dokter terdaftar yang bisa update jadwal |
| UC-05 | Melihat Info & Jadwal Dokter | Pasien | Primary | Pasien mengecek nama, spesialisasi, dan jadwal dokter tertentu |
| UC-06 | Validasi Dokter Terdaftar | Sistem | <<include>> | Memastikan address dokter yang dicari ada di sistem |
| UC-07 | Melihat Semua Daftar Dokter | Pasien | Primary | Pasien melihat seluruh daftar address dokter yang terdaftar |
| UC-08 | Menyimpan Data Dokter | Blockchain | <<extend>> | Data tersimpan permanen di storage blockchain |
| UC-09 | Emit Event DoctorRegistered | Blockchain | <<extend>> | Event dipancarkan saat pendaftaran dokter berhasil |
| UC-10 | Emit Event ScheduleUpdated | Blockchain | <<extend>> | Event dipancarkan saat jadwal dokter berhasil diperbarui |

---

## 🔗 Relasi Antar Use Case

```
  UC-01 ──<<include>>──▶ UC-02   (Daftar dokter SELALU validasi dulu)
  UC-03 ──<<include>>──▶ UC-04   (Update jadwal SELALU validasi dulu)
  UC-05 ──<<include>>──▶ UC-06   (Cek info SELALU validasi dokter dulu)
  UC-01 ──<<extend>> ──▶ UC-08   (Jika berhasil, data tersimpan)
  UC-01 ──<<extend>> ──▶ UC-09   (Jika berhasil, event dipancarkan)
  UC-03 ──<<extend>> ──▶ UC-08   (Jika berhasil, data diperbarui)
  UC-03 ──<<extend>> ──▶ UC-10   (Jika berhasil, event dipancarkan)
```
