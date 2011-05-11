# IAP Sample

This is a really basic app that demonstrates the bare minimum you need to do to perform in-app purchases in iOS.

## To Use 

1. Change the bundle identifier to your own that you've created in the iOS Development Center.
2. In InAppPurchasesManager.m, find this line:
        SKProductsRequest *req = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects:]];
    Add your product identifiers (that you set up in iTunes Connect) to the NSSet.