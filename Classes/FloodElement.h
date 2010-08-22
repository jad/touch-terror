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
}

@property (nonatomic, retain) NSMutableArray *path;

- (void)addPoint:(CGPoint)point;

@end
