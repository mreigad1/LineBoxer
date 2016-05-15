//
//  GameScene.m
//  project8
//
//  Created by Matthew Reigada on 4/14/16.
//  Copyright (c) 2016 Matthew Reigada. All rights reserved.
//

#import "GameScene.h"
#import "userTypes.h"
#import "MenuScene.h"
#import "GameoverScene.h"

@implementation GameScene

bool playerMoved = false;

SKLabelNode* pScore;
SKLabelNode* aScore;

CGFloat labelHeight;

-(void)didMoveToView:(SKView *)view {
	
	playerMoved = false;
	
    int dimension = [MenuScene passDimension];
    int ai = [MenuScene passAI];
    
    [board SET_BOARD_SIZE:dimension];

	[self setBackgroundColor:[UIColor blackColor]];

	_playerScore = _aiScore = 0;

    if(ai == 1){
        _ai_enabled = true;
    } else{
        _ai_enabled = false;
    }

	_brd = [[board alloc] init];
	[_brd addToView:self];
	_pyr = [[player alloc] init:self onBoard: _brd withPlayerType:PLAYER_USED];
	
	if(_ai_enabled){
		_ai = [[player alloc] init:self onBoard: _brd withPlayerType:AI_USED];
	}
	
    float y2 = .86;
	float step = 0.08;
    float y3 = y2 - step;
    float y1 = y2 + step;
    
    float x3 = (1.0 / 3.0);
    float x2 = (1.0 / 2.0);
    float x1 = (2.0 / 3.0);
	
	pScore = [SKLabelNode labelNodeWithText:@"0"];
	aScore = [SKLabelNode labelNodeWithText:@"0"];
	aScore.fontName = PREFERRED_FONT;
	pScore.fontName = PREFERRED_FONT;
	[pScore setFontColor:PLAYER_COLOR];
	[aScore setFontColor:AI_COLOR];
	labelHeight = [pScore frame].size.height;
	[pScore setPosition:CGPointMake([pScore frame].size.width, labelHeight)];
	[aScore setPosition:CGPointMake([self frame].size.width - [aScore frame].size.width, labelHeight)];
	[self addChild:pScore];
	if(_ai_enabled){
		[self addChild:aScore];
	}
	
    _nw = [[buttonControl alloc] initWithFile:@"nw.png"];
    [_nw setPosition:x1 y:y3];
    [_nw addToView:self];
    _nw.d_pad.name = @"7";//all names corespond to d-pad numbers
    
    _n = [[buttonControl alloc] initWithFile:@"n.png"];
    [_n setPosition:x2 y:y3];
    [_n addToView:self];
    _n.d_pad.name = @"8";
    
    _ne = [[buttonControl alloc] initWithFile:@"ne.png"];
    [_ne setPosition:x3 y:y3];
    [_ne addToView:self];
    _ne.d_pad.name = @"9";
    
    _e = [[buttonControl alloc] initWithFile:@"e.png"];
    [_e setPosition:x3 y:y2];
    [_e addToView:self];
     _e.d_pad.name = @"6";
    
    _se = [[buttonControl alloc] initWithFile:@"se.png"];
    [_se setPosition:x3 y:y1];
    [_se addToView:self];
     _se.d_pad.name = @"3";
    
    _s = [[buttonControl alloc] initWithFile:@"s.png"];
    [_s setPosition:x2 y:y1];
    [_s addToView:self];
     _s.d_pad.name = @"2";
    
    _sw = [[buttonControl alloc] initWithFile:@"sw.png"];
    [_sw setPosition:x1 y:y1];
    [_sw addToView:self];
     _sw.d_pad.name = @"1";
    
    _w = [[buttonControl alloc] initWithFile:@"w.png"];
    [_w setPosition:x1 y:y2];
    [_w addToView:self];
     _w.d_pad.name = @"4";
	
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    //TODO: give names to button then call player method with enum
    //UITouch *touch = [touches anyObject];
    //CGPoint touchPoint = [touch locationInNode:self];
    
    /*
    float tx = touchPoint.x;
    float ty = touchPoint.y;
    if (fabsf(_nw.location.x - tx) < 16 && fabsf(_nw.location.y - ty) < 16) {
        [_pyr movePlayer: NW];
    }else if (fabsf(_n.location.x - tx) < 16 && fabsf(_n.location.y - ty) < 16){
        [_pyr movePlayer: N];
    }else if (fabsf(_ne.location.x - tx) < 16 && fabsf(_ne.location.y - ty) < 16){
        [_pyr movePlayer: NE];
    }else if (fabsf(_e.location.x - tx) < 16 && fabsf(_e.location.y - ty) < 16){
        [_pyr movePlayer:E];
    }else if (fabsf(_se.location.x - tx) < 16 && fabsf(_se.location.y - ty) < 16){
        [_pyr movePlayer: SE];
    }else if (fabsf(_s.location.x - tx) < 16 && fabsf(_s.location.y - ty) < 16){
        [_pyr movePlayer: S];
    }else if (fabsf(_e.location.x - tx) < 16 && fabsf(_e.location.y - ty) < 16){
        [_pyr movePlayer:E];
    }else if (fabsf(_se.location.x - tx) < 16 && fabsf(_se.location.y - ty) < 16){
        [_pyr movePlayer:SE];
    }else if (fabsf(_s.location.x - tx) < 16 && fabsf(_s.location.y - ty) < 16){
        [_pyr movePlayer:S];
    }else if (fabsf(_sw.location.x - tx) < 16 && fabsf(_sw.location.y - ty) < 16){
        [_pyr movePlayer:SW];
    }else if (fabsf(_w.location.x - tx) < 16 && fabsf(_w.location.y - ty) < 16){
        [_pyr movePlayer:W];
    }
     */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        NSInteger name_to_int = node.name.integerValue;
		direction arg = NW;
		bool directionSet = false;
		switch (name_to_int){
            case 1:
				directionSet = true;
				arg = SW;
                break;
            case 2:
                directionSet = true;
				arg = S;
                break;
            case 3:
                directionSet = true;
				arg = SE;
                break;
            case 4:
                directionSet = true;
				arg = W;
                break;
            case 6:
                directionSet = true;
				arg = E;
                break;
            case 7:
                directionSet = true;
				arg = NW;
                break;
            case 8:
                directionSet = true;
				arg = N;
                break;
            case 9:
                directionSet = true;
				arg = NE;
                break;
            default:
                break;
        }
		
		if(directionSet){
			//caputre if player move successful
			playerMoved = [_pyr movePlayer:arg];
			
			if(playerMoved){
				_playerScore = _playerScore + 1;
				NSString *s = [@(_playerScore) stringValue];
				[pScore setText:s];
				[pScore setPosition:CGPointMake([pScore frame].size.width, labelHeight)];
			}
		}
    }
    
    //after player moves check if GAMEOVER (player has moves is false then GAMEOVER
    //I will do score
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
            [self runAction:[SKAction playSoundFileNamed:@"click2.wav" waitForCompletion:NO]];
    
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
	
	//if there is an ai that has moves
	if(_ai_enabled && [_ai playerHasMoves]){
		//if the human player moved or did not have moves
		if(playerMoved || [_pyr playerHasMoves] == false){
			playerMoved = false;
			
			direction directionAttempt;
			bool ai_moved = false;
			do{
				int r = arc4random_uniform(NUM_DIRECTIONS);
				directionAttempt = (direction)r;
			}while((ai_moved = [_ai movePlayer:directionAttempt]) == false && [_ai playerHasMoves] == true);
			
			if(ai_moved){
				_aiScore = _aiScore + 1;
				
				NSString *s = [@(_aiScore) stringValue];
				[aScore setText:s];
				[aScore setPosition:CGPointMake([self frame].size.width - [aScore frame].size.width, labelHeight)];
			}
		}
	}

	/*
	bool gameOver = ([_pyr playerHasMoves] == false);
	if(_ai_enabled){
		gameOver = gameOver && ([_ai playerHasMoves] == false);
	}
	if(gameOver){
		//transition to game over screen here
	}
	*/
	
    if(![_pyr playerHasMoves] && ![_ai playerHasMoves]){
        SKScene *sampleScene = [[GameoverScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition flipVerticalWithDuration:1.0];
        [self.view presentScene:sampleScene transition:transition];
    }
}

@end
