//
//  ScoreManager.m
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ScoreManager.h"


@implementation ScoreManager
@synthesize score;

- (ScoreManager *)defaultManager
{
	static ScoreManager *shared;
	
	if (shared == nil)
	{
		shared = [[ScoreManager alloc] init];
	}
	
	return shared;
}

@end
