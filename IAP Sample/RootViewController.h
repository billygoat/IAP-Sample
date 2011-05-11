//
//  RootViewController.h
//  IAP Sample
//
//  Created by Billy Mabray on 4/29/11.
//  Copyright 2011 Smart Goat Web Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
    NSArray *products;
}

@property (nonatomic, retain) NSArray *products;

- (void)receivedProductData:(NSNotification *)notice;
- (void)transactionFinished:(NSNotification *)notice;
- (void)purchase:(id)sender;
- (void)viewPurchases:(id)sender;

@end
