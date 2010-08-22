//
//  GameView.h
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ScoreManager.h"
#import "Person.h"
#import "FloodElement.h"


@interface GameView : UIView {
	NSTimer *displayTimer;

	NSMutableArray *people;
	
	FloodElement *currentElement;
	NSMutableArray *elements;
}

@end
