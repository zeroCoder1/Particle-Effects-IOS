//
//  SparkleTouchView.m
//  caemit
//
//  Created by Shrutesh on 13/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "TheSparky.h"

@implementation TheSparky

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        hue = 0.0;
        // Initialization code    
        [self setMultipleTouchEnabled:YES];    
        
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    
    // Log everything (there will be repetition because the event contains the set of touches):
    NSLog(@"ccTouchesBegan: touches = %@; event = %@", touches, event);
    
    // Or, just log the number of touches to simplify the output:
    NSLog(@"ccTouchesBegan: %d touches", [touches count]);
    
    
    
    
    NSArray * allTouches=[touches allObjects];
    UITouch * touch = [touches anyObject];
    
    int count = [allTouches count];
    
    if (count == 1){
        if ([touch tapCount]<2) {
            
            if (CGRectContainsPoint(CGRectMake(0, 0, 1024, 768), [[allTouches objectAtIndex:0] locationInView:self])) {
                
                float multiplier = 0.25f;
                CGPoint pt = [[allTouches objectAtIndex:0] locationInView:self];
                
                //Create the emitter layer
                emitter = [CAEmitterLayer layer];
                emitter.emitterPosition = pt;
                emitter.emitterMode = kCAEmitterLayerOutline;
                emitter.emitterShape = kCAEmitterLayerCircle;
                emitter.renderMode = kCAEmitterLayerAdditive;
                emitter.emitterSize = CGSizeMake(100 * multiplier, 0);
                emitter.spin = 9;
                emitter.scale=.5;
                //Create the emitter cell
                particle = [CAEmitterCell emitterCell];
                particle.emissionLongitude = M_PI;
                particle.birthRate = multiplier * 1000.0;
                particle.lifetime = multiplier;
                particle.lifetimeRange = multiplier * 0.35;
                particle.velocity = 200;//was20
                particle.velocityRange = 130;
                particle.emissionRange = 5.1;
                particle.scaleSpeed = 1.0; // was 0.3
                
                particle.contents = (__bridge id)([UIImage imageNamed:@"fire.png"].CGImage);
                particle.name = @"particle";
                emitter.emitterCells = [NSArray arrayWithObject:particle];
                [self.layer addSublayer:emitter];
            }
        }
    }
    
    else if( count == 2 ){
        
        touch1 = [[allTouches objectAtIndex:0] locationInView:self]; 
        touch2 = [[allTouches objectAtIndex:1] locationInView:self];
        
        float multiplier = 0.25f;
        
        CGPoint pt = [[allTouches objectAtIndex:0] locationInView:self];
        
        //Create the emitter layer
        emitter = [CAEmitterLayer layer];
        emitter.emitterPosition = pt;
        emitter.emitterMode = kCAEmitterLayerOutline;
        emitter.emitterShape = kCAEmitterLayerCircle;
        emitter.renderMode = kCAEmitterLayerAdditive;
        emitter.emitterSize = CGSizeMake(100 * multiplier, 0);
        emitter.spin = 9;
        emitter.scale=.5;
        //Create the emitter cell
        particle = [CAEmitterCell emitterCell];
        particle.emissionLongitude = M_PI;
        particle.birthRate = multiplier * 1000.0;
        particle.lifetime = multiplier;
        particle.lifetimeRange = multiplier * 0.35;
        particle.velocity = 200;//was20
        particle.velocityRange = 130;
        particle.emissionRange = 5.1;
        particle.scaleSpeed = 1.0; // was 0.3
        
        particle.contents = (__bridge id)([UIImage imageNamed:@"fire.png"].CGImage);
        particle.name = @"particle";
        emitter.emitterCells = [NSArray arrayWithObject:particle];
        [self.layer addSublayer:emitter];
        
        
        float multiplier2 = 0.25f;
        
        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];;
        
        //Create the emitter layer
        emitter2 = [CAEmitterLayer layer];
        emitter2.emitterPosition = pt2;
        emitter2.emitterMode = kCAEmitterLayerOutline;
        emitter2.emitterShape = kCAEmitterLayerCircle;
        emitter2.renderMode = kCAEmitterLayerAdditive;
        emitter2.emitterSize = CGSizeMake(100 * multiplier2, 0);
        emitter2.spin = 9;
        emitter2.scale=.5;
        //Create the emitter cell
        particle2 = [CAEmitterCell emitterCell];
        particle2.emissionLongitude = M_PI;
        particle2.birthRate = multiplier2 * 1000.0;
        particle2.lifetime = multiplier2;
        particle2.lifetimeRange = multiplier2 * 0.35;
        particle2.velocity = 200;//was20
        particle2.velocityRange = 130;
        particle2.emissionRange = 5.1;
        particle2.scaleSpeed = 1.0; // was 0.3
        
        particle2.contents = (__bridge id)([UIImage imageNamed:@"fire.png"].CGImage);
        particle2.name = @"particle";
        emitter2.emitterCells = [NSArray arrayWithObject:particle2];
        [self.layer addSublayer:emitter2];
        
    }
    
    
}




- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    CGPoint currentTouch1;
    CGPoint currentTouch2;
    
    NSArray *allTouches = [touches allObjects]; 
    int count = [allTouches count]; 
    
    if (count == 1) {
        
        if (CGRectContainsPoint(CGRectMake(0, 0, 768, 1024), [[allTouches objectAtIndex:0] locationInView:self])) {
            
            hue += 0.005;
            if(hue > 1.0) hue = 0.0;
            currentTouch1 = [[allTouches objectAtIndex:0] locationInView:self]; 
            UIColor *colors = [UIColor colorWithHue:hue saturation:1 brightness:1.0 alpha:1.0];
            particle.color = [colors CGColor];
            // Disable implicit animations
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            emitter.emitterPosition = currentTouch1;    
            [CATransaction commit]; 
            
            
        }
    }
    
    else if (count > 1) {
        
        if ((CGRectContainsPoint(CGRectMake(0, 0, 768, 1024), [[allTouches objectAtIndex:0] locationInView:self])) ||
            (CGRectContainsPoint(CGRectMake(0, 0, 768, 1024), [[allTouches objectAtIndex:1] locationInView:self]))) {
            
            currentTouch1 = [[allTouches objectAtIndex:0] locationInView:self]; 
            currentTouch2 = [[allTouches objectAtIndex:1] locationInView:self];
            
            // CGPoint pt = [[touches anyObject] locationInView:self];
            hue += 0.005;
            if(hue > 1.0) hue = 0.0;
            UIColor *colors = [UIColor colorWithHue:hue saturation:1 brightness:1.0 alpha:1.0];
            particle.color = [colors CGColor];
            // Disable implicit animations
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            emitter.emitterPosition = currentTouch1;    
            [CATransaction commit]; 
            
            //   CGPoint pt2 = [[touches anyObject] locationInView:self];
            hue += 0.005;
            if(hue > 1.0) hue = 0.0;
            UIColor *colors2 = [UIColor colorWithHue:hue saturation:1 brightness:1.0 alpha:1.0];
            particle2.color = [colors2 CGColor];
            // Disable implicit animations
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            emitter2.emitterPosition = currentTouch2;    
            [CATransaction commit];    
        }
    }
    
    
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* [emitter removeFromSuperlayer];
     emitter = nil;
     
     [emitter2 removeFromSuperlayer];
     emitter2 = nil;*/
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    if ([touch tapCount] > 1) {
        
        [emitter removeFromSuperlayer];
        emitter = nil;
        [emitter2 removeFromSuperlayer];
        emitter2 = nil;
        
        
    }
    else if ([touch tapCount] <2) {
        
        [emitter removeFromSuperlayer];
        emitter = nil;
        [emitter2 removeFromSuperlayer];
        emitter2 = nil;
        
    }
    
    
    
    
}



- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event]; 
    
} 




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end