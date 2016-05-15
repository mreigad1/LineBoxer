//
//  player.h
//  project8
//
//  Created by Timothy Redband on 4/24/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#ifndef player_h
#define player_h

#import <SpriteKit/SpriteKit.h>
#import "userTypes.h"
#import "board.h"
#import "boardLocation.h"
#import "edge.h"

@interface player: NSObject

	@property int xGridPos;
	@property int yGridPos;
	@property SKShapeNode* sprite;
	@property board* brd;
	@property locationState playerState;

	//constructor method with scene to add sprite to
		-(id)init:(SKScene*) s onBoard:(board*) b withPlayerType:(locationState) playerType;

	//method will attempt to move player and will return false if invalid move attempted
	-(bool)movePlayer: (direction) d;

	//method shall state if player has remaining moves, if false then game over
	-(bool)playerHasMoves;

@end


#endif /* player_h */
