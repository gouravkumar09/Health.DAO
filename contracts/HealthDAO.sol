// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HealthDAO {
    // Struct to store patient details
    struct Patient {
        string name;
        uint age;
        string medicalHistory;
        bool registered;
    }

    // Mapping patient address to their data
    mapping(address => Patient) public patients;

    // DAO admin (deployer)
    address public admin;

    // Events
    event PatientRegistered(address indexed patient, string name);
    event MedicalRecordUpdated(address indexed patient, string newHistory);

    constructor() {
        admin = msg.sender;
    }

    // Function 1: Register a new patient
    function registerPatient(string memory _name, uint _age, string memory _medicalHistory) public {
        require(!patients[msg.sender].registered, "Already registered!");
        patients[msg.sender] = Patient(_name, _age, _medicalHistory, true);
        emit PatientRegistered(msg.sender, _name);
    }

    // Function 2: Update patient medical history
    function updateMedicalHistory(string memory _newHistory) public {
        require(patients[msg.sender].registered, "Patient not registered!");
        patients[msg.sender].medicalHistory = _newHistory;
        emit MedicalRecordUpdated(msg.sender, _newHistory);
    }

    // Function 3: Get patient details
    function getPatient(address _patient) public view returns (string memory, uint, string memory) {
        require(patients[_patient].registered, "Patient not found!");
        Patient memory p = patients[_patient];
        return (p.name, p.age, p.medicalHistory);
    }
}

