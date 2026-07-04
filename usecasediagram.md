# 📐 Diagram Use Case — Smart Contract `DoctorSchedule`

---

## 🔣 Legenda Simbol Use Case (Standar UML)

```
  SIMBOL                              NAMA            KETERANGAN
  ══════════════════════════════════════════════════════════════════════════════

     O
    /|\                               Aktor           Entitas luar yang berinteraksi
    / \                                               dengan sistem

  (  nama use case  )                 Use Case        Fungsi/layanan yang tersedia
                                      [Oval]          dalam sistem

  ╔══════════════════╗
  ║   NAMA SISTEM    ║               Batas Sistem     Kotak pembatas ruang lingkup
  ╚══════════════════╝

  Aktor ───────── ( Use Case )        Asosiasi        Hubungan langsung aktor ke use case

  ( A ) - - -<<include>>- - -▶ ( B ) Include          A SELALU memanggil B (wajib)
                                                       Panah dari pemanggil → yang dipanggil

  ( C ) ◀- - - <<extend>> - - - ( D ) Extend          D memperluas C secara kondisional
                                                       Panah dari ekstensi → ke use case utama
```

---

## 🗂️ Diagram Use Case

```
  O                  ╔═══════════════════════════════════════════════════════════════════╗
 /|\                 ║          SISTEM JADWAL PRAKTIK DOKTER MANDIRI                    ║
 / \                 ║               ( DoctorSchedule Contract )                        ║
Dokter               ║                                                                   ║
  |                  ║                                                                   ║
  |                  ║   ┌───────────────────────────────────────────┐                  ║
  +════════════════════▶ │  UC-01: Mendaftarkan Diri sebagai Dokter  │                  ║
                     ║   └───────────────────────────────────────────┘                  ║
                     ║                          |                                        ║
                     ║                          |  - - - <<include>> - - - ▶             ║
                     ║                          |                                        ║
                     ║                          ▼                                        ║
                     ║   ┌───────────────────────────────────────────┐                  ║
                     ║   │  UC-02: Validasi Akun Belum Terdaftar     │                  ║
                     ║   └───────────────────────────────────────────┘                  ║
                     ║                                                                   ║
                     ║                                                                   ║
  O                  ║                                                                   ║
 /|\                 ║   ┌───────────────────────────────────────────┐                  ║
 / \                 ║   │  UC-09: Emit Event DoctorRegistered       │                  ║
Dokter               ║   └───────────────────────────────────────────┘                  ║
  |                  ║                          |                                        ║
  |                  ║                          |  - - - <<extend>> - - - ▶              ║
  |                  ║                          |                                        ║
  |                  ║                          ▼                                        ║
  +════════════════════▶ ┌───────────────────────────────────────────┐                  ║
                     ║   │  UC-03: Memperbarui Jadwal Praktik        │                  ║
                     ║   └───────────────────────────────────────────┘                  ║
                     ║                          |                                        ║
                     ║           ┌──────────────┴───────────────┐                       ║
                     ║           |                              |                        ║
                     ║           | - - <<include>> - - ▶        | - - <<extend>> - - ▶  ║
                     ║           |                              |                        ║
                     ║           ▼                              ▼                        ║
                     ║   ┌───────────────────────┐   ┌──────────────────────────────┐   ║
                     ║   │ UC-04: Validasi Akun  │   │ UC-10: Emit Event            │   ║
                     ║   │ Sudah Terdaftar       │   │        ScheduleUpdated       │   ║
                     ║   └───────────────────────┘   └──────────────────────────────┘   ║
                     ║                                                                   ║
                     ║                                                                   ║
  O                  ║                                                                   ║
 /|\                 ║   ┌───────────────────────────────────────────┐                  ║
 / \                 ║   │  UC-05: Melihat Info & Jadwal Dokter      │                  ║
Pasien               ║   └───────────────────────────────────────────┘                  ║
  |                  ║                          |                                        ║
  +════════════════════▶                        | - - - <<include>> - - - ▶              ║
                     ║                          |                                        ║
                     ║                          ▼                                        ║
                     ║   ┌───────────────────────────────────────────┐                  ║
                     ║   │  UC-06: Validasi Dokter Terdaftar         │                  ║
                     ║   └───────────────────────────────────────────┘                  ║
                     ║                                                                   ║
                     ║                                                                   ║
  O                  ║                                                                   ║
 /|\                 ║   ┌───────────────────────────────────────────┐                  ║
 / \                 ║   │  UC-07: Melihat Semua Daftar Dokter       │                  ║
Pasien               ║   └───────────────────────────────────────────┘                  ║
  |                  ║                                                                   ║
  +════════════════════▶                                                                 ║
                     ║                                                                   ║
                     ╚═══════════════════════════════════════════════════════════════════╝
```

---

## 👤 Deskripsi Aktor

| Aktor | Peran |
|-------|-------|
| **Dokter** | Mendaftarkan diri dan memperbarui jadwal praktik via wallet address |
| **Pasien** | Melihat informasi dan jadwal dokter yang tersedia di sistem |

---

## 📋 Deskripsi Use Case

| ID | Nama Use Case | Aktor | Relasi | Deskripsi |
|----|---------------|-------|--------|-----------|
| UC-01 | Mendaftarkan Diri sebagai Dokter | Dokter | Primary | Dokter memasukkan nama, spesialisasi, dan jadwal untuk didaftarkan ke blockchain |
| UC-02 | Validasi Akun Belum Terdaftar | Sistem | `<<include>>` dari UC-01 | Sistem memeriksa wallet address belum pernah mendaftar sebelumnya |
| UC-03 | Memperbarui Jadwal Praktik | Dokter | Primary | Dokter yang sudah terdaftar mengubah detail jadwal praktiknya |
| UC-04 | Validasi Akun Sudah Terdaftar | Sistem | `<<include>>` dari UC-03 | Sistem memeriksa wallet address sudah terdaftar sebagai dokter |
| UC-05 | Melihat Info & Jadwal Dokter | Pasien | Primary | Pasien memasukkan address dokter untuk melihat nama, spesialisasi, dan jadwal |
| UC-06 | Validasi Dokter Terdaftar | Sistem | `<<include>>` dari UC-05 | Sistem memeriksa address dokter yang dicari ada di sistem |
| UC-07 | Melihat Semua Daftar Dokter | Pasien | Primary | Pasien melihat seluruh daftar address dokter yang terdaftar di sistem |
| UC-09 | Emit Event: DoctorRegistered | Sistem | `<<extend>>` ke UC-03 | Event dipancarkan ke blockchain saat pendaftaran dokter berhasil |
| UC-10 | Emit Event: ScheduleUpdated | Sistem | `<<extend>>` dari UC-03 | Event dipancarkan ke blockchain saat pembaruan jadwal berhasil |

---

## 🔗 Ringkasan Arah Panah Relasi

```
  ┌─────────────────────────────────────────────────────────────────────────┐
  │  <<include>>  →  panah dari use case UTAMA ke use case YANG DIPANGGIL  │
  │                                                                         │
  │  UC-01 - - - <<include>> - - -▶ UC-02                                  │
  │  UC-03 - - - <<include>> - - -▶ UC-04                                  │
  │  UC-05 - - - <<include>> - - -▶ UC-06                                  │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─────────────────────────────────────────────────────────────────────────┐
  │  <<extend>>   →  panah dari use case EKSTENSI ke use case UTAMA        │
  │                                                                         │
  │  UC-09 - - - <<extend>> - - -▶ UC-03  (event saat daftar berhasil)    │
  │  UC-10 - - - <<extend>> - - -▶ UC-03  (event saat update berhasil)    │
  └─────────────────────────────────────────────────────────────────────────┘
```
