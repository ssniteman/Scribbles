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
        
        self.scribblePoints = [@[] mutableCopy];
        
        self.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // this grabs our conext layer to draw on
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // this sets stroke or fill colors that follow
    [[UIColor whiteColor] set];
    
    CGContextMoveToPoint(context,0, 0);
    
    for (NSValue * pointVal in self.scribblePoints)
    {
        CGPoint point = [pointVal CGPointValue];
        
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    
    
    // this draws the context
    CGContextStrokePath(context);
    
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        
        // adding object to our array ... 2nd half - needs to be a C object with a values
        
        [self.scribblePoints addObject: [NSValue valueWithCGPoint:location]];
    }
    
    [self setNeedsDisplay];
}


@end
