//
//  GameScene.h
//  project8
//

//  Copyright (c) 2016 Matthew Reigada. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "board.h"
#import "player.h"
#import "buttonControl.h"

@interface GameScene : SKScene

	@property board* brd;
	@property player* pyr;
	@property player* ai;
	@property buttonControl* nw;
	@property buttonControl* n;
	@property buttonControl* ne;
	@property buttonControl* e;
	@property buttonControl* se;
	@property buttonControl* s;
	@property buttonControl* sw;
	@property buttonControl* w;
	@property bool ai_enabled;
	@property int playerScore;
	@property int aiScore;

@end
