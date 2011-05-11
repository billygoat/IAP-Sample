//
//  SKProduct+LocalizedPrice.h
//  
//  Based on code by Troy Brant
//  http://troybrant.net/blog/2010/01/in-app-purchases-a-full-walkthrough/
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface SKProduct (SKProduct_LocalizedPrice)

@property (nonatomic, readonly) NSString *localizedPrice;

@end
