//
//  KeyChainWrapper.h
//  KeyChainDemo
//
//  Created by wanghaijun on 14-3-10.
//  Copyright (c) 2014年 ___NAVY___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainWrapper : NSObject

- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier;

- (NSData *)searchKeychainCopyMatching:(NSString *)identifier;

@end
