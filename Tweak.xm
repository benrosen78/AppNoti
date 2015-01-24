@interface FBBundleInfo : NSObject

@property(copy, nonatomic) NSString *displayName; 

@end

@interface FBApplicationPlaceholder : FBBundleInfo

@property(readonly, nonatomic) double percentComplete;

@end

@interface SBBulletinBannerController : NSObject

+ (instancetype)sharedInstance;
- (void)observer:(id)observer addBulletin:(id)bulletin forFeed:(NSUInteger)feed;

@end

@interface BBBulletin : NSObject

@property(copy) NSString * title;
@property(copy) NSString * message;
@property(copy) NSString * bulletinID;
@property(copy) NSString * sectionID;

@end

%hook FBApplicationPlaceholder

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
	%orig;

	if (self.percentComplete == 0.96) {
        BBBulletin *bulletin = [[[BBBulletin alloc] init] autorelease];
        bulletin.bulletinID = @"org.benrosen.appnoti";
        bulletin.sectionID = @"com.apple.AppStore";
        bulletin.title = @"AppNoti";
        bulletin.message = [self.displayName stringByAppendingString:@" has finished downloading."];
        [(SBBulletinBannerController *)[%c(SBBulletinBannerController) sharedInstance] observer:nil addBulletin:bulletin forFeed:2];
	}
}

%end
