#import "LightningRadialWeapon.h"
#import "Person.h"
#import <AVFoundation/AVFoundation.h>

static const NSTimeInterval ANIMATION_DURATION = 1.0;

@interface LightningRadialWeapon ()
- (UIView *)explosionView;
@property (nonatomic, assign) CGRect explosionFrame;
@end

@implementation LightningRadialWeapon

@synthesize explosionFrame;

- (void)fireWeapon:(UIGestureRecognizer *)gestureRecognizer
{
	UIView * explosionView = [self explosionView];
	CGRect frame = [explosionView frame];
	CGPoint loc = [gestureRecognizer locationInView:[self view]];

	frame.origin.x = loc.x - frame.size.width / 2.0;
	frame.origin.y = loc.y - frame.size.height / 2.0;
	CGRect destFrame = frame;

	[explosionView setAlpha:0];
	[explosionView setFrame:destFrame];
    [self setExplosionFrame:destFrame];

	[[self view] addSubview:explosionView];

	[UIView beginAnimations:nil context:NULL];
	[explosionView setAlpha:1];
	[UIView commitAnimations];

	[self performSelector:@selector(removeView:)
			   withObject:explosionView
			   afterDelay:ANIMATION_DURATION];

    [[self delegate] radialWeaponDidFire:self];

	NSString * path = [[NSBundle mainBundle] pathForResource:@"thunder-03" ofType:@"wav"];
	NSURL * soundFile = [[NSURL alloc] initFileURLWithPath:path];
	AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:NULL];
	[soundFile release];
	[player prepareToPlay];
	[player play];
}

- (void)removeView:(UIImageView *)view
{
	[view removeFromSuperview];
}

- (UIView *)explosionView
{
	/*
	static const NSInteger count = 17;
	NSMutableArray * images = [NSMutableArray arrayWithCapacity:count];

	for (int i = 0; i < count; ++i) {
		NSString * name = [NSString stringWithFormat:@"explosion%02d.jpg", i];
		UIImage * image = [UIImage imageNamed:name];
		[images addObject:image];
	}

	UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 142, 200)];
	 */
	UIImageView * view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weapon-lightning.png"]];
	return [view autorelease];
}

- (BOOL)isPersonInLineOfFire:(Person *)person
{
    CGPoint pos = [person pos];
    CGRect frame = [self explosionFrame];
    return (pos.x >= frame.origin.x && pos.x <= frame.origin.x + frame.size.width &&
            pos.y >= frame.origin.y && pos.y <= frame.origin.y + frame.size.height);
}

@end
