
�������������Ļ����ϣ�����Ŀ������̫�����ܺ�Լ�� ʵ����Ʒ������Դ��������ƷID��ѯ��Ʒ������Ϣ���Դ�����֤��Ʒ���ڷ��������SpringMVC,ʵ����Ʒ��Դ��ѯ��ǰ������Javascriptͨ��HTMLչʾ����ѯ�Ľ�������ܺ�Լ��ʹ����̫���Լ�������Solidify ��ÿһ����Ʒ��Ϣ��ID������̫���������ϡ�
1��������
Windows 10
Geth v1.8.23-
solidity ^0.5.0
2׼������
��1����װEthereumǮ��
��2��Geth��װ����װ��ɺ�ִ�� geth help �鿴geth���÷�
3��ʼ����̫��
��1���ڱ����½�genesis.json�ļ����ļ�����Ϊ��
{
  "config": {
        "chainId": 15,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
  "alloc"      : {},
  "coinbase"   : "0x0000000000000000000000000000000000000000",
  "difficulty" : "0x20000",
  "extraData"  : "",
  "gasLimit"   : "0xffffff",
  "nonce"      : "0x0000000000000042",
  "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp"  : "0x00"
}
��2��ͨ������̨Geth�����ʼ����ʼ����
geth init genesis.json
��3��������̫��������̨���룺
geth --rpc --rpcapi personal,db,eth,net,web3 --networkid 123456 --rpccorsdomain ��http://remix.ethereum.org�� console
��3������Ǯ����һ������Ethereumͼ�ν��洴������һ����ͨ��Geth�ڿ���̨����personal.newAccount()����
��4��������ǰ�˻���ʹ˽���ϵ��˻�֮����Խ��ף�ͨ��Geth����
personal.unlockAccount(eth.accounts[0])
�ڽ���֮ǰһ��Ҫ��֤����һ��������������Ҳ��������߶Ȳ�����10���ڲ����Լ֮ǰҪ��֤��ǰ�˻�������
��5����ʼ�ڿ��������֤���ݴ���ÿһ����������㡣
miner.start(1)
4.4�������ܺ�Լ
��̫���ٷ��Ƽ������ܺ�Լ��������ΪSolidify��Ŀǰ����Solidify�����õķ�ʽ��ʹ��Remix��Remix�ǻ����������Solidify IDE����������Solidify�����������л������Լ����Ժͷ������ߡ�ʹ�����������վhttps://remix.ethereum.org/,���ɱ�д���ܺ�Լ���롣
��1����д���ܺ�Լ����
��̫���ϵĳ��򱻳�Ϊ�����ܺ�Լ����������������Ӧ��״̬���ݣ��൱��Java�еġ��ࡱ
contract Register{
    function register(address addr, string  username, string password) public {
}
}
contract AddorSearch{
function addMsg(string username,string ID,string productRecord,uint lowPoint,string AdministratorName ) public{
        violateRecords.push(Msg(username,ID,productRecord,lowPoint,AdministratorName));
    }
}
��2�����Compile��ǩҳ��Details,Ȼ���ҵ�web3deploy��д�õĺ�Լ���𵽱���˽���ϡ�
 
��3����RemixIDE������web3deploy���뿽����geth����̨��ע�⣺�ڿ���ͣ�������»س������оͿ��Բ����Լ�ˡ���Լ����ɹ�������ʾ��
 
 
ÿһ��address����һ����Լ��ַ����ÿһ�����ܺ�Լ����һ��Ψһ�ĺ�Լ��ַ����ʱӦ�����ⲿ�˻���ַ���Լ��ַ����
Contract	mined! Address:0x9d77720ad98139952b33ff7de812957af811b09f
��������ܺ�Լ�Ժ󣬵��Run��ǩҳ��Ȼ���ҵ�Environment��Web3 Provider,�Ϳ��Խ�����˽�����˻��Խӵ�Remix�С�

 
4.5 Java����
ʹ��maven���� ����web3j����п�������pom.xml�е��룺
<dependency>
      <groupId>org.web3j</groupId>
      <artifactId>core</artifactId>
      <version>3.2.0</version>
</dependency>
4.6 ����˺�Լ����
ʹ��SpringMVC��Web��ʵ�ֲ�ѯע�Ṧ��
1.�½��롰���ܺ�Լ�����Ӧ��Java��
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

2.��Ǯ����ַ���̨�󶨣�Ǯ��·���ڱ���C�̵�path=C:/Users/abudu/AppData/Roaming/Ethereum/keystore/UTC--2019-04-09T04-23-10XXXXXXXXXXXXXX�ļ��У�PASSWORD����֮ǰ�����˻������������롣

public AddorSearchService() throws IOException, CipherException {
        Credentials credentials = WalletUtils.loadCredentials(Consts.PASSWORD,Consts.PATH);
        contract = util.addorSearchContract(credentials,Consts.ADDORSEARCH_ADDR);
    }

3.ͨ��Java RPCԶ�̵����࣬ʵ�ֶԺ�Լ����Ŀ���
/*�Դ����췽��*/
    public RegisterContract(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        super("", contractAddress, web3j, credentials, gasPrice, gasLimit);
    }
public RemoteCall<TransactionReceipt> register(String adress,String username,String password) throws IOException {
        Function function = new Function("register",Arrays.<Type>asList(new Address(adress),new Utf8String(username),new Utf8String(password))
        ,Arrays.<TypeReference<?>>asList());
        return executeRemoteCallTransaction(function);
}

4.7�������ǰ̨����
���ú�XML�ļ����Ϳ�����ǰ�˺ͷ����д�߼�������
<display-name>web-ssm</display-name>
  <welcome-file-list>
    <welcome-file>/index.html</welcome-file>
  </welcome-file-list>
  <filter>
    <filter-name>CharacterEncodingFilter</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    <init-param>
      <param-name>encoding</param-name>
      <param-value>UTF-8</param-value>
</init-param>
