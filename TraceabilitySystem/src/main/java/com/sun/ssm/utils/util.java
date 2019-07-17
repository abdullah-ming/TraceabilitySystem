package com.sun.ssm.utils;


import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;

import com.sun.ssm.contract.AddorSearchContract;
import com.sun.ssm.contract.RegisterContract;

public class util {
    public static RegisterContract getRegisterContract(Credentials credentials, String contractAdress){
        Web3j web3j = Web3j.build(new HttpService());
        return new RegisterContract(contractAdress,web3j,credentials,Consts.GAS_PRICE,Consts.GAS_LIMIT);
    }
    public static AddorSearchContract addorSearchContract(Credentials credentials, String contractAdress){
        Web3j web3j = Web3j.build(new HttpService());
        return new AddorSearchContract(contractAdress,web3j,credentials,Consts.GAS_PRICE,Consts.GAS_LIMIT);
    }
}
