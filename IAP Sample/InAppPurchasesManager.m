//
//  InAppPurchasesManager.m
//
//  Based on code by Troy Brant
//  http://troybrant.net/blog/2010/01/in-app-purchases-a-full-walkthrough/
//

#import "InAppPurchasesManager.h"
#import "SynthesizeSingleton.h"
#import "Constants.h"
#import "SKProduct+LocalizedPrice.h"

@implementation InAppPurchasesManager

SYNTHESIZE_SINGLETON_FOR_CLASS(InAppPurchasesManager);

- (id)init {
    if (self == [super init]) {
        return self;
    }
    
    return nil;
}

- (void)requestProductData {
    // Add your product identifiers:
    SKProductsRequest *req = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects:]];
    req.delegate = self;
    [req start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *products = response.products;
    NSLog(@"Products: %d", [products count]);
    NSLog(@"Invalid Products: %d", [response.invalidProductIdentifiers count]);
    [[NSNotificationCenter defaultCenter] postNotificationName:kReceivedProductData object:products];
    [request autorelease];
}

#pragma -
#pragma Public methods

//
// call this method once on startup
//
- (void)loadStore {
    // restarts any purchases if they were interrupted last time the app was open
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

//
// call this before making a purchase
//
- (BOOL)canMakePurchases {
    return [SKPaymentQueue canMakePayments];
}

//
// kick off the upgrade transaction
//
- (void)purchase:(NSString *)product {
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma -
#pragma Purchase helpers

//
// saves a record of the transaction by storing the receipt to disk
//
- (void)recordTransaction:(SKPaymentTransaction *)transaction {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:transaction.transactionIdentifier forKey:@"transactionID"];
    [defaults synchronize];
}

//
// enable pro features
//
- (void)provideContent:(NSString *)productId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([productId isEqualToString:@"com.smartgoat.IAPSample.uisub"]) {
        [defaults setObject:[NSNumber numberWithInt:2] forKey:@"button"];
        [defaults setObject:[NSNumber numberWithInt:2] forKey:@"slider"];
    }
    
    if ([productId isEqualToString:@"com.smartgoat.IAPSample.button"]) {
        [defaults setObject:[NSNumber numberWithInt:2] forKey:@"button"];
    }

    if ([productId isEqualToString:@"com.smartgoat.IAPSample.slider"]) {
        [defaults setObject:[NSNumber numberWithInt:1] forKey:@"slider"];
    }

    [defaults synchronize];
    return;
}

//
// removes the transaction from the queue and posts a notification with the transaction result
//
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful {
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [[NSNotificationCenter defaultCenter] postNotificationName:kTransactionFinished object:[NSNumber numberWithBool:wasSuccessful]];
}

//
// called when the transaction was successful
//
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}

//
// called when a transaction has been restored and and successfully completed
//
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    [self recordTransaction:transaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}

//
// called when a transaction has failed
//
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    // error!
    [self finishTransaction:transaction wasSuccessful:NO];
    NSLog(@"Error: %@", transaction.error);
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver methods

//
// called when the transaction status is updated
//
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        NSLog(@"Transaction state: %d", transaction.transactionState);
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
//                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}



@end
