﻿pragma solidity ^0.4.0;

contract Register{
    struct Administrators{
        address ownerAdr;
        string ownerName;
        bytes32 password;
    }
    address public owner;
    uint AdministratorsNum = 0;
    address[] addrList;
    mapping(string=>bool) registerPool;
    mapping(string => Administrators) userPool;
    
     function Register() public {
        owner = msg.sender;
    }
    //注册
     function login(string username, string password) constant public returns (bool) {
        return userPool[username].password == keccak256(password);
    }
    //注册检测
    function checkRegister(address addr,string username) constant public returns (bool) {
	    
		for(uint i = 0; i < addrList.length; ++i){
            if(addrList[i] == addr||registerPool[username]==true)
                return true;
		}
        return false;
    }
    
	// 用户注册
    function register(address addr, string  username, string password) public {
        require(!(msg.sender!=owner));
            
        require(!checkRegister(addr,username));
        
            
		userPool[username] = Administrators(addr, username, keccak256(password));
		addrList.push(addr);
		registerPool[username]=true;
		++AdministratorsNum;
    }
    // 更新密码
    function updatePassword(string username, string newPwd) public {
		require(msg.sender != owner);
        // keccak256加密
		userPool[username].password = keccak256(newPwd);
    }
    
    function addMsg(string username,string ID,string productRecord,uint lowPoint,string AdministratorName) public{
        require(msg.sender!=owner) ;
        AddorSearch addmsg = new AddorSearch();
        addmsg.addMsg(username,ID,productRecord,lowPoint, AdministratorName);
    }
    
}


contract AddorSearch{
    struct Msg{
    string userName;
    string ID;
    string productRecord;
    uint lowPoint;
    string AdministratorName;
    }
    Msg[] productRecords;
    uint totalMsg=0;
    
    function addMsg(string username,string ID,string productRecord,uint lowPoint,string AdministratorName ) public{
        productRecords.push(Msg(username,ID,productRecord,lowPoint,AdministratorName));
    }
    function returnTotal() constant public returns (uint) {
        return productRecords.length;
    }
    function getuserName(uint id) constant public returns (string){
       return productRecords[id].userName;
    }
    function getID(uint id) constant public returns (string){
        return productRecords[id].ID;
    }
    function getProductRecord(uint id) constant public returns (string){
        return productRecords[id].productRecord;
    }
    function getlowPoint(uint id) constant public returns (uint){
        return productRecords[id].lowPoint;
    }
    function getAdministrator(uint id) constant public returns (string){
        return productRecords[id].AdministratorName;
    }

    
}
