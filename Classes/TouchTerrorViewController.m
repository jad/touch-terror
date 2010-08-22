//
//  TouchTerrorViewController.m
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TouchTerrorViewController.h"

@implementation TouchTerrorViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray * items = [NSArray arrayWithObjects:@"Rock", @"Fire", @"Flood", @"Lightning", @"Freeze", nil];
    UISegmentedControl * sc = [[UISegmentedControl alloc] initWithItems:items];
    [sc setSegmentedControlStyle:UISegmentedControlStyleBar];
    [sc setSelectedSegmentIndex:0];
    [sc addTarget:self action:@selector(weaponChanged:) forControlEvents:UIControlEventValueChanged];

    UIBarButtonItem * weaponsItem = [[UIBarButtonItem alloc] initWithCustomView:sc];
    [[self navigationItem] setLeftBarButtonItem:weaponsItem];
    [weaponsItem release], weaponsItem = nil;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark Toolbar events

- (void)weaponChanged:(UISegmentedControl *)sender
{
}

@end
