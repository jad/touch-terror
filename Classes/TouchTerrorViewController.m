//
//  TouchTerrorViewController.m
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TouchTerrorViewController.h"
#import "ScoreManager.h"

@interface TouchTerrorViewController ()
- (void)updateScore:(int)score;
@end

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

    ScoreManager * mgr = [ScoreManager defaultManager];
    [mgr addObserver:self
          forKeyPath:@"score"
             options:NSKeyValueObservingOptionNew
             context:NULL];
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

#pragma mark -
#pragma mark KVO events

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(ScoreManager *)mgr
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self updateScore:[mgr score]];
}

#pragma mark -
#pragma mark Private implementation

- (void)updateScore:(int)score
{
    UIBarButtonItem * scoreItem = [[self navigationItem] rightBarButtonItem];
    [scoreItem setTitle:[NSString stringWithFormat:@"Score: %d", score]];
}

@end
