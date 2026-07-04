# 📊 Diagram Alir — Smart Contract `DoctorSchedule`

Diagram ini menggunakan **simbol standar flowchart** sesuai konvensi diagram alir data:

| Simbol | Bentuk | Keterangan |
|--------|--------|------------|
| `( )` | Oval / Terminator | Mulai / Selesai |
| `[ ]` | Persegi panjang / Proses | Proses / Operasi |
| `< >` | Jajar genjang / I-O | Input / Output |
| `{ }` | Belah ketupat / Keputusan | Kondisi / Percabangan |
| `=====` | Garis ganda / Penyimpanan | Penyimpanan data (Blockchain) |
| `-->` | Panah | Arah aliran data |

---

## 🔷 1. `registerDoctor` — Pendaftaran Dokter Baru

```
         ( MULAI )
              |
              v
< INPUT: _name, _specialization, _scheduleDetails >
              |
              v
  { Apakah msg.sender sudah terdaftar? }
         /         \
       [YA]       [TIDAK]
        |               |
        v               v
< OUTPUT: Revert  > [ Simpan data ke doctors[msg.sender] ]
  "Sudah terdaftar"     |
        |               v
        |     [ Tambahkan msg.sender ke doctorAddresses[] ]
        |               |
        |               v
        |     [ Emit event DoctorRegistered ]
        |               |
        |               v
        |    < OUTPUT: Event terpancar ke blockchain >
        |               |
        +-------+-------+
                |
                v
          ( SELESAI )
```

**Penyimpanan Data:**
```
==========================================
  doctors[msg.sender] = {
    name, specialization,
    scheduleDetails, isRegistered: true
  }
  doctorAddresses[] += msg.sender
==========================================
```

---

## 🔷 2. `updateSchedule` — Update Jadwal Praktik

```
         ( MULAI )
              |
              v
    < INPUT: _newSchedule >
              |
              v
  { Apakah msg.sender terdaftar sebagai dokter? }
         /         \
       [TIDAK]     [YA]
        |               |
        v               v
< OUTPUT: Revert  > [ Perbarui doctors[msg.sender].scheduleDetails ]
  "Bukan dokter"        |
        |               v
        |     [ Emit event ScheduleUpdated ]
        |               |
        |               v
        |    < OUTPUT: Event terpancar ke blockchain >
        |               |
        +-------+-------+
                |
                v
          ( SELESAI )
```

**Penyimpanan Data:**
```
==========================================
  doctors[msg.sender].scheduleDetails
    = _newSchedule  (diperbarui)
==========================================
```

---

## 🔷 3. `getDoctorInfo` — Cek Info Dokter oleh Pasien

```
         ( MULAI )
              |
              v
  < INPUT: _doctorAddress >
              |
              v
  { Apakah _doctorAddress terdaftar? }
         /         \
       [TIDAK]     [YA]
        |               |
        v               v
< OUTPUT: Revert  > [ Baca doctors[_doctorAddress] dari blockchain ]
  "Dokter tidak         |
   ditemukan"           v
        |    < OUTPUT: name, specialization, scheduleDetails >
        |               |
        +-------+-------+
                |
                v
          ( SELESAI )
```

**Baca Data (Read-Only):**
```
==========================================
  doctors[_doctorAddress] --> {
    name, specialization, scheduleDetails
  }
==========================================
```

---

## 🔷 4. `getAllDoctors` — Lihat Semua Dokter Terdaftar

```
         ( MULAI )
              |
              v
     [ Baca array doctorAddresses[] dari blockchain ]
              |
              v
  < OUTPUT: address[] semua dokter terdaftar >
              |
              v
          ( SELESAI )
```

**Baca Data (Read-Only):**
```
==========================================
  doctorAddresses[] --> [addr1, addr2, ...]
==========================================
```

---

## 🗺️ Diagram Alir Sistem Keseluruhan

```
( MULAI )
    |
    v
{ Siapa pengguna? }
    |           \
 [DOKTER]     [PASIEN]
    |               |
    v               v
{ Pilih Aksi }   { Pilih Aksi }
  /      \           /       \
[Daftar] [Update]  [Cek Info] [Lihat Semua]
  |          |          |           |
  v          v          v           v
[register  [update   [getDo-    [getAll-
 Doctor]    Schedule]  ctorInfo]   Doctors]
  |          |          |           |
  v          v          v           v
< Simpan > < Update > < Baca  >  < Baca  >
  ke         ke         dari       dari
 Blockchain Blockchain Blockchain Blockchain
  |          |          |           |
  v          v          v           v
< Event    < Event   < Output:   < Output:
  DoctorReg  Schedule   nama,       list
  istered >  Updated >  jadwal >    address >
    |          |          |           |
    +----+-----+-----+----+
         |
         v
     ( SELESAI )
```

---

## 📌 Legenda Simbol

```
  ( teks )   --> Terminator     : Titik Mulai / Selesai
  [ teks ]   --> Proses         : Operasi / Komputasi
  < teks >   --> Input / Output : Data masuk atau keluar
  { teks }   --> Keputusan      : Percabangan kondisi (Ya/Tidak)
  ========   --> Penyimpanan    : Data disimpan di blockchain
  -->  |  v  --> Aliran Data    : Arah perpindahan data
```
