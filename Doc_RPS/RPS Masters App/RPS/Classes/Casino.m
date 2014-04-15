//
//  Casino.m
//  RPS
//
//  Created by chibitotoro on 12-05-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Casino.h"

@implementation Casino
@synthesize roof,machine,glow,sign,slotLeft,slotRight,lever;
@synthesize bunnyGirl,catGirl,grandma,businessMan,tycoon;
-(id)init{
    if((self=[super init])){
        sprBackground=[[CCSprite spriteWithFile: @"casino-bottom.png"]retain];
        sprBackground.position=ccp(240,80);
        bgMusic=@"Casino.mp3";
        roof=[[CasinoRoof alloc]init];
        roof.sprCharacter.position=ccp(240,240);
        
        machine=[[CCSprite spriteWithFile:@"machine.png"] retain];
        machine.position=ccp(166,127);
        
        glow=[[Glow alloc]init];
        glow.sprCharacter.position=ccp(240,160);
        
        sign=[[Sign alloc]init];
        sign.sprCharacter.position=ccp(188,217);
        
        slotLeft=[[SlotLeft alloc]init];
        slotLeft.sprCharacter.position=ccp(144,143);
        
        slotRight=[[SlotRight alloc]init];
        slotRight.sprCharacter.position=ccp(231,143);
        
        bunnyGirl=[[BunnyGirl alloc]init];
        bunnyGirl.sprCharacter.position=ccp(314,170);
        
        catGirl=[[CatGirl alloc]init];
        catGirl.sprCharacter.position=ccp(392,166);
        
        lever=[[Lever alloc]init];
        lever.sprCharacter.position=ccp(286,129); 
        
        grandma=[[Grandma alloc]init];
        grandma.sprCharacter.position=ccp(136,120); 
        
        businessMan=[[BusinessMan alloc]init];
        businessMan.sprCharacter.position=ccp(361,169); 
        
        tycoon=[[Tycoon alloc]init];
        tycoon.sprCharacter.position=ccp(461,169);
    }
    
    return self;
}

-(void) pause{
    [super pause];
    //[[ActionManager sharedManager] pauseAllActionsForTarget:fan];
    
}
-(void) resume{
    [super resume];
    
}

-(void) dealloc{
    [roof release];
    [machine release];
    [glow release];
    [lever release];
    [bunnyGirl release];
    [slotLeft release];
    [slotRight release];
    [sign release];
    [catGirl release];
    [grandma release];
    [businessMan release];
    [tycoon release];
    [super dealloc];
}
@end
