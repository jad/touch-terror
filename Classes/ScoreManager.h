//
//  ScoreManager.h
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScoreManager : NSObject {
	int score;
}

@property int score;

+ (ScoreManager *)defaultManager;

@end
