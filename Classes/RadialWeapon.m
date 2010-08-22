#import "RadialWeapon.h"

@interface RadialWeapon ()
@property (nonatomic, retain) UIView * view;
@property (nonatomic, retain) UIGestureRecognizer * gestureRecognizer;
@end

@implementation RadialWeapon

@synthesize delegate = _delegate;
@synthesize view = _view;
@synthesize gestureRecognizer = _gestureRecognizer;

- (void)dealloc
{
    _delegate = nil;
    [_view removeGestureRecognizer:_gestureRecognizer];
    [_view release], _view = nil;
    [_gestureRecognizer release], _gestureRecognizer = nil;
    [super dealloc];
}

- (id)initWithView:(UIView *)view
{
    if (self = [super init]) {
        _view = [view retain];
        _gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(fireWeapon:)];
        [_view addGestureRecognizer:_gestureRecognizer];
    }
    
    return self;
}

- (void)fireWeapon:(UIGestureRecognizer *)gestureRecognizer
{
    NSAssert(NO, @"Must be implemented by subclasses");
}

- (BOOL)isPersonInLineOfFire:(Person *)person
{
    NSAssert(NO, @"Must be implemented by subclasses");
    return NO;
}

@end
