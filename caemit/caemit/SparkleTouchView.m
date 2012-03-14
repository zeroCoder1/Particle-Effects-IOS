//
//  SparkleTouchView.m
//  caemit
//
//  Created by Shrutesh on 13/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SparkleTouchView.h"
#define COOKBOOK_PURPLE_COLOR = 
@implementation SparkleTouchView

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
    float multiplier = 0.25f;
    
    CGPoint pt = [[touches anyObject] locationInView:self];
    
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

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    hue += 0.005;
    if(hue > 1.0) hue = 0.0;
    UIColor *colors = [UIColor colorWithHue:hue saturation:1 brightness:1.0 alpha:1.0];
    particle.color = [colors CGColor];
    // Disable implicit animations
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    emitter.emitterPosition = pt;    
    [CATransaction commit];    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [emitter removeFromSuperlayer];
    emitter = nil;
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event]; } 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
