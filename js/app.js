
var EtherMarket = web3.eth.contractFromAbi([{"constant":false,"inputs":[{"name":"title","type":"string32"},{"name":"description","type":"string32"},{"name":"price","type":"uint256"}],"name":"addProduct","outputs":[],"type":"function"},{"constant":true,"inputs":[{"name":"id","type":"int64"}],"name":"getProduct","outputs":[{"name":"a","type":"string32"},{"name":"b","type":"string32"},{"name":"c","type":"uint256"}],"type":"function"}]);

var market = new EtherMarket("0x24aa2ad048bff31bb4a11058e30499263622a103");

//market.addProduct("some title","some description", 1000)
//market.getProduct(1)

