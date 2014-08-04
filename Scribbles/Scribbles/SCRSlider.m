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
        
        self.backgroundColor = [UIColor redColor];
        
        
        
//       UIButton * sizeButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 10, 100, 30)];
//        
//       sizeButton.backgroundColor = [UIColor blackColor];
//       sizeButton.layer.cornerRadius = 15;
//       [self addSubview:sizeButton];
        
    
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(50, 10, 1, 200)];
        lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:lineView];
        
    }
    return self;
}

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
   // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();

 

}
*/

@end
 
