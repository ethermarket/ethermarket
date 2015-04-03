contract EtherMarket {
  address owner;
  struct Product {
    string32 title;
    string32 description;
    uint price;
  }
  mapping (int64 => Product) products;
  int64 productNum;

  function EtherMarket() {
    owner = msg.sender;
  }

  function addProduct(string32 title, string32 description, uint price) {
    productNum +=1 ;
    Product product = products[productNum];
    product.title = title;
    product.description = description;
    product.price = price;
  }

  function getProduct(int64 id) constant returns (string32 a, string32 b, uint c) {
    Product product = products[id];
    a = product.title;
    b = product.description;
    c = product.price;
  }

}
