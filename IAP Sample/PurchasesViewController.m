//
//  PurchasesViewController.m
//  IAP Sample
//
//  Created by Billy Mabray on 5/10/11.
//  Copyright 2011 Smart Goat Web Design. All rights reserved.
//

#import "PurchasesViewController.h"


@implementation PurchasesViewController
@synthesize purchasedButton;
@synthesize purchasedSlider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [purchasedButton release];
    [purchasedSlider release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger buttonStatus = [[defaults objectForKey:@"button"] intValue];
    NSUInteger sliderStatus = [[defaults objectForKey:@"slider"] intValue];
    
    if (buttonStatus < 1) {
        [purchasedButton setHidden:YES];
    }
    
    if (sliderStatus < 1) {
        [purchasedSlider setHidden:YES];
    }
}

- (void)viewDidUnload
{
    [self setPurchasedButton:nil];
    [self setPurchasedSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    if (slider.value == 1.0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSUInteger sliderStatus = [[defaults objectForKey:@"slider"] intValue];
        if (sliderStatus < 2) {
            [purchasedSlider setHidden:YES];
            [defaults setObject:[NSNumber numberWithInt:0] forKey:@"slider"];
            [defaults synchronize];
        }
    }
}

- (IBAction)buttonTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
