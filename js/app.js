web3.setProvider(new web3.providers.HttpProvider('http://localhost:8080'));

var EtherMarket = web3.eth.contractFromAbi([{"constant":false,"inputs":[{"name":"title","type":"string32"},{"name":"description","type":"string32"},{"name":"price","type":"uint256"}],"name":"addProduct","outputs":[],"type":"function"},{"constant":true,"inputs":[{"name":"id","type":"int64"}],"name":"getProduct","outputs":[{"name":"a","type":"string32"},{"name":"b","type":"string32"},{"name":"c","type":"uint256"}],"type":"function"},{"inputs":[{"indexed":true,"name":"creator","type":"address"},{"indexed":false,"name":"productId","type":"int64"}],"name":"newProductAdded","type":"event"}]);

var market = new EtherMarket("0x6a5658de03bb6170ad277ef00669b4afecc8112c");

//market.addProduct("some title","some description", 1000)
//market.getProduct(1)

var clientAddress = web3.eth.accounts[1];

var newProduct = market.newProductAdded({creator: clientAddress});
//newProduct.watch(function() { console.log(arguments) });
web3.eth.watch(a).changed(function(arguments) {console.log(arguments) })
