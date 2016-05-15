//
//  GameoverScene.m
//  project8
//
//  Created by Timothy Redband on 4/25/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//
@import AVFoundation;
#import <Foundation/Foundation.h>
#import "MenuScene.h"
#import "GameoverScene.h"
#import "userTypes.h"

@interface GameoverScene()
@property (nonatomic) AVAudioPlayer * gameOverMusicPlayer;

@end
@implementation GameoverScene


-(void)didMoveToView:(SKView *) view{
    NSError *error;
    NSURL * gameOverMusicURL = [[NSBundle mainBundle] URLForResource:@"lose" withExtension:@"mp3"];
    self.gameOverMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:gameOverMusicURL error:&error];
    self.gameOverMusicPlayer.numberOfLoops = 0;
    [self.gameOverMusicPlayer prepareToPlay];
    [self.gameOverMusicPlayer play];
    
    [self setBackgroundColor:[UIColor blackColor]];

    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:PREFERRED_FONT];
    label.fontSize = 50;
	label.fontColor = PLAYER_COLOR;
    label.text = @"GAME OVER";
    CGPoint label_pos = CGPointMake((view.bounds.size.width / 2), (view.bounds.size.height / 2));
    [label setPosition:label_pos];
    [label setName:@"label"];
    [self addChild: label];
    
    [self runAction:[SKAction sequence:@[[SKAction waitForDuration:3.0], [SKAction runBlock:^(void){
        SKTransition *transition = [SKTransition crossFadeWithDuration:1.0];
        SKScene *sampleScene = [[MenuScene alloc] initWithSize:self.size];
        [self.view presentScene:sampleScene transition:transition];
    }]]]];
    

}

@end