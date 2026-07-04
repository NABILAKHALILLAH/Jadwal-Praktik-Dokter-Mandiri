# 📐 Diagram Use Case — Smart Contract `DoctorSchedule`

---

## 🔣 Legenda Simbol Use Case (Standar UML)

```
  SIMBOL                          NAMA              KETERANGAN
  ══════════════════════════════════════════════════════════════════════
     O
    /|\                           Aktor             Entitas luar yang berinteraksi
    / \                                             dengan sistem

  (                          )    Use Case          Fungsi/layanan yang tersedia
   nama use case                  [Oval]            dalam sistem

  ╔═══════════════════════════╗
  ║       NAMA SISTEM         ║   Batas Sistem      Kotak pembatas ruang lingkup
  ╚═══════════════════════════╝

  Aktor ───────── (Use Case)      Asosiasi          Hubungan langsung aktor ke use case

  (A) - - -<<include>>- - ▶ (B)  Include           A SELALU memanggil B (wajib)

  (A) - - - <<extend>>- - ▶ (B)  Extend            A memperluas B (kondisional)
```

---

## 🗂️ Diagram Use Case

```
                    ╔══════════════════════════════════════════════════════════════════╗
                    ║           SISTEM JADWAL PRAKTIK DOKTER MANDIRI                  ║
                    ║                  ( DoctorSchedule Contract )                    ║
                    ║                                                                  ║
                    ║                                                                  ║
                    ║                                                                  ║
      O             ║                                                                  ║
     /|\            ║     ┌─────────────────────────────────────────────────────┐     ║
     / \            ║     │                                                     │     ║
    Dokter ─────────╫─────┤  UC-01: Mendaftarkan Diri sebagai Dokter            │     ║
                    ║     │                                                     │     ║
                    ║     └──────────────────────┬──────────────────────────────┘     ║
                    ║                            │                                    ║
                    ║                            │  - - - <<include>> - - - ▶         ║
                    ║                            │                                    ║
                    ║                            ▼                                    ║
                    ║     ┌─────────────────────────────────────────────────────┐     ║
                    ║     │                                                     │     ║
                    ║     │  UC-02: Validasi Akun Belum Terdaftar               │     ║
                    ║     │                                                     │     ║
                    ║     └─────────────────────────────────────────────────────┘     ║
                    ║                                                                  ║
                    ║                                                                  ║
      O             ║                                                                  ║
     /|\            ║     ┌─────────────────────────────────────────────────────┐     ║
     / \            ║     │                                                     │     ║
    Dokter ─────────╫─────┤  UC-03: Memperbarui Jadwal Praktik                  │     ║
                    ║     │                                                     │     ║
                    ║     └──────────────────────┬──────────────────────────────┘     ║
                    ║                            │                                    ║
                    ║                            │  - - - <<include>> - - - ▶         ║
                    ║                            │                                    ║
                    ║                            ▼                                    ║
                    ║     ┌─────────────────────────────────────────────────────┐     ║
                    ║     │                                                     │     ║
                    ║     │  UC-04: Validasi Akun Sudah Terdaftar               │     ║
                    ║     │                                                     │     ║
                    ║     └─────────────────────────────────────────────────────┘     ║
                    ║                                                                  ║
                    ║                                                                  ║
      O             ║                                                                  ║
     /|\            ║     ┌─────────────────────────────────────────────────────┐     ║
     / \            ║     │                                                     │     ║
    Pasien ─────────╫─────┤  UC-05: Melihat Info & Jadwal Dokter                │     ║
                    ║     │                                                     │     ║
                    ║     └──────────────────────┬──────────────────────────────┘     ║
                    ║                            │                                    ║
                    ║                            │  - - - <<include>> - - - ▶         ║
                    ║                            │                                    ║
                    ║                            ▼                                    ║
                    ║     ┌─────────────────────────────────────────────────────┐     ║
                    ║     │                                                     │     ║
                    ║     │  UC-06: Validasi Dokter Terdaftar di Sistem         │     ║
                    ║     │                                                     │     ║
                    ║     └─────────────────────────────────────────────────────┘     ║
                    ║                                                                  ║
                    ║                                                                  ║
      O             ║                                                                  ║
     /|\            ║     ┌─────────────────────────────────────────────────────┐     ║
     / \            ║     │                                                     │     ║
    Pasien ─────────╫─────┤  UC-07: Melihat Semua Daftar Dokter                 │     ║
                    ║     │                                                     │     ║
                    ║     └─────────────────────────────────────────────────────┘     ║
                    ║                                                                  ║
                    ║                                                                  ║
                    ║  ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐   ║
                    ║       RELASI EXTEND (Dipicu jika transaksi berhasil)           ║
                    ║  │                                                         │   ║
                    ║    UC-01 - - - <<extend>> - - ▶ UC-08: Simpan Data             ║
                    ║  │                                       ke Blockchain     │   ║
                    ║    UC-01 - - - <<extend>> - - ▶ UC-09: Emit Event               ║
                    ║  │                                       DoctorRegistered  │   ║
                    ║    UC-03 - - - <<extend>> - - ▶ UC-08: Simpan Data              ║
                    ║  │                                       ke Blockchain     │   ║
                    ║    UC-03 - - - <<extend>> - - ▶ UC-10: Emit Event               ║
                    ║  │                                       ScheduleUpdated   │   ║
                    ║                                                                  ║
                    ║  └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘   ║
                    ║                                                                  ║
                    ╚══════════════════════════════════════════════════════════════════╝
```

---

## 👤 Deskripsi Aktor

| Simbol | Aktor | Peran dalam Sistem |
|--------|-------|--------------------|
| O /\|/ / \ | **Dokter** | Mendaftarkan diri ke sistem dan memperbarui jadwal praktiknya sendiri melalui wallet address |
| O /\|/ / \ | **Pasien** | Melihat informasi dan jadwal dokter yang tersedia di sistem |

---

## 📋 Deskripsi Use Case

| ID | Nama Use Case | Aktor | Relasi | Deskripsi |
|----|---------------|-------|--------|-----------|
| UC-01 | Mendaftarkan Diri sebagai Dokter | Dokter | Primary | Dokter memasukkan nama, spesialisasi, dan jadwal untuk didaftarkan ke blockchain |
| UC-02 | Validasi Akun Belum Terdaftar | Sistem | `<<include>>` ← UC-01 | Sistem memeriksa apakah wallet address belum pernah mendaftar sebelumnya |
| UC-03 | Memperbarui Jadwal Praktik | Dokter | Primary | Dokter yang sudah terdaftar mengubah detail jadwal praktiknya |
| UC-04 | Validasi Akun Sudah Terdaftar | Sistem | `<<include>>` ← UC-03 | Sistem memeriksa apakah wallet address sudah terdaftar sebagai dokter |
| UC-05 | Melihat Info & Jadwal Dokter | Pasien | Primary | Pasien memasukkan address dokter untuk melihat nama, spesialisasi, dan jadwal |
| UC-06 | Validasi Dokter Terdaftar di Sistem | Sistem | `<<include>>` ← UC-05 | Sistem memeriksa apakah address dokter yang dicari ada di sistem |
| UC-07 | Melihat Semua Daftar Dokter | Pasien | Primary | Pasien melihat seluruh daftar address dokter yang terdaftar di sistem |
| UC-08 | Simpan Data ke Blockchain | Sistem | `<<extend>>` ← UC-01, UC-03 | Data dokter atau jadwal disimpan secara permanen jika transaksi berhasil |
| UC-09 | Emit Event: DoctorRegistered | Sistem | `<<extend>>` ← UC-01 | Event dipancarkan ke blockchain saat pendaftaran dokter berhasil |
| UC-10 | Emit Event: ScheduleUpdated | Sistem | `<<extend>>` ← UC-03 | Event dipancarkan ke blockchain saat pembaruan jadwal berhasil |

---

## 🔗 Ringkasan Relasi

```
  ┌──────────────────────────────────────────────────────────────────────┐
  │  INCLUDE  (wajib, selalu dijalankan)                                 │
  │                                                                      │
  │  UC-01 ── <<include>> ──▶ UC-02  (wajib validasi sebelum daftar)    │
  │  UC-03 ── <<include>> ──▶ UC-04  (wajib validasi sebelum update)    │
  │  UC-05 ── <<include>> ──▶ UC-06  (wajib validasi sebelum cek info)  │
  └──────────────────────────────────────────────────────────────────────┘

  ┌──────────────────────────────────────────────────────────────────────┐
  │  EXTEND  (kondisional, hanya jika transaksi berhasil)                │
  │                                                                      │
  │  UC-01 ── <<extend>> ──▶ UC-08  (simpan data dokter baru)           │
  │  UC-01 ── <<extend>> ──▶ UC-09  (pancarkan event DoctorRegistered)  │
  │  UC-03 ── <<extend>> ──▶ UC-08  (perbarui data jadwal)              │
  │  UC-03 ── <<extend>> ──▶ UC-10  (pancarkan event ScheduleUpdated)   │
  └──────────────────────────────────────────────────────────────────────┘
```
