package com.sun.ssm.service;

import com.sun.ssm.contract.AddorSearchContract;
import com.sun.ssm.utils.Consts;
import com.sun.ssm.utils.util;

import org.web3j.crypto.CipherException;
import org.web3j.crypto.Credentials;
import org.web3j.crypto.WalletUtils;
import org.web3j.protocol.core.methods.response.TransactionReceipt;

import java.io.IOException;
import java.math.BigInteger;

public class AddorSearchService {

    private AddorSearchContract contract;


    public AddorSearchService() throws IOException, CipherException {
        Credentials credentials = WalletUtils.loadCredentials(Consts.PASSWORD,Consts.PATH);
        contract = util.addorSearchContract(credentials,Consts.ADDORSEARCH_ADDR);
    }


    public TransactionReceipt addMsg(String username, String ID, String productRecord, BigInteger lowPoint, String AdministratorName) throws Exception{
        return contract.addMsg(username, ID, productRecord, lowPoint, AdministratorName).send();
    }

    public BigInteger returnTotal() throws Exception {
        return contract.returnTotal().send().getValue();
    }

    public String getuserName(BigInteger id) throws Exception {
        return contract.getuserName(id).send().getValue();
    }

    public String getID(BigInteger id) throws Exception{
        return contract.getID(id).send().getValue();
    }

    public String getProductRecord(BigInteger id) throws Exception{
        return contract.getProductRecord(id).send().getValue();
    }

    public String getlowPoint(BigInteger id) throws Exception{
        return contract.getlowPoint(id).send().getValue().toString();
    }

    public String getAdministrator(BigInteger id) throws Exception{
        return contract.getAdministrator(id).send().getValue();
    }
}
