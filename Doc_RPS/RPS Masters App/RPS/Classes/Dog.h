//
//  Dog.h
//  RPS
//
//  Created by chibitotoro on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"
@interface Dog : Character{
    
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
