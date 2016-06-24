//
//  RsModleBase.h
//  newruishiclub
//
//  Created by Chaos on 15/11/23.
//  Copyright © 2015年 iUXLabs. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface XCModleBase : MTLModel<MTLJSONSerializing>

@property (nonatomic, retain) id pins;

@end
