//
//  FloodElement.m
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FloodElement.h"


@implementation FloodElement
@synthesize path;

- (id)init
{
	if (self = [super init])
	{
		path = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void)addPoint:(CGPoint)point
{
	NSValue *value = [NSValue valueWithCGPoint:point];
	[path addObject:value];
}

- (void)dealloc
{
	[path release];
	
	[super dealloc];
}

@end
