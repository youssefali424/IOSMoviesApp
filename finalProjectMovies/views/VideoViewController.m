//
//  VideoViewController.m
//  finalProjectMovies
//
//  Created by youssef ali on 4/13/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "VideoViewController.h"
#import <YTPlayerView.h>
#import "../Presnters/ContactPresnter/ContactPresenter.h"
#import "../Presnters/ContactPresnter/VideoPresenter.h"

@interface VideoViewController ()
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter=[VideoPresenter new];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [_presenter getContact:self];
}
-(void) renderVideoContactWithObject :(NSString*)key{
    [self.playerView loadWithVideoId:key];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
