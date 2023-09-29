//
//  HYVideoPlayView.m
//  HYMedia
//
//  Created by oceanMAC on 2023/9/26.
//

#import "HYVideoPlayView.h"

#import "SJVideoPlayer.h"
#import "SJAVMediaPlaybackController.h"
#import "SJBaseVideoPlayerConst.h"
#import "SJMediaCacheServer.h"
#import "NSURLRequest+MCS.h"
#import "MCSURL.h"
#import "MCSPrefetcherManager.h"
#import "MCSDownload.h"
#import <Masonry/Masonry.h>

@interface HYVideoPlayView()

@property (nonatomic, strong, nullable) SJVideoPlayer *player;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval startPosition;

@end

@implementation HYVideoPlayView

- (void)dealloc {
    NSLog(@"HYVideoPlayView dealloc");
}

- (void)setBGColor:(UIColor *)bGColor {
    self.backgroundColor = bGColor;
}

- (instancetype)initWithFrame:(CGRect)frame playUrl:(NSString *)playUrl startPosition:(NSTimeInterval)startPosition
{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = UIColor.blackColor;
        self.playUrl = playUrl;
        self.startPosition = startPosition;

        _player = SJVideoPlayer.player;
        _player.pausedInBackground = YES;
        
        [self addSubview:_player.view];

        self.timer = [NSTimer timerWithTimeInterval:(1.0f) target:self selector:@selector(timeRecordCurrent) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
        
        
        [self startPaly:[NSURL URLWithString:@"https://ukzyvod3.ukubf5.com/20230415/9HciOKan/index.m3u8"]];
        
        
    }
    return self;
}

- (void)timeRecordCurrent {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.player.view.frame = self.bounds;
}

#pragma mark -
- (void)startPaly:(NSURL *)URL {
    

    NSURL *playbackURL = [SJMediaCacheServer.shared playbackURLWithURL:URL];
    self.player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:playbackURL startPosition:self.startPosition];

}

- (void)removeView
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)pauseTimer
{
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)continueTimer
{
    [self.timer setFireDate:[NSDate date]];
}

- (void)pause
{
    [self.player pause];
}

- (void)startPlay
{
    [self.player play];
}

- (NSTimeInterval)currentPosition {
    return self.player.currentTime;
}

@end
