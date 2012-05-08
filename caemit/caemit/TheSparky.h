//
//  SparkleTouchView.h
//  caemit
//
//  Created by Shrutesh on 13/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TheSparky : UIView{
    
    CAEmitterLayer * emitter;
    CAEmitterLayer * emitter2;
    
    float hue;
    
    CAEmitterCell* particle;
    CAEmitterCell* particle2;
    
    CGPoint touch1;
    CGPoint touch2;
}

@end
