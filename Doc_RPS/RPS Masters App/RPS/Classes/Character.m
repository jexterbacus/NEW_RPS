//
//  Character.m
//  RPS
//
//  Created by chibitotoro on 12-04-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"

@implementation Character

@synthesize sprCharacter,ssCharacter,name,winLine;
@synthesize sprAvatar,sprVSAvatar,sprUserAvatar;
@synthesize winEffect,sprWin;


-(void) idle{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actIdle];
}
-(void) jyankenpon{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actJyankenpon];
}
-(void) roundWin{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actRoundWin];
}
-(void) roundLose{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actRoundLose];
}
-(void) fall{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actFall];
}
-(void) matchLose{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actMatchLose];
}
-(void) rock{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actRock];
}
-(void) paper{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actPaper];
}
-(void) scissors{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actScissors];
}
-(void) flipX{
    sprCharacter.scaleX*=-1;
}

-(id) init{
    if((self=[super init])){
        anfIdle = [[NSMutableArray alloc]init];  
        anfJyankenpon=[[NSMutableArray alloc] init];  
        anfMatchLose=[[NSMutableArray alloc]init];  
        anfFall=[[NSMutableArray alloc]init];  
        anfRoundLose=[[NSMutableArray alloc]init];  
        anfRoundWin=[[NSMutableArray alloc]init];
        anfRock=[[NSMutableArray alloc]init];
        anfPaper=[[NSMutableArray alloc]init];
        anfScissors=[[NSMutableArray alloc]init];
        sprAvatar=sprUserAvatar=sprVSAvatar=nil;
    }
    return self;
}
-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip{
    [layer removeChild:ssCharacter cleanup:YES];
    sprCharacter.position=ccp(x,y);
    if(flip){
        sprCharacter.scaleX*=-1;
    }
    [layer addChild:ssCharacter];
}

-(void) dealloc{
    
    
    
    [aniIdle release];
    [aniJyankenpon release];
    [aniRoundWin release];
    [aniRoundLose release];
    [aniFall release];
    [aniMatchLose release];
    [aniRock release];
    [aniPaper release];
    [aniScissors release];
    
    [actIdle release];
    [actJyankenpon release];
    [actRoundWin release];
    [actRoundLose release];
    [actFall release];
    [actMatchLose release];
    [actRock release];
    [actPaper release];
    [actScissors release];
    
    [sprCharacter release];
    
    [sprAvatar release];
    [sprVSAvatar release];
    [sprWin release];
    
    [ssCharacter release];
    [super dealloc];
}
@end
