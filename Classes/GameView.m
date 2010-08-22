//
//  GameView.m
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"


@implementation GameView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
	displayTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/((float)FRAMERATE) target:self selector:@selector(update:) userInfo:nil repeats:YES];
	
	if (!people) people = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < 20; i++)
	{
		Person *person = [[Person alloc] init];
		person.pos = CGPointMake(arc4random() % 768, arc4random() % 1024);
		person.speed = 30.0f;
		[people addObject:person];
	}
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIImage *personImage = [UIImage imageNamed:@"snow.png"];
	CGImageRef image = personImage.CGImage;
	
	for (Person *person in people)
	{
		CGPoint personPoint = person.pos;
		personPoint.y += person.speed / FRAMERATE;
		person.pos = personPoint;
		CGRect personRect = CGRectMake(person.pos.x, person.pos.y, personImage.size.width, personImage.size.height);
		CGContextDrawImage(context, personRect, image);
	}
}

- (void)update:(NSTimer*)theTimer
{
	[self setNeedsDisplayInRect:self.frame];
}

- (void)dealloc {
    [super dealloc];
}


@end
