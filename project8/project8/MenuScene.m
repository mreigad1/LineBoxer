//
//  MenuScene.m
//  project8
//
//  Created by Timothy Redband on 4/25/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuScene.h"
#import "GameScene.h"
#import "userTypes.h"

@implementation MenuScene
{
    SKLabelNode *_boardsizechanger;
    SKLabelNode *_aichanger;
}

static int staticBoardDimension;
static int ai_selector;

-(void)didMoveToView:(SKView *) view{
    staticBoardDimension = DEFAULT_BOARD_SIZE;
    ai_selector = 1;
    [self setBackgroundColor:[UIColor blackColor]];
    
    SKSpriteNode *title = [SKSpriteNode spriteNodeWithImageNamed:@"boxer_title.png"];
    CGPoint title_pos = CGPointMake((view.bounds.size.width / 2), (view.bounds.size.height / 1.5));
    [title setPosition:title_pos];
    [title setScale:0.85];
    [self addChild:title];
    
    SKSpriteNode *play_button = [SKSpriteNode spriteNodeWithImageNamed:@"play.png"];
    CGPoint play_pos = CGPointMake((view.bounds.size.width / 2), (view.bounds.size.height / 3));
    [play_button setPosition:play_pos];
    [play_button setScale:0.8];
    [play_button setName:@"play"];
    [self addChild:play_button];
    
    _boardsizechanger = [SKLabelNode labelNodeWithFontNamed:PREFERRED_FONT];
    _boardsizechanger.fontSize = 50;
    _boardsizechanger.text = [NSString stringWithFormat:@"%li", (long)staticBoardDimension];;
    CGPoint boardchanger_pos = CGPointMake((view.bounds.size.width / 4.0), (view.bounds.size.height / 7.0));
    [_boardsizechanger setPosition:boardchanger_pos];
    [_boardsizechanger setName:@"board_size"];
    [self addChild:_boardsizechanger];
    
    _aichanger = [SKLabelNode labelNodeWithFontNamed:PREFERRED_FONT];
    _aichanger.fontSize = 50;
    _aichanger.text = @"AI: ON";
	_aichanger.fontColor = AI_COLOR;
    CGPoint aichanger_pos = CGPointMake((view.bounds.size.width / 1.5), (view.bounds.size.height / 7.0));
    [_aichanger setPosition:aichanger_pos];
    [_aichanger setScale:0.9];
    [_aichanger setName:@"aichanger"];
    [self addChild:_aichanger];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if([node.name  isEqualToString:@"play"]){
            SKScene *sampleScene = [[GameScene alloc] initWithSize:self.size];
            SKTransition *transition = [SKTransition flipVerticalWithDuration:0.5];
            [self.view presentScene:sampleScene transition:transition];
        } else if([node.name isEqualToString:@"board_size"]){
            staticBoardDimension = (staticBoardDimension + 1) % (MAX_BOARD_SIZE + 1);
			staticBoardDimension = MAX(staticBoardDimension, MIN_BOARD_SIZE);

            NSString* newLabel = [NSString stringWithFormat:@"%li", (long)staticBoardDimension];
            _boardsizechanger.text = newLabel;
        } else if([node.name isEqualToString:@"aichanger"]){
            if(ai_selector){
                _aichanger.text = @"AI: OFF";
				_aichanger.fontColor = PLAYER_COLOR;
                ai_selector = 0;
            }else{
                _aichanger.text = @"AI: ON";
				_aichanger.fontColor = AI_COLOR;
				ai_selector = 1;
            }
            
        }
        
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:[SKAction playSoundFileNamed:@"click1.wav" waitForCompletion:NO]];
}

+(int) passDimension {
    return staticBoardDimension;
}

+(int) passAI{
    return ai_selector;
}

@end