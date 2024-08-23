// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentData {
    struct Student {
        uint256 studentId;
        string studentName;
        uint256 studentGrade;
        bytes32 dataHash;
        address dataOwner;
        bool hasConsented;
        mapping(address => bool) hasAuthorizedViewer;
    }

    mapping(uint256 => Student) private students;
    uint256 public studentCount;

    event StudentCreated(uint256 indexed studentId, string studentName, address indexed dataOwner);
    event StudentDataUpdated(uint256 indexed studentId, bytes32 newHash);
    event DataOwnershipTransferred(uint256 indexed studentId, address indexed previousOwner, address indexed newOwner);
    event ConsentGiven(uint256 indexed studentId);
    event ConsentRevoked(uint256 indexed studentId);
    event ViewerAuthorized(uint256 indexed studentId, address indexed viewer);
    event ViewerRevoked(uint256 indexed studentId, address indexed viewer);

    function createStudentData(string memory _name, uint256 _grade, bytes memory _data) public {
        studentCount++;
        Student storage student = students[studentCount];
        student.studentId = studentCount;
        student.studentName = _name;
        student.studentGrade = _grade;
        student.dataHash = keccak256(_data);
        student.dataOwner = msg.sender;
        student.hasConsented = true;

        emit StudentCreated(studentCount, _name, msg.sender);

        // Store encrypted data off-chain (e.g., on IPFS)
        // ...
    }

    function updateStudentData(uint256 _studentId, bytes memory _newData) public {
        require(msg.sender == students[_studentId].dataOwner, "Only the data owner can update");
        require(students[_studentId].hasConsented, "Student has not consented");

        // Encrypt new data and store off-chain
        // ...

        students[_studentId].dataHash = keccak256(_newData);
        emit StudentDataUpdated(_studentId, students[_studentId].dataHash);
    }

    function viewStudentData(uint256 _studentId) public view returns (string memory, uint256, bytes32) {
        require(
            msg.sender == students[_studentId].dataOwner || 
            students[_studentId].hasAuthorizedViewer[msg.sender], 
            "Unauthorized access"
        );
        return (
            students[_studentId].studentName, 
            students[_studentId].studentGrade, 
            students[_studentId].dataHash
        );
    }

    function transferDataOwnership(uint256 _studentId, address _newOwner) public {
        require(msg.sender == students[_studentId].dataOwner, "Only the data owner can transfer ownership");
        address previousOwner = students[_studentId].dataOwner;
        students[_studentId].dataOwner = _newOwner;
        emit DataOwnershipTransferred(_studentId, previousOwner, _newOwner);
    }

    function giveConsent(uint256 _studentId) public {
        require(msg.sender == students[_studentId].dataOwner, "Only the data owner can give consent");
        students[_studentId].hasConsented = true;
        emit ConsentGiven(_studentId);
    }

    function revokeConsent(uint256 _studentId) public {
        require(msg.sender == students[_studentId].dataOwner, "Only the data owner can revoke consent");
        students[_studentId].hasConsented = false;
        emit ConsentRevoked(_studentId);
    }

    function authorizeViewer(uint256 _studentId, address _viewer) public {
        require(msg.sender == students[_studentId].dataOwner, "Only the data owner can authorize viewers");
        students[_studentId].hasAuthorizedViewer[_viewer] = true;
        emit ViewerAuthorized(_studentId, _viewer);
    }

    function revokeViewer(uint256 _studentId, address _viewer) public {
        require(msg.sender == students[_studentId].dataOwner, "Only the data owner can revoke viewers");
        students[_studentId].hasAuthorizedViewer[_viewer] = false;
        emit ViewerRevoked(_studentId, _viewer);
    }
}
