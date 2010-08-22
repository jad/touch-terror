//
//  TouchTerrorAppDelegate.h
//  TouchTerror
//
//  Created by Andy Riordan on 8/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchTerrorViewController;

@interface TouchTerrorAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TouchTerrorViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TouchTerrorViewController *viewController;

@end

