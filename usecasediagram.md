# 📐 Diagram Use Case — Smart Contract `DoctorSchedule`

---

## 🔣 Legenda Simbol Use Case (Standar UML)

```
  Simbol                     Nama              Keterangan
  ─────────────────────────────────────────────────────────────────
     O                       Aktor             Pengguna/entitas di luar sistem
    /|\                       (Stick Figure)    yang berinteraksi dengan sistem
    / \

  (  nama use case  )        Use Case          Fungsionalitas yang disediakan sistem
     [elips/oval]

  ┌─────────────────┐
  │   nama sistem   │        Batas Sistem      Kotak pembatas ruang lingkup sistem
  └─────────────────┘

  Aktor ————————— (Use Case) Asosiasi          Hubungan aktor dengan use case

  (A) - - -<<include>>- - -> (B)   Include     A selalu memanggil B (wajib)

  (A) - - -<<extend>> - - -> (B)   Extend      A memperluas B (opsional/kondisional)
```

---

## 🗂️ Diagram Use Case

```
                    ┌──────────────────────────────────────────────────────────────┐
                    │         SISTEM JADWAL PRAKTIK DOKTER MANDIRI                 │
                    │                (DoctorSchedule Contract)                     │
                    │                                                              │
   O                │                                                              │
  /|\  ─────────────┼────────────── ( Mendaftarkan Diri sebagai Dokter )           │
  / \               │                              |                               │
Dokter              │                              | - - -<<include>>- - ->        │
                    │                              ▼                               │
   O                │                  ( Validasi: Belum Terdaftar )               │
  /|\  ─────────────┼──────────────────────────────────────────────────────────    │
  / \               │                                                              │
Dokter              │                                                              │
                    │                                                              │
   O                │                                                              │
  /|\  ─────────────┼────────────── ( Memperbarui Jadwal Praktik )                │
  / \               │                              |                               │
Dokter              │                              | - - -<<include>>- - ->        │
                    │                              ▼                               │
                    │                  ( Validasi: Sudah Terdaftar )               │
                    │                                                              │
                    │                                                              │
   O                │                                                              │
  /|\  ─────────────┼────────────── ( Melihat Info & Jadwal Dokter )              │
  / \               │                              |                               │
Pasien              │                              | - - -<<include>>- - ->        │
                    │                              ▼                               │
                    │                  ( Validasi: Dokter Terdaftar )              │
                    │                                                              │
   O                │                                                              │
  /|\  ─────────────┼────────────── ( Melihat Semua Daftar Dokter )               │
  / \               │                                                              │
Pasien              │                                                              │
                    │                                                              │
                    │  ( Mendaftarkan Diri ) - - -<<extend>>- - -> ( Simpan Data )│
                    │  ( Mendaftarkan Diri ) - - -<<extend>>- - -> ( Emit Event   │
                    │                                                DoctorReg'd ) │
                    │  ( Memperbarui Jadwal) - - -<<extend>>- - -> ( Simpan Data )│
                    │  ( Memperbarui Jadwal) - - -<<extend>>- - -> ( Emit Event   │
                    │                                              ScheduleUpd'd ) │
                    └──────────────────────────────────────────────────────────────┘
```

---

## 🗂️ Diagram Use Case (Tampilan Lengkap per Aktor)

```
         O                    ┌──────────────────────────────────────────────┐
        /|\                   │                                              │
        / \                   │   ( Mendaftarkan Diri sebagai Dokter  ) ────┼── <<include>> ──▶ ( Validasi: Belum Terdaftar )
      DOKTER ─────────────────┤                        |                    │
                              │                        | <<extend>>         │
                              │                        ▼                    │
                              │            ( Simpan Data ke Blockchain )    │
                              │                        |                    │
                              │                        | <<extend>>         │
                              │                        ▼                    │
                              │         ( Emit Event: DoctorRegistered )    │
                              │                                              │
                              │   ( Memperbarui Jadwal Praktik        ) ────┼── <<include>> ──▶ ( Validasi: Sudah Terdaftar )
      DOKTER ─────────────────┤                        |                    │
                              │                        | <<extend>>         │
         O                    │                        ▼                    │
        /|\                   │            ( Simpan Data ke Blockchain )    │
        / \                   │                        |                    │
                              │                        | <<extend>>         │
                              │                        ▼                    │
                              │         ( Emit Event: ScheduleUpdated  )    │
                              │                                              │
                              │   ( Melihat Info & Jadwal Dokter      ) ────┼── <<include>> ──▶ ( Validasi: Dokter Terdaftar )
      PASIEN ─────────────────┤                                              │
                              │   ( Melihat Semua Daftar Dokter       )     │
      PASIEN ─────────────────┤                                              │
                              │                                              │
         O                    └──────────────────────────────────────────────┘
        /|\
        / \
```

---

## 👤 Deskripsi Aktor

| Simbol | Aktor | Peran |
|--------|-------|-------|
| O /\|/ / \ | **Dokter** | Mendaftarkan diri dan mengelola jadwal praktik via wallet address |
| O /\|/ / \ | **Pasien** | Mencari dan melihat informasi serta jadwal dokter |

---

## 📋 Deskripsi Use Case

| No | Use Case | Aktor | Relasi | Deskripsi |
|----|----------|-------|--------|-----------|
| UC-01 | Mendaftarkan Diri sebagai Dokter | Dokter | Primary | Dokter mendaftarkan nama, spesialisasi, dan jadwal ke blockchain |
| UC-02 | Validasi: Belum Terdaftar | Sistem | `<<include>>` dari UC-01 | Memastikan wallet belum pernah mendaftar sebelumnya |
| UC-03 | Memperbarui Jadwal Praktik | Dokter | Primary | Dokter mengubah detail jadwal praktiknya |
| UC-04 | Validasi: Sudah Terdaftar | Sistem | `<<include>>` dari UC-03 | Memastikan hanya dokter terdaftar yang bisa update jadwal |
| UC-05 | Melihat Info & Jadwal Dokter | Pasien | Primary | Pasien mengecek nama, spesialisasi, dan jadwal dokter tertentu |
| UC-06 | Validasi: Dokter Terdaftar | Sistem | `<<include>>` dari UC-05 | Memastikan address dokter yang dicari ada di sistem |
| UC-07 | Melihat Semua Daftar Dokter | Pasien | Primary | Pasien melihat seluruh daftar address dokter yang terdaftar |
| UC-08 | Simpan Data ke Blockchain | Sistem | `<<extend>>` dari UC-01, UC-03 | Data tersimpan permanen di storage blockchain jika berhasil |
| UC-09 | Emit Event: DoctorRegistered | Sistem | `<<extend>>` dari UC-01 | Event dipancarkan saat pendaftaran dokter berhasil |
| UC-10 | Emit Event: ScheduleUpdated | Sistem | `<<extend>>` dari UC-03 | Event dipancarkan saat jadwal dokter berhasil diperbarui |

---

## 🔗 Relasi Antar Use Case

```
  UC-01 ── <<include>> ──▶ UC-02   Daftar dokter SELALU validasi dulu (wajib)
  UC-03 ── <<include>> ──▶ UC-04   Update jadwal SELALU validasi dulu (wajib)
  UC-05 ── <<include>> ──▶ UC-06   Cek info SELALU validasi dokter dulu (wajib)

  UC-01 ── <<extend>>  ──▶ UC-08   Jika berhasil daftar, data tersimpan (kondisional)
  UC-01 ── <<extend>>  ──▶ UC-09   Jika berhasil daftar, event dipancarkan (kondisional)
  UC-03 ── <<extend>>  ──▶ UC-08   Jika berhasil update, data diperbarui (kondisional)
  UC-03 ── <<extend>>  ──▶ UC-10   Jika berhasil update, event dipancarkan (kondisional)
```
