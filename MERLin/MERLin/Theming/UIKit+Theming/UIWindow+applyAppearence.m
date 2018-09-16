//
//  UIWindow+applyAppearence.m
//  MERLin
//
//  Created by Giuseppe Lanza on 16/09/2018.
//  Copyright © 2018 Giuseppe Lanza. All rights reserved.
//

#import "UIWindow+applyAppearence.h"
#import <MERLin/MERLin-Swift.h>

@implementation UIWindow (applyAppearence)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(makeKeyWindow);
        SEL swizzledSelector = @selector(swizzled_makeKeyWindow);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        //We try to add the implementation of the swizzled method in the original selector.
        //This operation will succede only if the subclass did not override the original selector.
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            //If we succede, we need to replace the swizzled method implementation with the original
            //method implementation. In short, this case fallsback in a runtime override.
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            //In case of failure, a method override the original method. Then, a simple exchange of
            //implementations is enough.
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });

}

-(void) swizzled_makeKeyWindow {
    [self swizzled_makeKeyWindow];
    [self applyDefaultThemeWithOverrideLocal:NO];
}

@end
