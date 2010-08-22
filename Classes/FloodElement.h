//
//  FloodElement.h
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Element.h"


@interface FloodElement : Element {
	NSMutableArray *path;
	float lifetime;
	BOOL created;
}

@property (nonatomic, retain) NSMutableArray *path;
@property float lifetime;
@property BOOL created;

- (void)addPoint:(CGPoint)point;

@end
