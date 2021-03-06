//
//  GameView.m
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"

#import <AVFoundation/AVFoundation.h>


@implementation GameView
@synthesize floodChosen;

- (CGFloat)CGPointDistance:(CGPoint)a to:(CGPoint)b
{
	CGFloat distance = sqrtf((b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y));
	
	return distance;
}

- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
        // Initialization code
    }
    return self;
}

- (void)addPersonTop:(BOOL)top
{
	Person *person = [[Person alloc] init];
	person.pos = CGPointMake(arc4random() % ((int)self.frame.size.width), 
							 top? -PERSON_IMAGE_HEIGHT : (arc4random() % ((int)self.frame.size.height) - self.frame.size.height));
	
	int varience = arc4random() % 1000;
	float floatvarience = ((float)varience) * 0.01;
	floatvarience -= 5.0f;
	
	person.speed = 25.0f + floatvarience;
	[people addObject:person];
	[person release], person = nil;
}

- (void)addPerson
{
	[self addPersonTop:YES];
}

- (void)awakeFromNib
{
	displayTimer = [[NSTimer scheduledTimerWithTimeInterval:1.0f/((float)FRAMERATE) target:self selector:@selector(update:) userInfo:nil repeats:YES] retain];
	
	if (!people) people = [[NSMutableArray alloc] init];
	if (!elements) elements = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < 50; i++)
	{
		[self addPersonTop:NO];
	}
}

- (void)checkBoundsOfPeople
{
	for (int i = 0; i < [people count]; i++)
	{
		Person *person = [people objectAtIndex:i];
		if (person.pos.y > self.frame.size.height + PERSON_IMAGE_HEIGHT)
		{
			[people removeObject:person];
			i--;
			
			ScoreManager *scores = [ScoreManager defaultManager];
			scores.score -= 1;
			
			[self addPersonTop:YES];
		}
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!floodChosen) return;
	
	currentElement = [[FloodElement alloc] init];
	[elements addObject:currentElement];
	
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	lastTouch = point;
	
	[currentElement addPoint:CGPointMake(point.x, 0)];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!floodChosen) return;
	
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	if (lastTouch.y < point.y) 
	{
		[currentElement addPoint:point];
		lastTouch = point;
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!floodChosen) return;
	
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	[currentElement addPoint:CGPointMake(point.x, self.frame.size.height)];
	
	currentElement.created = YES;
	[currentElement release];
	
	NSString * path = [[NSBundle mainBundle] pathForResource:@"flood" ofType:@"wav"];
	NSURL * soundFile = [[NSURL alloc] initFileURLWithPath:path];
	AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:NULL];
	[soundFile release];
	[player prepareToPlay];
	[player play];	
}

- (void)killPerson:(Person *)person
{
	[people removeObject:person];
	ScoreManager *scores = [ScoreManager defaultManager];
	scores.score += KILL_VALUE;
	//[self performSelector:@selector(addPerson:) withObject:nil afterDelay:1];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	frame += 1;
	frame %= 30;
	
	if (frame == 1 || [people count] < 50) [self addPersonTop:NO];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIImage *personImage = [UIImage imageNamed:@"person.png"];
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
		
		[self checkBoundsOfPeople];
	}
	
	// Draw elements
	for (int i = 0; i < [elements count]; i++)
	{
		FloodElement *element = [elements objectAtIndex:i];
		
		if (element.created) element.lifetime -= (1.0f / ((float)FRAMERATE));
		
		UIColor *color = [UIColor blueColor];
		color = [color colorWithAlphaComponent:(element.created? fmin(element.lifetime, 1.0f) : 0.5f)];
		
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
			
			if (element.created && frame % 5 == 1)
			{
				for (int p = 0; p < [people count]; p++)
				{
					Person *person = [people objectAtIndex:p];
					
					CGFloat dist = [self CGPointDistance:point to:person.pos];
					
					if (dist <= 20)
					{
						[self killPerson:person];
					}
				}
			}
		}
		
		CGContextStrokePath(context);
		
		if (element.lifetime <= 0)
		{
			[elements removeObject:element];
		}
	}
}

- (void)update:(NSTimer*)theTimer
{
	[self setNeedsDisplayInRect:self.frame];
}

#pragma mark -
#pragma mark RadialWeaponDelegate implementation

- (void)radialWeaponDidFire:(RadialWeapon *)weapon
{
    for (int i = 0; i < [people count]; i++) {
        Person * person = [people objectAtIndex:i];
        if ([weapon isPersonInLineOfFire:person]) {
            [self killPerson:person];
			i--;
        }
    }
}

- (void)dealloc {
	[displayTimer release];
	[elements release];
	[people release];
	
    [super dealloc];
}


@end
