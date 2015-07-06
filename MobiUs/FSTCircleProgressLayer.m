//
//  FSTCircleProgressLayer.m
//  FirstBuild
//
//  Created by Myles Caley on 5/22/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

//
//  CircleShapeLayer.m
//  CircularProgressControl
//
//  Created by Carlos Eduardo Arantes Ferreira on 22/11/14.
//  Copyright (c) 2014 Mobistart. All rights reserved.
//

#import "FSTCircleProgressLayer.h"

@interface FSTCircleProgressLayer ()

@property (assign, nonatomic) double initialProgress;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayerEnd;
@property (nonatomic, strong) CAShapeLayer *textBackground;

//@property (nonatomic, assign) CGRect frame;

@end

@implementation FSTCircleProgressLayer

@synthesize percent = _percent;

- (instancetype)init {
    if ((self = [super init]))
    {
        [self setupLayer];
    }
    
    return self;
}

- (void)layoutSublayers {
    
    self.path = [self drawPathWithArcCenter];
    self.progressLayer.path = [self drawPathWithArcCenter];
    self.progressLayerEnd.path = [self drawPathWithArcCenter];
    self.textBackground.path = [self drawTextBackground];
    self.textBackground.lineWidth = self.frame.size.width/3 - self.lineWidth/2; // fills the whole circle
    
    [super layoutSublayers];
}

- (void)setupLayer {
    
    self.path = [self drawPathWithArcCenter];
    self.fillColor = [UIColor clearColor].CGColor;
    UIColor* strokeColor = UIColorFromRGB(0xEA461A);//0xD43326);
    self.strokeColor = [strokeColor colorWithAlphaComponent:0.5].CGColor; // played with alpha (from 0.5)
    self.shadowColor = [UIColor whiteColor].CGColor; // changed from white
    self.shadowOpacity = .8;
    //self.shadowPath = self.path; // i think this is needed to keep it out of the inner circle
    self.shadowRadius = 2.0; // down from 3
    self.shadowOffset = CGSizeMake(0, 0);
    
    
    self.lineWidth = 25;
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.path = [self drawPathWithArcCenter];
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.progressLayer.lineWidth = 14;
    self.progressLayer.lineCap = kCALineJoinMiter;
    self.progressLayer.lineJoin = kCALineJoinRound;
    self.progressLayer.shadowColor = [UIColor whiteColor].CGColor;
    
    self.progressLayerEnd = [CAShapeLayer layer];
    self.progressLayerEnd.path = [self drawPathWithArcCenter];
    self.progressLayerEnd.lineWidth = self.lineWidth;
    self.progressLayerEnd.strokeColor = [UIColor whiteColor].CGColor;
    self.progressLayerEnd.fillColor = [UIColor clearColor].CGColor;
    self.progressLayerEnd.lineCap = kCALineJoinMiter;
    self.progressLayerEnd.lineJoin = kCALineJoinRound;
    self.progressLayerEnd.shadowOpacity = 0.0;
    
    self.textBackground = [CAShapeLayer layer];
    self.textBackground.path = [self drawTextBackground];
    UIColor *backColor = [UIColor grayColor]; // stroke fills whole circle in
    self.textBackground.strokeColor = [backColor colorWithAlphaComponent:0.7].CGColor; //background translucent
    self.textBackground.fillColor = [UIColor clearColor].CGColor;
    self.textBackground.lineCap = kCALineJoinMiter;
    self.textBackground.lineJoin = kCALineJoinMiter;
    self.textBackground.shadowColor = [UIColor clearColor].CGColor;
    self.textBackground.shadowOpacity = 0.0; // make shadows start transparent
    //self.shadowPath = self.path;
    self.textBackground.shadowRadius = 0.0;
    self.textBackground.shadowOffset = CGSizeMake(0, 0);
    
    [self addSublayer:self.progressLayer];
    [self addSublayer:_progressLayerEnd];
    [self insertSublayer:self.textBackground above:self];
    //[self addSublayer:self.textBackground];
    //set up background pulsing
    CABasicAnimation* shadowAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    shadowAnimation.fromValue = @(0.0);
    shadowAnimation.toValue = @(0.8);
    shadowAnimation.repeatCount = HUGE_VALF; // runs indefinitely
    shadowAnimation.duration = 1.7; // down from 2.0
    shadowAnimation.autoreverses = YES; // repeats opacity transition to fade in, out (fromvalue and tovalue alternate)
    shadowAnimation.removedOnCompletion = YES; // not sure if needed, hopefully finishes at end of view
    [self addAnimation:shadowAnimation forKey:nil]; // animate the shadow pulse
    // trying it on the line subview rather than the whole layer
}

- (CGPathRef)drawPathWithArcCenter {
    
    CGFloat position_y = self.frame.size.height/2;
    CGFloat position_x = self.frame.size.width/2; // Assuming that width == height
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(position_x, position_y)
                                          radius:position_x/1.5
                                      startAngle:(-M_PI/2)
                                        endAngle:(3*M_PI/2)
                                       clockwise:YES].CGPath;
}

- (CGPathRef)drawTextBackground {
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                          radius:(self.frame.size.width/3 - (self.lineWidth/2))/2
                                      startAngle:(-M_PI/2)
                                        endAngle:3*M_PI/2
                                       clockwise:YES].CGPath;
}

- (void)setElapsedTime:(NSTimeInterval)elapsedTime {
    _initialProgress = [self calculatePercent:_elapsedTime toTime:_timeLimit];
    _elapsedTime = elapsedTime;
    
    self.progressLayer.strokeEnd = self.percent;
    self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.progressLayerEnd.strokeColor = [UIColor whiteColor].CGColor;
    self.progressLayerEnd.strokeStart = self.percent;
    self.progressLayerEnd.strokeEnd = self.percent + .005;
    //[self startAnimation];
}

- (double)percent {
    
    _percent = [self calculatePercent:_elapsedTime toTime:_timeLimit];
    return _percent;
}

- (void)setProgressColor:(UIColor *)progressColor {
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (double)calculatePercent:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime {
    
    if ((toTime > 0) && (fromTime > 0)) {
        
        CGFloat progress = 0;
        
        progress = fromTime / toTime;
        
        if ((progress * 100) > 100) {
            progress = 1.0f;
        }
                
        return progress;
    }
    else
        return 0.0f;
}

- (void)startAnimation {
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = @(self.initialProgress);
    pathAnimation.toValue = @(self.percent);
    pathAnimation.removedOnCompletion = YES;
    
    [self.progressLayer addAnimation:pathAnimation forKey:nil];
    
    CABasicAnimation *endPathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    endPathAnimation.duration = 1;
    endPathAnimation.fromValue = @(self.initialProgress);
    endPathAnimation.toValue = @(self.percent);
    endPathAnimation.removedOnCompletion = YES;
    
    [self.progressLayerEnd addAnimation:endPathAnimation forKey:nil];
    
}

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net

