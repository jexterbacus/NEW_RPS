//
//  Snowman.h
//  RPS
//
//  Created by chibitotoro on 12-04-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"

@interface Snowman : Character{
}
-(void) idle;
-(void) jyankenpon;
-(void) roundWin;
-(void) roundLose;
-(void) fall;
-(void) matchLose;
-(void) rock;
-(void) paper;
-(void) scissors;
-(void) flipX;
-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip;

@end
