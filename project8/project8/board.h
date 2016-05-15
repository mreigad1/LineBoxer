//
//  board.h
//  project8
//
//  Created by Matthew Reigada on 4/14/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#ifndef board_h
#define board_h

#import <SpriteKit/SpriteKit.h>

@interface board : NSObject

	//3-dimensional array of edge objects, edges[i][j] list all the nodes to which locations[i][j] connects 
	@property NSMutableArray* edges;
	@property NSMutableArray* locations;

	//Method for adding nodes to scene
	-(void) addToView: (SKScene*) s;

	//method for creating a board
	-(void)initSquareBoard:(int) dimension;

	//TODO: Uncapitalize for better coding style,
	//Static methods done in all caps since they were originally macros
	+(void) SET_BOARD_SIZE:(int) newSize;

	+(int) GET_BOARD_SIZE;

	+(int) LOCATION_SIZE;

	+(int) SELECTED_LOCATION_SIZE;

	+(int) EDGE_THICKNESS;

	+(double) MOVEMENT_DURATION;

@end

#endif /* board_h */
