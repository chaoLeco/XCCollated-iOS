//
//  XCDefine.h
//  XCCollated-iOS
//
//  Created by Chaos on 16/4/13.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#ifndef XCDefine_h
#define XCDefine_h


#endif /* XCDefine_h */


#define RGB(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]

#define WGNull @""

#pragma mark - 系统数据 -
//applicationFrame
#define ApplicationFrame [[UIScreen mainScreen] applicationFrame]
//bounds
#define Bounds [[UIScreen mainScreen] bounds]
//keyWindow
#define KeyWindow [[UIApplication sharedApplication] keyWindow]

#define DelegateWindow [[[UIApplication sharedApplication] delegate] window]

#pragma mark -

//weakSelf
#define WEAKOBJECT(obj,objName) typeof(obj) __weak objName = obj;

#define WEAKSELF WEAKOBJECT(self,weakSelf);

/**
 *	永久存储对象
 *
 *	@param	object    需存储的对象
 *	@param	key    对应的key
 */
#define PERSISTENT_SET_OBJECT(object, key)                                                                                                 \
({                                                                                                                                             \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];                                                                         \
[defaults setObject:object forKey:key];                                                                                                    \
[defaults synchronize];                                                                                                                    \
})

/**
 *	取出永久存储的对象
 *
 *	@param	key    所需对象对应的key
 *	@return	key所对应的对象
 */
#define PERSISTENT_GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]