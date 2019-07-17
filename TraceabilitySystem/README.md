
在现有区块链的基础上，本项目基于以太坊智能合约， 实现商品可信溯源，输入商品ID查询商品生产信息，以此来保证正品。在服务端运用SpringMVC,实现商品溯源查询，前端运用Javascript通过HTML展示所查询的结果，智能合约则使用以太坊自己的语言Solidify 将每一件商品信息和ID存在以太坊区块链上。
1开发环境
Windows 10
Geth v1.8.23-
solidity ^0.5.0
2准备工作
（1）安装Ethereum钱包
（2）Geth安装，安装完成后执行 geth help 查看geth的用法
3初始化以太坊
（1）在本地新建genesis.json文件，文件内容为：
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
（2）通过控制台Geth命令初始化创始区块
geth init genesis.json
（3）启动以太坊，控制台输入：
geth --rpc --rpcapi personal,db,eth,net,web3 --networkid 123456 --rpccorsdomain ”http://remix.ethereum.org” console
（3）创建钱包，一种是在Ethereum图形界面创建，另一种是通过Geth在控制台输入personal.newAccount()创建
（4）解锁当前账户，使私链上的账户之间可以交易，通过Geth输入
personal.unlockAccount(eth.accounts[0])
在解锁之前一定要保证存在一定的区块数量，也就是区块高度不少于10，在部署合约之前要保证当前账户解锁。
（5）开始挖矿操作，保证数据存在每一个区块链结点。
miner.start(1)
4.4部署智能合约
以太坊官方推荐的智能合约开发语言为Solidify，目前尝试Solidify编程最好的方式是使用Remix。Remix是基于浏览器的Solidify IDE，它集成了Solidify编译器、运行环境，以及调试和发布工具。使用浏览器打开网站https://remix.ethereum.org/,即可编写智能合约代码。
（1）编写智能合约代码
以太坊上的程序被称为“智能合约”，其包含代码和相应的状态数据，相当于Java中的“类”
contract Register{
    function register(address addr, string  username, string password) public {
}
}
contract AddorSearch{
function addMsg(string username,string ID,string productRecord,uint lowPoint,string AdministratorName ) public{
        violateRecords.push(Msg(username,ID,productRecord,lowPoint,AdministratorName));
    }
}
（2）点击Compile标签页的Details,然后找到web3deploy将写好的合约部署到本地私链上。
 
（3）将RemixIDE生产的web3deploy代码拷贝到geth控制台（注意：挖矿不能停），按下回车键运行就可以部署合约了。合约部署成功会有提示，
 
 
每一个address代表一个合约地址，而每一个智能合约都有一个唯一的合约地址（此时应区分外部账户地址与合约地址）。
Contract	mined! Address:0x9d77720ad98139952b33ff7de812957af811b09f
部署好智能合约以后，点击Run标签页，然后找到Environment的Web3 Provider,就可以将本地私链的账户对接到Remix中。

 
4.5 Java开发
使用maven管理 利用web3j库进行开发，在pom.xml中导入：
<dependency>
      <groupId>org.web3j</groupId>
      <artifactId>core</artifactId>
      <version>3.2.0</version>
</dependency>
4.6 服务端合约开发
使用SpringMVC在Web端实现查询注册功能
1.新建与“智能合约”相对应的Java类
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

2.将钱包地址与后台绑定，钱包路径在本地C盘的path=C:/Users/abudu/AppData/Roaming/Ethereum/keystore/UTC--2019-04-09T04-23-10XXXXXXXXXXXXXX文件中，PASSWORD则是之前本地账户所创建的密码。

public AddorSearchService() throws IOException, CipherException {
        Credentials credentials = WalletUtils.loadCredentials(Consts.PASSWORD,Consts.PATH);
        contract = util.addorSearchContract(credentials,Consts.ADDORSEARCH_ADDR);
    }

3.通过Java RPC远程调用类，实现对合约代码的控制
/*自带构造方法*/
    public RegisterContract(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        super("", contractAddress, web3j, credentials, gasPrice, gasLimit);
    }
public RemoteCall<TransactionReceipt> register(String adress,String username,String password) throws IOException {
        Function function = new Function("register",Arrays.<Type>asList(new Address(adress),new Utf8String(username),new Utf8String(password))
        ,Arrays.<TypeReference<?>>asList());
        return executeRemoteCallTransaction(function);
}

4.7服务端与前台交互
配置好XML文件，就可以在前端和服务端写逻辑代码了
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
