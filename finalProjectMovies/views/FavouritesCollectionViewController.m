//
//  FavouritesCollectionViewController.m
//  finalProjectMovies
//
//  Created by youssef ali on 4/7/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "FavouritesCollectionViewController.h"
#import "../Presnters/ContactPresnter/FavContactPresenter.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "MoviePageViewController.h"

@interface FavouritesCollectionViewController ()
@property FavContactPresenter *contactPresenter ;
@property UIButton *button;
@end

@implementation FavouritesCollectionViewController

static NSString * const reuseIdentifier = @"FavCell";
static NSString * const baseUrl=@"https://image.tmdb.org/t/p/w185/";
- (void)viewDidLoad {
    [super viewDidLoad];
    _contactPresenter = [[FavContactPresenter alloc] initWithContactView:self];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    [_contactPresenter getContact];
    
    _FavMovies=nil;
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *img=[UIImage imageNamed:@"bin"];
    UIGraphicsBeginImageContext(CGSizeMake(25, 25));
    [img drawInRect:CGRectMake(0, 0, 25, 25)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //[button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 5.0, 5.0)];
    [_button setImage:destImage forState:UIControlStateNormal];
    [_button setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 5.0, 5.0)];
    [_button setTitle:@"clear" forState:UIControlStateNormal];
    [_button setBounds:CGRectMake(0, 0, 65, 25)];
    [_button addTarget:self action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}
- (void)buttonPressed:(UIButton *)button {
    NSLog(@"Button Pressed");
    [_contactPresenter removeFavourites];
    [self.collectionView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.titleView = _button;
    [_contactPresenter getContact];
}
-(void) renderFavContactWithObject : (RLMResults<Favourite *> *) FavMovies{
    _FavMovies=FavMovies;
    [self.collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(_FavMovies!=nil)
        return _FavMovies.count;
    else
        return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float padding=0;
    float size=collectionView.frame.size.width-padding;
    return CGSizeMake(size/2, size/2);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UIImageView *imgView=(UIImageView*)[cell viewWithTag:1];
    //UILabel *lab=(UILabel*)[cell viewWithTag:2];
    // Configure the cell
    
    Movie *movie=_FavMovies[indexPath.row].movie;
    //lab.text=movie.description;
    
    if(movie.posterPath==nil){
        imgView.image = [UIImage imageNamed:@"no-image"];
    }
    else{
        NSString *url=[baseUrl stringByAppendingString :movie.posterPath];
        [self configureView:imgView:url];
    }
    return cell;
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
#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Movie *movie=_FavMovies[indexPath.row].movie;
    [_contactPresenter saveMovie:movie];
    MoviePageViewController* moviePage=[self.storyboard instantiateViewControllerWithIdentifier:@"moviePage"];
    [self.navigationController pushViewController:moviePage animated:YES];
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
