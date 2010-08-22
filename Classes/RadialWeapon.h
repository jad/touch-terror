#import <Foundation/Foundation.h>

@class Person;
@protocol RadialWeaponDelegate;

@interface RadialWeapon : NSObject
{
}

@property (nonatomic, assign) id<RadialWeaponDelegate> delegate;
@property (nonatomic, retain, readonly) UIView * view;

- (id)initWithView:(UIView *)view;

- (BOOL)isPersonInLineOfFire:(Person *)person;

@end

@protocol RadialWeaponDelegate
- (void)radialWeaponDidFire:(RadialWeapon *)weapon;
@end
