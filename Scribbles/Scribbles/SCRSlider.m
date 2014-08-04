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
        
//        UIButton * sizeButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 10, 30, 30)];
//        
//        sizeButton.backgroundColor = [UIColor blackColor];
//        sizeButton.layer.cornerRadius = 15;
//        [self addSubview:sizeButton];
        
    }
    return self;
}


 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
   // Drawing code
    
    
 

}


@end
 
