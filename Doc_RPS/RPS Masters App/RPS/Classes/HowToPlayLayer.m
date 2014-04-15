//
//  HowToPlayLayer.m
//  RPS
//
//  Created by chibitotoro on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HowToPlayLayer.h"
#import "MainMenuLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
@implementation HowToPlayLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HowToPlayLayer *layer = [HowToPlayLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

#pragma mark DRAW FUNCTIONS
- (void) nextFrame:(ccTime)dt {



}


-(id) init
{
    if( (self=[super init])) {
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
        self.isTouchEnabled = YES;
        //CGSize size = [[CCDirector sharedDirector] winSize];
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        
        sprBackground=[CCSprite spriteWithFile:@"how-to-play-bg.png"];
        sprBackground.position=ccp(240,160);
        [self addChild:sprBackground];
        
        sprHeader=[CCSprite spriteWithFile:@"how-to-play-header.png"];
        sprHeader.position=ccp(182,300);
        [self addChild:sprHeader];
        

        currentPage=0;
        pages=[[NSMutableArray alloc]init];
        
        
        CCSprite * sprPage;
        
        for(int i=1;i<=8;i++){
            sprPage=[CCSprite spriteWithFile:[NSString stringWithFormat:@"how-to-play-pg%d.png",i]];
            sprPage.position=ccp(240,160);
            sprPage.visible=false;
            [pages addObject:sprPage];
        }
        for(int i=0;i<[pages count];i++){
            [self addChild:[pages objectAtIndex:i]];
        }

        
        
        lblTotalPages=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"/%d",[pages count]] fontName:@"ComixHeavy" fontSize:24];
        lblTotalPages.color=ccc3(0,0,0);
        lblTotalPages.position=ccp(450,300);
 
        
        [self addChild:lblTotalPages];
        
        lblCurrentPage=[CCLabelTTF labelWithString:@"1" fontName:@"ComixHeavy" fontSize:24];
        lblCurrentPage.color=ccc3(0,0,0);
        lblCurrentPage.position=ccp(424,300);
        
        [self addChild:lblCurrentPage];
        
        // Return Button
        itmReturn = [CCMenuItemImage itemWithNormalImage:@"return-home.png" 
                                           selectedImage:@"return-home.png" 
                                                   block:^(id sender) {
                                                       if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];
                                                       [[CCDirector sharedDirector] replaceScene:
                                                        [CCTransitionFade transitionWithDuration:0.5f scene:[MainMenuLayer scene]]];
                                                   }];    
        
        itmReturn.position=ccp(93,58);
        
        // Prev Button
        itmPrev = [CCMenuItemImage itemWithNormalImage:@"arrow-prev.png" 
                                         selectedImage:@"arrow-prev.png" 
                                                 block:^(id sender) {
                                                      if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];
                                                     if(currentPage>0){
                                                         [self showPage:currentPage-1];
                                                     }
                                                 }];  
        itmPrev.position=ccp(390,58);
        
        // Next Button
        itmNext = [CCMenuItemImage itemWithNormalImage:@"arrow-next.png" 
                                         selectedImage:@"arrow-next.png" 
                                                 block:^(id sender) {
                                                      if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];
                                                     if(currentPage<[pages count]-1){
                                                         [self showPage:currentPage+1];
                                                     }
                                                    
                                                 }]; 
        
        itmNext.position=ccp(450,58);
        
        
        
        menu = [CCMenu menuWithItems:itmReturn, itmPrev,itmNext,nil];
        [menu setPosition:ccp( 0,0)];
        
        // Add the menu to the layer
        [self addChild:menu];
        
        [self showPage:0];

        
    }
    
    return self;
}

-(void) showPage:(int) number{
    if(number==0){
        itmPrev.visible=false;
    }
    else{
        itmPrev.visible=true;
    }
    
    CCSprite * page=(CCSprite*)[pages objectAtIndex:currentPage];
    page.visible=false;
    
    page=(CCSprite*)[pages objectAtIndex:number];
    page.visible=true;
    
    [lblCurrentPage setString:[NSString stringWithFormat:@"%d",(number+1)]];
    
    if(number==[pages count]-1){
        itmNext.visible=false;
    }
    else{
        itmNext.visible=true;
    }
    
    currentPage=number;
//    CCLayer * currentLayer=(CCLayer*) page[objectcurrentPage
}

-(void) dealloc{
    [pages release];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end
