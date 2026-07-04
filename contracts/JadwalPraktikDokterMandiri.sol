// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DoctorSchedule {
    
    // Struktur data untuk menyimpan informasi dokter
    struct Doctor {
        string name;
        string specialization;
        string scheduleDetails;
        bool isRegistered;
    }

    // Mapping address dompet (wallet) ke data Dokter
    mapping(address => Doctor) public doctors;
    
    // Array untuk menyimpan semua address dokter yang terdaftar (memudahkan frontend/pasien mencari dokter)
    address[] public doctorAddresses;

    // Events untuk mencatat aktivitas di blockchain
    event DoctorRegistered(address indexed doctorAddress, string name, string specialization);
    event ScheduleUpdated(address indexed doctorAddress, string newSchedule);

    // 1. Fungsi untuk mendaftarkan dokter baru
    function registerDoctor(string memory _name, string memory _specialization, string memory _scheduleDetails) public {
        require(!doctors[msg.sender].isRegistered, "Akun ini sudah terdaftar sebagai dokter.");

        doctors[msg.sender] = Doctor({
            name: _name,
            specialization: _specialization,
            scheduleDetails: _scheduleDetails,
            isRegistered: true
        });
        
        doctorAddresses.push(msg.sender);

        emit DoctorRegistered(msg.sender, _name, _specialization);
    }

    // 2. Fungsi khusus dokter untuk mengupdate jadwal praktiknya sendiri
    function updateSchedule(string memory _newSchedule) public {
        require(doctors[msg.sender].isRegistered, "Hanya dokter yang terdaftar yang dapat mengubah jadwal.");
        
        doctors[msg.sender].scheduleDetails = _newSchedule;

        emit ScheduleUpdated(msg.sender, _newSchedule);
    }

    // 3. Fungsi untuk pasien mengecek jadwal dokter tertentu tanpa antre telepon
    function getDoctorInfo(address _doctorAddress) public view returns (string memory name, string memory specialization, string memory scheduleDetails) {
        require(doctors[_doctorAddress].isRegistered, "Dokter tidak ditemukan.");
        
        Doctor memory doc = doctors[_doctorAddress];
        return (doc.name, doc.specialization, doc.scheduleDetails);
    }

    // 4. Fungsi untuk melihat semua address dokter yang ada di sistem
    function getAllDoctors() public view returns (address[] memory) {
        return doctorAddresses;
    }
}