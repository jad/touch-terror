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

- (void)addPerson
{
	Person *person = [[Person alloc] init];
	person.pos = CGPointMake(arc4random() % ((int)self.frame.size.width), (arc4random() % ((int)self.frame.size.height) - self.frame.size.height));
	
	int varience = arc4random() % 1000;
	float floatvarience = ((float)varience) * 0.01;
	floatvarience -= 5.0f;
	
	person.speed = 15.0f + floatvarience;
	[people addObject:person];
	[person release], person = nil;
}

- (void)awakeFromNib
{
	displayTimer = [[NSTimer scheduledTimerWithTimeInterval:1.0f/((float)FRAMERATE) target:self selector:@selector(update:) userInfo:nil repeats:YES] retain];
	
	if (!people) people = [[NSMutableArray alloc] init];
	if (!elements) elements = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < 50; i++)
	{
		[self addPerson];
	}
}

- (void)checkBoundsOfPerson:(Person *)person
{
	if (person.pos.y > self.frame.size.height + PERSON_IMAGE_HEIGHT)
	{
		[people removeObject:person];
		
		ScoreManager *scores = [ScoreManager defaultManager];
		scores.score -= 1;
		
		[self addPerson];
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	currentElement = [[FloodElement alloc] init];
	[elements addObject:currentElement];
	
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	[currentElement addPoint:CGPointMake(point.x, 0)];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	[currentElement addPoint:point];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	[currentElement addPoint:CGPointMake(point.x, self.frame.size.height)];
	
	[currentElement release];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIImage *personImage = [UIImage imageNamed:@"snow.png"];
	CGImageRef image = personImage.CGImage;
	
	// Draw people
	for (int i = 0; i < [people count]; i++)
	{
		Person *person = [people objectAtIndex:i];
		
		CGPoint personPoint = person.pos;
		personPoint.y += person.speed / FRAMERATE;
		person.pos = personPoint;
		CGRect personRect = CGRectMake(person.pos.x, person.pos.y, personImage.size.width, personImage.size.height);
		CGContextDrawImage(context, personRect, image);
		
		[self checkBoundsOfPerson:person];
	}
	
	// Draw elements
	for (int i = 0; i < [elements count]; i++)
	{
		FloodElement *element = [elements objectAtIndex:i];
		
		UIColor *color = [UIColor blueColor];
		color = [color colorWithAlphaComponent:0.5f];
		
		CGContextSetStrokeColorWithColor(context, color.CGColor);
		CGContextSetLineWidth(context, 30);
		CGContextBeginPath(context);
		
		for (int v = 0; v < [element.path count]; v++)
		{
			NSValue *value = [element.path objectAtIndex:v];
			
			CGPoint point = [value CGPointValue];
			
			if (v == 0)
			{
				CGContextMoveToPoint(context, point.x, point.y);
			} else {
				CGContextAddLineToPoint(context, point.x, point.y);
			}
		}
		
		CGContextStrokePath(context);
	}
}

- (void)update:(NSTimer*)theTimer
{
	[self setNeedsDisplayInRect:self.frame];
}

- (void)dealloc {
	[displayTimer release];
	[elements release];
	[people release];
	
    [super dealloc];
}


@end
