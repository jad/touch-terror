#import "TouchTerrorViewController.h"
#import "ScoreManager.h"
#import "RadialWeapon.h"
#import "LightningRadialWeapon.h"
#import "FireRadialWeapon.h"
#import "GameView.h"

@interface TouchTerrorViewController ()
@property (nonatomic, retain) RadialWeapon * radialWeapon;

- (void)updateScore:(int)score;
@end

@implementation TouchTerrorViewController

@synthesize radialWeapon = _radialWeapon;

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray * items = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"rock.png"], 
                       [UIImage imageNamed:@"fire.png"], 
                       [UIImage imageNamed:@"flood.png"],
                       [UIImage imageNamed:@"lightning.png"],
                       [UIImage imageNamed:@"freeze.png"], nil];
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
	[gameView setFloodChosen:NO];
	
    NSInteger idx = [sender selectedSegmentIndex];
    if (idx == 1) {  // fire
        RadialWeapon * rw = [[FireRadialWeapon alloc] initWithView:gameView];
        [self setRadialWeapon:rw];
        [rw setDelegate:gameView];
        [rw release], rw = nil;
	} else if (idx == 2) { // flood
		[gameView setFloodChosen:YES];
    } else if (idx == 3) {  // lightning
        RadialWeapon * rw = [[LightningRadialWeapon alloc] initWithView:gameView];
        [self setRadialWeapon:rw];
        [rw setDelegate:gameView];
        [rw release], rw = nil;
    } else
		[self setRadialWeapon:nil];
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
