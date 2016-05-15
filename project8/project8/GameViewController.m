//
//  GameViewController.m
//  project8
//
//  Created by Matthew Reigada on 4/14/16.
//  Copyright (c) 2016 Matthew Reigada. All rights reserved.
//
@import AVFoundation;
#import "GameViewController.h"
#import "GameScene.h"
#import "MenuScene.h"

@interface GameViewController ()
@property (nonatomic) AVAudioPlayer * openingMusicPlayer;
@end

@implementation GameViewController

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    NSError *error;
    NSURL * openingMusicURL = [[NSBundle mainBundle] URLForResource:@"opening" withExtension:@"wav"];
    self.openingMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:openingMusicURL error:&error];
    self.openingMusicPlayer.numberOfLoops = 0;
    [self.openingMusicPlayer prepareToPlay];
    [self.openingMusicPlayer play];
    // Configure the view.
    
    SKView * skView = (SKView *)self.view;
    
    if(!skView.scene){
        
        /*
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        skView.ignoresSiblingOrder = YES;
         */
        // Create and configure the scene.
        //GameScene *scene = [GameScene sceneWithSize:skView.bounds.size];
        MenuScene *scene = [MenuScene sceneWithSize:skView.bounds.size];
        
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // NSLog(@"%f,%f",scene.anchorPoint.x, scene.anchorPoint.y);
        // Present the scene.
        [skView presentScene:scene];
    }
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
