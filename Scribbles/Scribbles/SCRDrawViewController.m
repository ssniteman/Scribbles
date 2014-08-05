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
        
        colors = @[
                   [UIColor colorWithRed:0.992f green:0.533f blue:0.141f alpha:1.0f],
                   [UIColor colorWithRed:0.988f green:0.071f blue:0.384f alpha:1.0f],
                   [UIColor colorWithRed:0.255f green:0.067f blue:0.584f alpha:1.0f],
                   [UIColor colorWithRed:0.051f green:0.310f blue:0.851f alpha:1.0f],
                   [UIColor colorWithRed:0.173f green:0.996f blue:0.867f alpha:1.0f],
                   [UIColor colorWithRed:0.165f green:0.976f blue:0.596f alpha:1.0f],
                   [UIColor colorWithRed:0.996f green:0.914f blue:0.204f alpha:1.0f],
                   
                   ];
        
        colorButtons = [@[] mutableCopy];
        

        
        
        self.view = [[SCRDrawView alloc] initWithFrame:self.view.frame];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    
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
    
    colorChoicesOpen = YES;
}

- (void)hideColorChoices
{

    
    for (UIButton * colorButton in colorButtons)
     {
         NSInteger index = [colorButtons indexOfObject:colorButton];
         
         [UIView animateWithDuration:.2 delay:.05 * index options:UIViewAnimationOptionAllowUserInteraction animations:^{
             
             colorButton.center = chooseColor.center;
         } completion:^(BOOL finished) {
             
             [colorButton removeFromSuperview];
             
         }];
     }
    
    [colorButtons removeAllObjects];
    
    colorChoicesOpen = NO;
}











-(BOOL)prefersStatusBarHidden { return YES; }

@end

