//
//  SCRSlider.m
//  Scribbles
//
//  Created by Shane Sniteman on 8/4/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "SCRSlider.h"

@implementation SCRSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        self.backgroundColor = [UIColor redColor];
        
       /*
        
       UIButton * sizeButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 10, 100, 30)];
        
       sizeButton.backgroundColor = [UIColor blackColor];
       sizeButton.layer.cornerRadius = 15;
       [self addSubview:sizeButton];
        
          // reference to sliderView size
        (10, 250, 100, 300)
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(50, 10, 1, 200)];
       lineView.backgroundColor = [UIColor blackColor];
       [self addSubview:lineView];
        
        
        float posY = self.frame.size.height - 80;
        UIView * sliderClick = [[UIView alloc] initWithFrame:CGRectMake(10, posY, 80, 80)];

        sliderClick.backgroundColor = [UIColor clearColor];
        sliderClick.layer.borderColor = [UIColor blackColor].CGColor;
        sliderClick.layer.borderWidth = 1;

        sliderClick.layer.cornerRadius = 40;
   
        [self addSubview:sliderClick];
        
        */
        
        
        self.maxWidth = 20;
        self.minWidth = 1;
        
        self.currentWidth = 1;
        
        self.backgroundColor = [UIColor clearColor];
        
    
        
        
        
        
        
        
        
        
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
   // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.lineColor set];
    
    float minY = 0;
    float maxY = rect.size.height;
    
    CGContextMoveToPoint(context, rect.size.width / 2.0, minY);
    CGContextAddLineToPoint(context, rect.size.width / 2.0, maxY);
    
    CGContextStrokePath(context);
    
    
    // flipping as you drag down, the button gets smaller
    
    float currentY = maxY - (self.currentWidth / self.maxWidth) * maxY;
    
    CGContextFillEllipseInRect(context, CGRectMake((rect.size.width - 10) / 2.0, currentY, 10, 10));
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    
    CGContextFillEllipseInRect(context, CGRectMake((rect.size.width - 8) / 2.0, currentY + 1, 8, 8));
    

 

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changeWidthWithTouches: touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changeWidthWithTouches: touches];
}

- (void)changeWidthWithTouches:(NSSet *)touches
{
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self];
    
    self.currentWidth = self.maxWidth - (location.y / self.frame.size.height * self.maxWidth);
    
    if (self.currentWidth < self.minWidth) self.currentWidth = self.minWidth;
    if (self.currentWidth > self.maxWidth) self.currentWidth = self.maxWidth;
    
    [self setNeedsDisplay];
}


@end
 
