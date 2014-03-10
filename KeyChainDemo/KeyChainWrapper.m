//
//  KeyChainWrapper.m
//  KeyChainDemo
//
//  Created by wanghaijun on 14-3-10.
//  Copyright (c) 2014年 ___NAVY___. All rights reserved.
//

#import "KeyChainWrapper.h"
#import <Security/Security.h>

@implementation KeyChainWrapper

static NSString *serviceName = @"com.mycompany.myAppServiceName";

- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(__bridge id)kSecAttrService];
    
    return searchDictionary;
}

- (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    // Add search return types
    [searchDictionary setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    
    CFTypeRef resData = NULL;
    OSStatus status = SecItemCopyMatching((__bridge_retained CFDictionaryRef) searchDictionary, (CFTypeRef *) &resData);
    
    NSData *resultData = nil;
    
    if (status == noErr) {
        resultData = (__bridge_transfer NSData *)resData;
    }
    
//    NSString *password = nil;
//    if (resultData) {
//        password = [[NSString alloc] initWithData: resultData encoding: NSUTF8StringEncoding];
//    }
    
    return resultData;
}

@end
