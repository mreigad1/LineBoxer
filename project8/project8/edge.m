//
//  edge.m
//  project8
//
//  Created by Matthew Reigada on 4/14/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "edge.h"
#import "board.h"
#import "userTypes.h"

@implementation edge : NSObject

	//constructor for object,
	//the start and end shall be immutable for an edge, thus no setter/getters
	-(id)init:(boardLocation*) e{
		_end = e;
		_locState = NOT_USED;
		return self;
	}

	-(SKColor*)getColor{
		SKColor* c;
		switch(_locState){
			case NOT_USED:
				c = DEFAULT_EDGE_COLOR;
			break;
			case PLAYER_USED:
				c = PLAYER_EDGE_COLOR;
			break;
			case AI_USED:
				c = AI_EDGE_COLOR;
			break;
			default:
				c = nil;
			break;
		}
		return c;
	}

	-(void) updateSpriteColor{
		if(_sprite != nil){
			((SKShapeNode*)_sprite).strokeColor = [self getColor];
		}
	}

	-(void) updateEdgeState:(locationState) newState{
		_locState = newState;
		[self updateSpriteColor];
	}

	-(SKNode*)createNode:(boardLocation*) start withDim:(CGSize) viewDim{
		SKShapeNode* retVal = [[SKShapeNode alloc] init];
		
		CGMutablePathRef pathToDraw = CGPathCreateMutable();
		
		//start pos
		double sx = [start location].x * viewDim.width;
		double sy = [start location].y * viewDim.height;
		
		//end pos
		double ex = [_end location].x * viewDim.width;
		double ey = [_end location].y * viewDim.height;
		
		CGPathMoveToPoint(pathToDraw, nil, sx, sy);
		CGPathAddLineToPoint(pathToDraw, nil, ex, ey);
		
		retVal.path = pathToDraw;
		retVal.strokeColor = [self getColor];
		retVal.lineWidth = [board EDGE_THICKNESS];
		retVal.name = nil;
		[retVal setZPosition:2];
		
		_sprite = retVal;
		
		if (false == (ey < sy || (ey <= sy && ex > sx))){
			retVal = nil;
		}
		
		return retVal;
	}

@end