//
//  ViewController.m
//  AddMob
//
//  Created by Mostafizur Rahman on 11/27/17.
//  Copyright © 2017 Mostafizur Rahman. All rights reserved.
//

#import "ADViewController.h"

@interface ADViewController (){
    NSTimer *addTimer;
    GADInterstitial *interstitial;
    int timerCount;
}

@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Replace this ad unit ID with your own ad unit ID.
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    request.testDevices = @[ kGADSimulatorID ];
    [self.bannerView loadRequest:request];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self createAndLoadInterstitial];
    addTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                target:self
                                              selector:@selector(decrementTimeLeft:)
                                              userInfo:nil
                                               repeats:YES];
    
    timerCount = 0;
}

- (void)createAndLoadInterstitial {
    interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    
    GADRequest *request = [GADRequest request];
    // Request test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made.
    request.testDevices = @[ kGADSimulatorID, @"befc4842ab25ad64304c5e0f49bc76d91c476bed" ];
    [interstitial loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)decrementTimeLeft:(NSTimer *)d_timer{
    if(++timerCount == 5){
        if (interstitial.isReady) {
            [interstitial presentFromRootViewController:self];
            [self createAndLoadInterstitial];
        } else {
            NSLog(@"Ad wasn't ready");
        }
        timerCount = 0;
    }
}

@end
