contract DigitalProperty {

    // Storage providers:
    // 0 - Ethereum
    // 1 - IPFS

    struct resource {
        uint storageProvider;
        string reference;
    }

    struct ownership {
        address owner;
        resource property;
        bool encrypted;
    }

    function 
}
