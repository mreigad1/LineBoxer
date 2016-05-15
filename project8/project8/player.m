//
//  player.m
//  project8
//
//  Created by Timothy Redband on 4/24/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "player.h"
#import "board.h"


@implementation player

	-(id)init:(SKScene*) s onBoard:(board*) b withPlayerType:(locationState) playerType{
		
		_playerState = playerType;
		
		_xGridPos = 0;
		_yGridPos = 0;

		SKColor* fillColor;
		SKColor* borderColor;
		switch(_playerState){
			case NOT_USED:
				fillColor = [SKColor orangeColor];
				borderColor = [SKColor yellowColor];
			break;
			case PLAYER_USED:
				fillColor = PLAYER_COLOR;
				borderColor = [SKColor blackColor];
			break;
			case AI_USED:
				fillColor = AI_COLOR;
				borderColor = [SKColor blackColor];
			break;
			default:
				fillColor = [SKColor purpleColor];
				borderColor = [SKColor cyanColor];
			break;
		}
		
		_brd = b;
		_sprite = [SKShapeNode shapeNodeWithCircleOfRadius:[board SELECTED_LOCATION_SIZE]];
		[_sprite setStrokeColor:borderColor];
		[_sprite setFillColor:fillColor];
		
		NSMutableArray* locs = [_brd locations];
		if(playerType == AI_USED){
			_yGridPos = (int)locs.count - 1;
		 }
		NSMutableArray* row = locs[_yGridPos];
		if(playerType == AI_USED){
			_xGridPos = (int)row.count - 1;
		 }
		boardLocation* playerLoc = row[_xGridPos];
		CGPoint pos = [playerLoc sprite].position;
		[_sprite setPosition: pos];
		[_sprite setZPosition:4.0];
		
		[s addChild:_sprite];
		return self;
	}

	//method will attempt to move player and will return false if invalid move attempted
	-(bool)movePlayer: (direction) d{
		int xoffset = 0;
		int yoffset = 0;
		
		//get yoffset from state
		if(d == NW || d == N || d == NE){
			yoffset = 1;
		}else if (d == SW || d == S || d == SE){
			yoffset = -1;
		}
		
		//get xoffset from state
		if(d == NW || d == W || d == SW){
			xoffset = -1;
		}else if(d == NE || d == E || d == SE){
			xoffset = 1;
		}
		
		//cannot move to self, thus check that direction has been set validly
		if(yoffset != 0 || xoffset != 0){
			
			//get grid/array coordinates of both nodes in requested move
			int sx = _xGridPos;
			int sy = _yGridPos;
			int ex = _xGridPos + xoffset;
			int ey = _yGridPos + yoffset;
			
			NSMutableArray* firstRow = [_brd locations][0];
			int height = (int)([_brd locations].count);
			int width = (int)firstRow.count;
			
			//cannot move off grid, return false
			if(ex < 0 || ex >= width || ey < 0 || ey >= height){
				return false;
			}
			
			//get both board locations
			boardLocation* currentNode = [_brd locations][sy][sx];
			boardLocation* nextNode = [_brd locations][ey][ex];
			
			//get both list of edges leaving requested nodes, used for edge coloring
			NSMutableArray* currentNodeEdges = [_brd edges][sy][sx];
			NSMutableArray* nextNodeEdges = [_brd edges][ey][ex];
			
			//first flag detects edge coloring one way, next flag detects edge coloring the other way
			bool moveFoundA = false;
			bool moveFoundB = false;
			
			//iterate edges leaving first node
			for(int i = 0; i < currentNodeEdges.count; i++){
				//get each edge
				edge* e = currentNodeEdges[i];
				//if edge leads to requested node and is not yet used then color it
				if(e.end == nextNode && [e locState] == NOT_USED){
					[e updateEdgeState:_playerState];
					moveFoundA = true;
				}
			}
			
			//iterate edges leaving second node
			for(int i = 0; i < nextNodeEdges.count; i++){
				//get each edge
				edge* e = nextNodeEdges[i];
				//if edge leads to requested end node and state of edge is unused then color it
				if(e.end == currentNode && [e locState] == NOT_USED){
					[e updateEdgeState:_playerState];
					moveFoundB = true;
				}
			}
			
			//assert that edge has been colored both ways
			assert(moveFoundA == moveFoundB);
			
			if(moveFoundA && moveFoundB){
				//set new grid coordinates of player
				_xGridPos = ex;
				_yGridPos = ey;
				//move player to end of edge taken
				CGPoint end = [[nextNode sprite] position];
				[_sprite runAction:[SKAction moveTo:end duration:[board MOVEMENT_DURATION]]];
				//return true for successful move
				return true;
			}
		}
		//return false for unsuccessful move
		return false;
	}

	//method shall state if player has remaining moves, if false then game over
	-(bool)playerHasMoves{
		//get all edges at the player's current location
		NSMutableArray* playersEdges = [_brd edges][_yGridPos][_xGridPos];
		
		//if any edge is NOT_USED, return true
		for(int i = 0; i < playersEdges.count; i++){
			edge* e = playersEdges[i];
			if([e locState] == NOT_USED){
				return true;
			}
		}
		return false;
	}

@end