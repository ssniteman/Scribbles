//
//  SCRDrawViewController.m
//  Scribbles
//
//  Created by Shane Sniteman on 8/4/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "SCRDrawViewController.h"
#import "SCRDrawView.h"
#import "SCRSlider.h"

@interface SCRDrawViewController () <SCRSliderDelegate>

@end

@implementation SCRDrawViewController
{
    
    NSArray * colors;
    NSMutableArray * colorButtons;
    
    UIButton * chooseColor;
    
    BOOL colorChoicesOpen;
    
    SCRSlider * lineSlider;
    UIView * lineWidthSize;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view = [[SCRDrawView alloc] initWithFrame:self.view.frame];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    /*
    NSArray * colors = @[
                         [UIColor cyanColor],
                         [UIColor magentaColor],
                         [UIColor yellowColor],
                         [UIColor blueColor]
                         ];
    
    for (UIColor * color in colors)
    {
        NSInteger index = [colors indexOfObject:color];
        
        NSLog(@"%d",(int)index);
        
        UIButton * colorButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10 + (50 * index), 40, 40)];
        
        
    colorButton.backgroundColor = color;
    colorButton.layer.cornerRadius = 20;
    
    [colorButton addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:colorButton];
        
    }
    */
    
    chooseColor = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 60) / 2.0, SCREEN_HEIGHT - 70, 60, 60)];
    
    chooseColor.layer.cornerRadius = 30;
    chooseColor.backgroundColor = colors[0];
    [chooseColor addTarget:self action:@selector(showColorChoices) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseColor];
    
    self.view.lineColor = colors[0];
    
    
    
    
    
    
    
    lineWidthSize = [[UIView alloc] initWithFrame:CGRectMake(0,0, 2,2)];
    lineWidthSize.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineWidthSize];
    
    UIButton * openLineWidthSlider = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 60, 40, 40)];
    openLineWidthSlider.layer.cornerRadius = 20;
    openLineWidthSlider.layer.borderWidth = 1.0;
    openLineWidthSlider.layer.borderColor = [UIColor blackColor].CGColor;
    
    [openLineWidthSlider addTarget:self action:@selector(openSlider) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:openLineWidthSlider];
    
    lineWidthSize.center = openLineWidthSlider.center;
    

   
    
    
    
   
}

- (void)openSlider
{
    if (lineSlider)
    {
        [lineSlider removeFromSuperview];
        lineSlider = nil;
        return;
    }
    
    
    // pointing to SCRSlider file subview
    
    lineSlider = [[SCRSlider alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 280, 40, 200)];
    
    lineSlider.currentWidth = self.view.lineWidth;
    
    lineSlider.delegate = self;
    
    [self.view addSubview:lineSlider];
    
}



- (void)updateLineWidth:(float)lineWidth
{
    self.view.lineWidth = lineWidth;
    
    CGPoint center = lineWidthSize.center;
    lineWidthSize.frame = CGRectMake(0, 0, lineWidth * 2, lineWidth * 2);
    lineWidthSize.center = center;
    lineWidthSize.layer.cornerRadius = lineWidth;
}



- (void)changeLineColor:(UIButton *)button
{
    SCRDrawView * view = (SCRDrawView *)self.view;
    
    view.lineColor = button.backgroundColor;
    [view setNeedsDisplay];
}


- (void)hideColorChoices
{
    
}


- (void)showColorChoices
{
    if (colorChoicesOpen)
    {
        [self hideColorChoices];
        return;
    }
    
    for (UIColor * color in colors)
    {
        NSInteger index = [colors indexOfObject:color];
        
        UIButton * colorButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        [colorButtons addObject: colorButton];
        
        colorButton.center = chooseColor.center;
        
        colorButton.backgroundColor = color;
        colorButton.layer.cornerRadius = 20;
        
        [colorButton addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];

        
        // getting the circle of dots around the middle one - crazy math
        
        float radius = 60;
        float mpi = M_PI/180;
        float angle = 360/colors.count;
        float radians = angle * mpi;
        
        float moveX = chooseColor.center.x + sinf(radians * index) * radius;
        float moveY = chooseColor.center.y + cosf(radians * index) * radius;
        
        [UIView animateWithDuration:0.2 delay:0.05 * index options:UIViewAnimationOptionAllowUserInteraction animations:^{
         
            colorButton.center = CGPointMake(moveX,moveY);
         
        
         } completion:^(BOOL finished) {
             
         }];
        
        [self.view insertSubview: colorButton atIndex:0];
    }
}











-(BOOL)prefersStatusBarHidden { return YES; }

@end

