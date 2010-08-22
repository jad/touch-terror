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
	if (!people) people = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < 20; i++)
	{
		Person *person = [[Person alloc] init];
		person.pos = CGPointMake(arc4random() % 768, arc4random() % 1024);
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
		CGRect personRect = CGRectMake(person.pos.x, person.pos.y, 20, 20);
		CGContextDrawImage(context, personRect, image);
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
