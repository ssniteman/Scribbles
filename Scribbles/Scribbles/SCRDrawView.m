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
    
    
    for (NSDictionary * scribble in self.scribbles)
    {
       
        NSArray * points = (NSArray *) scribble[@"points"];
        
        
        UIColor * lineColor = scribble[@"color"];
        [lineColor set];
        
        if (points.count > 0)
        {
            
            CGPoint startPoint = [points[0] CGPointValue];
            
            CGContextMoveToPoint(context,startPoint.x, startPoint.y);
            
        }
        
        for (NSValue * pointVal in points)
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
    
    self.currentScribble = [@{
                              @"color":self.lineColor,
                              @"points":[@[] mutableCopy]
                              } mutableCopy];
    
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
        
        [self.currentScribble[@"points"] addObject: [NSValue valueWithCGPoint:location]];
    }
    
    [self setNeedsDisplay];
}

@end
