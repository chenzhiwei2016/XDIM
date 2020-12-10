//
//  XDVideoViewController.m
//  XDIM
//
//  Created by 小豆 on 2020/11/20.
//

#import "XDVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

#define CurrentSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

@interface XDVideoViewController ()
@property (nonatomic,strong) AVPlayerViewController *playerVC;
@property (nonatomic,strong) AVAudioSession *avaudioSession;
@property (nonatomic, strong) UIView * blackView;
@end

@implementation XDVideoViewController
#pragma mark - allow background music still play
- (void)stillPlayMusic {
    
    self.avaudioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [self.avaudioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    
}

#pragma mark - Player
- (void)getPlayerNotifications {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerStateChangeNotification) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}

- (void)preparePlayback {
    if (self.playerVC == nil) {
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.videoName ofType:@"mp4"]];
        self.playerVC = [[AVPlayerViewController alloc] init];
        self.playerVC.player = [AVPlayer playerWithURL:url];
        self.playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.playerVC.showsPlaybackControls = NO;
        self.playerVC.player.volume = 0;
        if (@available(iOS 11.0, *)) {
            self.playerVC.entersFullScreenWhenPlaybackBegins = YES;
        } else {
            // Fallback on earlier versions
        }
        [self.playerVC.view setFrame:self.view.frame];
        [self.view addSubview:self.playerVC.view];
        [self.view sendSubviewToBack:self.playerVC.view];
        
        self.blackView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.blackView.backgroundColor = [UIColor blackColor];
        self.blackView.alpha = 0.6;
        [self.view addSubview:self.blackView];
    }
    
}

- (void)moviePlayerStateChangeNotification {
        CGFloat a=0;
        NSInteger dragedSeconds = floorf(a);
        CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
        [self.playerVC.player seekToTime:dragedCMTime];
        [self.playerVC.player play];
}


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self stillPlayMusic];
    
    if (self.videoName != nil) {
        
        [self preparePlayback];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self getPlayerNotifications];
    [self.playerVC.player play];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [self.playerVC.player pause];
}

@end
