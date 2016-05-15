//
//  direction.h
//  project8
//
//  Created by Matthew Reigada on 4/24/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#ifndef userTypes_h
#define userTypes_h

#define NUM_DIRECTIONS 8
#define MAX_BOARD_SIZE 15
#define MIN_BOARD_SIZE 2
#define DEFAULT_BOARD_SIZE 5
#define PREFERRED_FONT @"Optima-ExtraBlack"

#define TOKEN_DARKEN 0.2
//Transparency- 0.5 good for coloring, 0.0 good for removing edges
#define TRANSPARENCY 0.4


#define AI_R 0.0
#define AI_G 1.0
#define AI_B 0.0

#define PLAYER_R 1.0
#define PLAYER_G 0.0
#define PLAYER_B 0.0

#define PLAYER_COLOR 		[SKColor colorWithRed:PLAYER_R-TOKEN_DARKEN green:PLAYER_G-TOKEN_DARKEN blue:PLAYER_B-TOKEN_DARKEN alpha:1.0]
#define AI_COLOR 			[SKColor colorWithRed:AI_R-TOKEN_DARKEN green:AI_G-TOKEN_DARKEN blue:AI_B-TOKEN_DARKEN alpha:1.0]

#define PLAYER_EDGE_COLOR	[SKColor colorWithRed:PLAYER_R green:PLAYER_G blue:PLAYER_B alpha:TRANSPARENCY]
#define AI_EDGE_COLOR 		[SKColor colorWithRed:AI_R green:AI_G blue:AI_B alpha:TRANSPARENCY]
#define DEFAULT_EDGE_COLOR	[SKColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.4]

typedef enum locationStateType{
	NOT_USED    = 0,
	PLAYER_USED = 1,
	AI_USED     = 2
} locationState;

typedef enum directionType{
	NW	= 0,
	N 	= 1,
	NE	= 2,
	W	= 3,
	E	= 4,
	SW	= 5,
	S 	= 6,
	SE	= 7
} direction;

#endif /* direction_h */
