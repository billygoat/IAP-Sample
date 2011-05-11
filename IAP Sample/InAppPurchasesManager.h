//
//  InAppPurchasesManager.h
//  
//
//  Based on code by Troy Brant
//  http://troybrant.net/blog/2010/01/in-app-purchases-a-full-walkthrough/
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


@interface InAppPurchasesManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    
}

+ (InAppPurchasesManager *)sharedInAppPurchasesManager;
- (void)requestProductData;
- (void)loadStore;
- (BOOL)canMakePurchases;
- (void)purchase:(NSString *)product;

@end
