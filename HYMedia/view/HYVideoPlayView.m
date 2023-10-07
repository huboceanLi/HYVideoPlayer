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

- (void)startPlayUrl:(NSString *)playUrl startPosition:(NSTimeInterval)startPosition
{
    self.playUrl = playUrl;
    self.startPosition = startPosition;
    
    if (playUrl.length > 0) {
        [self startPaly:[NSURL URLWithString:playUrl]];
    }else {
        [self startPaly:[NSURL URLWithString:@"https://ukzyvod3.ukubf5.com/20230415/9HciOKan/index.m3u8"]];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = UIColor.blackColor;


        _player = SJVideoPlayer.player;
        _player.pausedInBackground = YES;
        
        [self addSubview:_player.view];

        self.timer = [NSTimer timerWithTimeInterval:(1.0f) target:self selector:@selector(timeRecordCurrent) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
        
        [self pauseTimer];
        
    }
    return self;
}

- (void)timeRecordCurrent {
    
    NSInteger currentTime = self.player.currentTime;
    NSLog(@"***timeRecordCurrent***");
    if ([self.delegate respondsToSelector:@selector(currentTime:)]) {
        [self.delegate currentTime:currentTime];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.player.view.frame = self.bounds;
}

#pragma mark -
- (void)startPaly:(NSURL *)URL {
    
    [self continueTimer];
    NSURL *playbackURL = [SJMediaCacheServer.shared playbackURLWithURL:URL];
    self.player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:playbackURL startPosition:self.startPosition];

}

- (void)removeView
{
    [self pause];
    [self.timer invalidate];
    self.player = nil;
    self.timer = nil;
    [self removeFromSuperview];
    NSLog(@"***removeView***");

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
    [self pauseTimer];
}

- (void)startPlay
{
    [self.player play];
    [self continueTimer];
}

- (NSTimeInterval)currentPosition {
    return self.player.currentTime;
}

- (NSTimeInterval)getDuration {
    return self.player.duration;
}
@end
