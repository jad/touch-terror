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
    [sc release], sc = nil;

    UIBarButtonItem * scoreItem = [[UIBarButtonItem alloc] initWithTitle:@"Score: 0"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(scoreTouched)];
    [scoreItem setEnabled:NO];
    [[self navigationItem] setRightBarButtonItem:scoreItem];
    [scoreItem release], scoreItem = nil;

    //[[self navigationItem] setTitle:@"Touch Terror"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Toolbar events

- (void)weaponChanged:(UISegmentedControl *)sender
{
}

@end
