//
//  PurchasesViewController.h
//  IAP Sample
//
//  Created by Billy Mabray on 5/10/11.
//  Copyright 2011 Smart Goat Web Design. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PurchasesViewController : UIViewController {
    
    UIButton *purchasedButton;
    UISlider *purchasedSlider;
}
@property (nonatomic, retain) IBOutlet UIButton *purchasedButton;
@property (nonatomic, retain) IBOutlet UISlider *purchasedSlider;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)buttonTapped:(id)sender;

@end
