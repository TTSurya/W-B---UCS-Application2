// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeData {
    address public admin;
    
    struct Employee {
        string name;
        uint age;
        string aadharCard;
        address walletAddress;
    }
    
    mapping(address => Employee) public employees;
    
    constructor() {
        admin = msg.sender;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action.");
        _;
    }
    
    function addEmployee(address _employeeAddress, string memory _name, uint _age, string memory _aadharCard, address _walletAddress) public onlyAdmin {
        employees[_employeeAddress] = Employee(_name, _age, _aadharCard, _walletAddress);
    }
    
    function viewOwnInfo() public view returns (string memory name, uint age, string memory aadharCard, address walletAddress) {
        Employee storage employee = employees[msg.sender];
        require(employee.walletAddress == msg.sender, "You are not authorized to view this information.");
        return (employee.name, employee.age, employee.aadharCard, employee.walletAddress);
    }
}
