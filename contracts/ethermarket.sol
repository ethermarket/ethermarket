contract EtherMarket {
  address owner;
  struct Product {
    bytes32 title;
    bytes32 description;
    uint price;
  }
  mapping (int64 => Product) public products;
  int64 productNum;

  event newProductAdded(address indexed creator, int64 productId);

  function EtherMarket() {
    owner = msg.sender;
  }

  function addProduct(bytes32 title, bytes32 description, uint price) {
    productNum +=1 ;
    Product product = products[productNum];
    product.title = title;
    product.description = description;
    product.price = price;
    newProductAdded(msg.sender, productNum);
  }

  function getProduct(int64 id) constant returns (bytes32 a, bytes32 b, uint c) {
    Product product = products[id];
    a = product.title;
    b = product.description;
    c = product.price;
  }
}
