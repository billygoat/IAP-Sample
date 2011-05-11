//
//  RootViewController.m
//  IAP Sample
//
//  Created by Billy Mabray on 4/29/11.
//  Copyright 2011 Smart Goat Web Design. All rights reserved.
//

#import "RootViewController.h"
#import "InAppPurchasesManager.h"
#import "SKProduct+LocalizedPrice.h"
#import <StoreKit/StoreKit.h>
#import "PurchasesViewController.h"

@implementation RootViewController

@synthesize products;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedProductData:) name:kReceivedProductData object:nil];
    InAppPurchasesManager *iap = [InAppPurchasesManager sharedInAppPurchasesManager];
    if ([iap canMakePurchases]) {
        [iap requestProductData];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Can't make purchases", @"Can't make purchases") message:NSLocalizedString(@"In-app purchasing is unavailable. Please check the purchasing options in the Settings app.", @"In-app purchasing is unavailable. Please check the purchasing options in the Settings app.") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"View Purchases" style:UIBarButtonItemStyleBordered target:self action:@selector(viewPurchases:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [products count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    SKProduct *prod = [products objectAtIndex:[indexPath row]];
    cell.textLabel.text = prod.localizedTitle;
    cell.detailTextLabel.text = prod.localizedDescription;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:prod.localizedPrice forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, 44.0, 22.0);
    button.tag = [indexPath row];
    [button addTarget:self action:@selector(purchase:) forControlEvents:UIControlEventTouchUpInside];
    [cell setAccessoryView:button];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Tap to Buy";
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)receivedProductData:(NSNotification *)notice {
    self.products = (NSArray *)[notice object];
    [self.tableView reloadData];
}

- (void)transactionFinished:(NSNotification *)notice {
    BOOL isPurchased = [[notice object] boolValue];
}

- (void)purchase:(id)sender {
    UIButton *button = (UIButton *)sender;
    InAppPurchasesManager *iap = [InAppPurchasesManager sharedInAppPurchasesManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transactionFinished:) name:kTransactionFinished object:nil];
    SKProduct *prod = [products objectAtIndex:button.tag];
    [iap purchase:prod.productIdentifier];    
}

- (void)viewPurchases:(id)sender {
    PurchasesViewController *purchases = [[PurchasesViewController alloc] init];
    [self.navigationController presentModalViewController:purchases animated:YES];
    [purchases release];
    return;
}


- (void)dealloc
{
    [super dealloc];
}

@end
