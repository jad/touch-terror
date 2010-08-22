#import "FireRadialWeapon.h"

static const NSTimeInterval ANIMATION_DURATION = 1.0;

@interface FireRadialWeapon ()
- (UIView *)explosionView;
@end

@implementation FireRadialWeapon

- (void)fireWeapon:(UIGestureRecognizer *)gestureRecognizer
{
	UIView * explosionView = [self explosionView];
	CGRect frame = [explosionView frame];
	CGPoint loc = [gestureRecognizer locationInView:[self view]];
	frame.origin.x = loc.x - frame.size.width / 2.0;
	frame.origin.y = loc.y - frame.size.height / 2.0;
	[explosionView setFrame:frame];

	[[self view] addSubview:explosionView];

	[self performSelector:@selector(removeView:)
			   withObject:explosionView
			   afterDelay:ANIMATION_DURATION];
}

- (void)removeView:(UIImageView *)view
{
	[view removeFromSuperview];
}

- (UIView *)explosionView
{
	static const NSInteger count = 17;
	NSMutableArray * images = [NSMutableArray arrayWithCapacity:count];

	for (int i = 0; i < count; ++i) {
		NSString * name = [NSString stringWithFormat:@"explosion%02d.jpg", i];
		UIImage * image = [UIImage imageNamed:name];
		[images addObject:image];
	}

	UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 142, 200)];
	[view setAnimationImages:images];
	[view setAnimationDuration:ANIMATION_DURATION];
	[view setAnimationRepeatCount:0];
	[view startAnimating];
	return [view autorelease];
}

@end
