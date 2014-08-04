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

@interface SCRDrawViewController ()

@end

@implementation SCRDrawViewController

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
    
    
    SCRSlider * sliderView = [[SCRSlider alloc] initWithFrame:CGRectMake(10, 250, 100, 300)];
   
    [self.view addSubview:sliderView];
                              
                              
    
   
}

- (void)changeLineColor:(UIButton *)button
{
    SCRDrawView * view = (SCRDrawView *)self.view;
    
    view.lineColor = button.backgroundColor;
    [view setNeedsDisplay];
}

-(BOOL)prefersStatusBarHidden { return YES; }

@end
