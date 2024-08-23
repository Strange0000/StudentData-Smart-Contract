# Student Data Smart Contract

## Vision
The **Student Data Smart Contract** aims to create a secure, decentralized system for managing student records on the Ethereum blockchain. This project provides a way for educational institutions, students, and authorized third parties to manage and access student data with transparency and security. By leveraging blockchain technology, we ensure that student data is tamper-proof and controlled directly by the data owner, enabling trust and privacy in data management.
![image](https://github.com/user-attachments/assets/6d0da104-de27-4401-92bf-188cfae31bd1)

## Flowchart

```plaintext
+-------------------------------+
|    Deploy Contract             |
+-------------------------------+
              |
              v
+-------------------------------+
|    createStudentData()         |
|  (Student Data Creation)       |
+-------------------------------+
              |
              v
+-------------------------------+
|    updateStudentData()         |
|  (Student Data Update)         |
+-------------------------------+
              |
              v
+-------------------------------+
|    viewStudentData()           |
|  (View Student Data)           |
+-------------------------------+
              |
              v
+-------------------------------+
|    transferDataOwnership()     |
|  (Transfer Ownership)          |
+-------------------------------+
              |
              v
+-------------------------------+
|    giveConsent()               |
|  (Consent Management)          |
+-------------------------------+
              |
              v
+-------------------------------+
|    authorizeViewer()           |
|  (Viewer Authorization)        |
+-------------------------------+
              |
              v
+-------------------------------+
|    revokeViewer()              |
|  (Revoke Viewer Access)        |
+-------------------------------+
```

## Contract Address
- **Network**: ADU chain
- **Contract Address**: `0x1780EDFAF1e38B982208b088b34693Da47E95FE6`

![image](https://github.com/user-attachments/assets/09a59cdc-4eeb-4d56-a62c-174fc0723fd3)



## Functions Overview

### 1. `createStudentData(string memory _name, uint256 _grade, bytes memory _data)`
Creates a new student record with the provided name, grade, and data. This function stores the data hash on-chain and emits a `StudentCreated` event.

### 2. `updateStudentData(uint256 _studentId, bytes memory _newData)`
Updates the student data identified by `_studentId`. Only the data owner can perform this action. The function updates the data hash and emits a `StudentDataUpdated` event.

### 3. `viewStudentData(uint256 _studentId)`
Allows the data owner or authorized viewers to access the student's name, grade, and data hash. Unauthorized access attempts are rejected.

### 4. `transferDataOwnership(uint256 _studentId, address _newOwner)`
Transfers the ownership of the student's data to a new address. Only the current data owner can perform this action. A `DataOwnershipTransferred` event is emitted.

### 5. `giveConsent(uint256 _studentId)`
Grants consent for data processing. The data owner must invoke this function, and it triggers a `ConsentGiven` event.

### 6. `revokeConsent(uint256 _studentId)`
Revokes previously granted consent. This action is restricted to the data owner and emits a `ConsentRevoked` event.

### 7. `authorizeViewer(uint256 _studentId, address _viewer)`
Authorizes a new viewer to access the student's data. This function is callable only by the data owner and emits a `ViewerAuthorized` event.

### 8. `revokeViewer(uint256 _studentId, address _viewer)`
Revokes a previously authorized viewer's access. This action is restricted to the data owner and triggers a `ViewerRevoked` event.

## Future Scope
- **Integration with IPFS**: Storing encrypted student data off-chain using IPFS for greater scalability.
- **Multi-Signature Authorization**: Implementing multi-signature functionality to improve security and consent management.
- **Interoperability**: Expanding to other blockchains for a multi-chain solution to student data management.
- **User Interface**: Developing a web-based interface for non-technical users to interact with the contract.

## Contact
- **Developer**: Sumit Kumar Jaiswal
- **Email**: sumit500123@gmail.com
- **GitHub**: https://github.com/Strange0000

