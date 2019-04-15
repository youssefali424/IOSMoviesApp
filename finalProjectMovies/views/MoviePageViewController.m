//
//  MoviePageViewController.m
//  finalProjectMovies
//
//  Created by youssef ali on 4/7/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "MoviePageViewController.h"
#import "../Presnters/ContactPresnter/ContactPresenter.h"
#import <SDWebImage.h>
#import <EDStarRating.h>
#import "../POJO/MovieTrailer.h"
#import "../POJO/MovieReview.h"
#import "VideoViewController.h"

@interface MoviePageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *overview;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property EDStarRating *starRating;
@property Movie* mov;
@property (weak, nonatomic) IBOutlet UIButton *favBtn;
@property BOOL fav;
@property NSArray *trailers;
@property NSArray *reviews;
@property Boolean isFavourite;
@end
@implementation MoviePageViewController
static NSString * const baseUrl=@"https://image.tmdb.org/t/p/w185/";

- (void)viewDidLoad {
    [super viewDidLoad];
    _trailers=[NSArray new];
    _reviews=[NSArray new];
    _isFavourite=false;
    _contactPresenter = [[ContactPresenter alloc] initWithContactView:self];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self addStars];
    // Do any additional setup after loading the view.
}
-(void) addStars{
    _starRating=[[EDStarRating alloc] initWithFrame:CGRectMake(_duration.center.x-40, _duration.center.y+20, 170, 50)];
    [_scrollView addSubview:_starRating];
    _starRating.backgroundColor  = [UIColor whiteColor];
    _starRating.starImage = [UIImage imageNamed:@"star"];
    _starRating.starHighlightedImage = [UIImage imageNamed:@"starhighlighted"];
    _starRating.maxRating = 10.0;
    //_starRating.delegate = self;
    _starRating.horizontalMargin = 0;
    _starRating.editable=NO;
    
    _starRating.displayMode=EDStarRatingDisplayFull;
    _starRating.rating=_mov.voteAverage;
    
    NSLayoutConstraint *leftButtonXConstraint = [NSLayoutConstraint
                                                 constraintWithItem:_starRating attribute:NSLayoutAttributeLeft
                                                 relatedBy:NSLayoutRelationEqual toItem:_movieImage attribute:
                                                 NSLayoutAttributeRight multiplier:1.0 constant:5];
    /* Top space to superview Y*/
    NSLayoutConstraint *leftButtonYConstraint = [NSLayoutConstraint
                                                 constraintWithItem:_starRating attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual toItem:_duration attribute:
                                                 NSLayoutAttributeBottom multiplier:1.0f constant:5];
    NSLayoutConstraint *rightButtonYConstraint = [NSLayoutConstraint
                                                 constraintWithItem:_starRating attribute:NSLayoutAttributeRight
                                                 relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:
                                                 NSLayoutAttributeRight multiplier:1.0f constant:0];
    [_scrollView addConstraints:@[leftButtonXConstraint, leftButtonYConstraint,rightButtonYConstraint]];
    
}
-(void)viewDidLayoutSubviews{
    if(_starRating==nil){
    
        //_ratingControl.contentScaleFactor=0.7;
        
        
    }
    
    //[_ratingControl setRating:_mov.voteAverage];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [_contactPresenter getCurrentMovie];
    
}
-(void) addCurrentMovie : (Movie*) movie{
    _mov=movie;
    [_contactPresenter getDetail:movie.movId];
    if(_starRating!=nil){
    _starRating.rating=_mov.voteAverage;
    }
    _movieTitle.text=movie.title;
    if(movie.posterPath==nil){
        _movieImage.image = [UIImage imageNamed:@"no-image"];
    }
    else{
        NSString *url=[baseUrl stringByAppendingString :movie.posterPath];
        [self configureView:_movieImage:url];
    }
    NSInteger time=movie.runtime;
    
    _duration.text =[NSString stringWithFormat:@"%ld min",(long)time] ;
    _overview.text = movie.overview;
    _year.text = movie.releaseDate;
    [_contactPresenter checkFav:movie.movId];
    //_rating.text = [NSString stringWithFormat:@"%.1f/10",movie.voteAverage] ;
}
- (IBAction)favouriteMovie:(id)sender {
    if(_isFavourite){
        _isFavourite=false;
        [_favBtn setImage:[UIImage imageNamed:@"favIcon"] forState:UIControlStateNormal];
        if(_mov!=nil)
            [_contactPresenter removeFavourite:_mov.movId];
    }
    else{
        _isFavourite=true;
    [_favBtn setImage:[UIImage imageNamed:@"favIconOn"] forState:UIControlStateNormal];
    if(_mov!=nil)
        [_contactPresenter addFavourite:_mov];
    
}
}
-(void)setFavBtn{
    [_favBtn setImage:[UIImage imageNamed:@"favIconOn"] forState:UIControlStateNormal];
    _isFavourite=true;
}
- (void)configureView:(UIImageView*)imgView :(NSString*)imageUrl
{
    //[imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
    //          placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    /*[imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
     placeholderImage:[UIImage imageNamed:@"placeholder.png"]];*/
    
    
    __block UIActivityIndicatorView *activityIndicator;
    __weak UIImageView *weakImageView = imgView;
    [imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
               placeholderImage:nil
                        options:SDWebImageProgressiveLoad
                       progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
                           if (!activityIndicator) {
                               [weakImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
                               activityIndicator.center = imgView.center;
                               [activityIndicator startAnimating];
                           }
                       }
                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                          [activityIndicator removeFromSuperview];
                          
                      }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0)
        return _trailers.count;
    else if(section==1)
        return _reviews.count;
    else return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if(indexPath.section==0){
        cell = [tableView  dequeueReusableCellWithIdentifier:@"trailerCell" forIndexPath:indexPath];
        UILabel *header=(UILabel*)[cell viewWithTag:3];
        MovieTrailerResult *trailer=_trailers[indexPath.row];
        header.text=trailer.name;
    }
    else if(indexPath.section==1){
    cell = [tableView dequeueReusableCellWithIdentifier:@"reviewCell" forIndexPath:indexPath];
        UILabel *name=(UILabel*)[cell viewWithTag:1];
        MovieReviewResult *review=_reviews[indexPath.row];
        name.text=review.author;
        UILabel *text=(UILabel*)[cell viewWithTag:2];
        text.text=review.content;
    }
    // Configure the cell
    
    //UILabel *lab=(UILabel*)[cell viewWithTag:2];
    // Configure the cell
    
    //lab.text=movie.description;
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0)
        return @"Trailers";
    else if(section==1)
        return @"Reviews";
    else return @"";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        
        MovieTrailerResult *trailer=_trailers[indexPath.row];
        [_contactPresenter saveKey:trailer.key];
        VideoViewController* videoPage=[self.storyboard instantiateViewControllerWithIdentifier:@"videoPage"];
        [self.navigationController pushViewController:videoPage animated:YES];
    }
    
    }
-(void) onSuccessTrailers :(NSArray*) trailer{
    _trailers=trailer;
     [_tableView reloadData];
}
-(void) onSuccessReviews :(NSArray*) reviews{
    _reviews=reviews;
    [_tableView reloadData];
}
@end
