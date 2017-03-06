//
//  WWZKeychain.m
//  WWZKeychain
//
//  Created by Sam Soffes on 5/19/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "WWZKeychain.h"

#import "WWZKeychainQuery.h"
#import <UIKit/UIKit.h>
NSString *const kWWZKeychainErrorDomain = @"com.samsoffes.WWZKeychain";
NSString *const kWWZKeychainAccountKey = @"acct";
NSString *const kWWZKeychainCreatedAtKey = @"cdat";
NSString *const kWWZKeychainClassKey = @"labl";
NSString *const kWWZKeychainDescriptionKey = @"desc";
NSString *const kWWZKeychainLabelKey = @"labl";
NSString *const kWWZKeychainLastModifiedKey = @"mdat";
NSString *const kWWZKeychainWhereKey = @"svce";

#if __IPHONE_4_0 && TARGET_OS_IPHONE
	static CFTypeRef WWZKeychainAccessibilityType = NULL;
#endif

@implementation WWZKeychain

+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account {
	return [self passwordForService:serviceName account:account error:nil];
}


+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
	WWZKeychainQuery *query = [[WWZKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	[query fetch:error];
	return query.password;
}

+ (NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account {
	return [self passwordDataForService:serviceName account:account error:nil];
}

+ (NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error {
    WWZKeychainQuery *query = [[WWZKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    [query fetch:error];

    return query.passwordData;
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account {
	return [self deletePasswordForService:serviceName account:account error:nil];
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
	WWZKeychainQuery *query = [[WWZKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	return [query deleteItem:error];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account {
	return [self setPassword:password forService:serviceName account:account error:nil];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
	WWZKeychainQuery *query = [[WWZKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	query.password = password;
	return [query save:error];
}

+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account {
	return [self setPasswordData:password forService:serviceName account:account error:nil];
}


+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error {
    WWZKeychainQuery *query = [[WWZKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.passwordData = password;
    return [query save:error];
}

+ (NSArray *)allAccounts {
	return [self allAccounts:nil];
}


+ (NSArray *)allAccounts:(NSError *__autoreleasing *)error {
    return [self accountsForService:nil error:error];
}


+ (NSArray *)accountsForService:(NSString *)serviceName {
	return [self accountsForService:serviceName error:nil];
}


+ (NSArray *)accountsForService:(NSString *)serviceName error:(NSError *__autoreleasing *)error {
    WWZKeychainQuery *query = [[WWZKeychainQuery alloc] init];
    query.service = serviceName;
    return [query fetchAll:error];
}


#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType {
	return WWZKeychainAccessibilityType;
}


+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
	CFRetain(accessibilityType);
	if (WWZKeychainAccessibilityType) {
		CFRelease(WWZKeychainAccessibilityType);
	}
	WWZKeychainAccessibilityType = accessibilityType;
}
#endif

+ (NSString *)wwz_deviceChainUUID{
    
    NSString *service = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *account = @"chain_uuid";
    
    NSString *UUID = [WWZKeychain passwordForService:service account:account];
    
    if (!UUID || UUID.length == 0){
        
        UUID = [[UIDevice currentDevice].identifierForVendor.UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""].lowercaseString;
        
        [WWZKeychain setPassword:UUID forService:service account:account];
    }
    return UUID;
}

@end
