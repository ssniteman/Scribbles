//
//  SCRDrawView.m
//  Scribbles
//
//  Created by Shane Sniteman on 8/4/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "SCRDrawView.h"

@implementation SCRDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.scribbles = [@[] mutableCopy];
        
        
        self.lineColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // this grabs our context layer to draw on
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // this sets stroke or fill colors that follow
    [self.lineColor set];
    
    
    for (NSArray * scribble in self.scribbles)
    {
        if (scribble.count > 0)
        {
            
            CGPoint startPoint = [scribble[0] CGPointValue];
            
            CGContextMoveToPoint(context,startPoint.x, startPoint.y);
            
        }
        
        for (NSValue * pointVal in scribble)
        {
            CGPoint point = [pointVal CGPointValue];
            
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        
    }
    
  
    
    // this draws the context
    CGContextStrokePath(context);
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.currentScribble = [@[] mutableCopy];
    [self.scribbles addObject:self.currentScribble];
    
    NSLog(@"%@",self.scribbles);
    
    [self scribbleWithTouches:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self scribbleWithTouches:touches];
}

- (void)scribbleWithTouches: (NSSet *)touches
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        
        // adding object to our array ... 2nd half - needs to be a C object with a values
        
        [self.currentScribble addObject: [NSValue valueWithCGPoint:location]];
    }
    
    [self setNeedsDisplay];
}

@end
