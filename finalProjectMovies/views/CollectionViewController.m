//
//  CollectionViewController.m
//  finalProjectMovies
//
//  Created by youssef ali on 3/26/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "CollectionViewController.h"
#import "../Presnters/ContactPresnter/ContactPresenter.h"
#import "../POJO/Movie.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PFNavigationDropdownMenu.h"
#import "MoviePageViewController.h"
#import "../POJO/RLMObject+RlmDic.h"

@interface CollectionViewController ()
@property int pageNum;
@property ContactPresenter *contactPresenter ;
@property PFNavigationDropdownMenu *menuView;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const baseUrl=@"https://image.tmdb.org/t/p/w185/";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _pageNum=1;
    _movies=[NSArray new];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    _contactPresenter = [[ContactPresenter alloc] initWithContactView:self];
    
    //[_contactPresenter removeFavourites];
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    NSArray *items = @[@"Most Popular", @"Latest", @"votes"];
    _menuView = [[PFNavigationDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, 300, 44)title:items.firstObject items:items containerView:self.collectionView];
    
    
    _menuView.cellTextLabelFont = [UIFont fontWithName:@"Avenir-Heavy" size:17];
    _menuView.arrowPadding = 15;
    _menuView.animationDuration = 0.5f;
   
    
    __weak typeof(self) weakSelf = self;
    _menuView.didSelectItemAtIndexHandler = ^(NSUInteger indexPath){
        
        NSLog(@"Did select item at index: %ld", indexPath);
        self->_pageNum=1;
        typeof(self) sSelf=weakSelf;
        
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            //Background Thread
            [sSelf->_contactPresenter setSearchTypeWithIndex:indexPath];
            [sSelf->_contactPresenter getContact:sSelf->_pageNum];
        });
    };
    
    
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        
        [self->_contactPresenter getContact:self->_pageNum];
    });
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.titleView = _menuView;
}
-(void)renderContactWithObject:(NSArray *)mov{
    
    _movies=[_movies arrayByAddingObjectsFromArray: mov];
    _pageNum++;
    
    
    [self.collectionView reloadData];
}
-(void)resetViewArray{
    _movies=[NSArray new];
[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}
-(void)showLoading{
    
    printf("Show Loading\n");
    
}

-(void) hideLoading{
    
    printf("hide Loading\n");
}

-(void)showErrorMessage:(NSString *)errorMessage{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
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
#warning Incomplete implementation, return the number of sections
    return 1;
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [_movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *imgView=(UIImageView*)[cell viewWithTag:1];
    //UILabel *lab=(UILabel*)[cell viewWithTag:2];
    // Configure the cell
    
    Movie *movie=[_movies objectAtIndex:indexPath.row];
    //lab.text=movie.description;
    NSLog(@"%@ : page %d", movie.posterPath,_pageNum);
    if(movie.posterPath==nil){
      imgView.image = [UIImage imageNamed:@"no-image"];
    }
    else{
        NSString *url=[baseUrl stringByAppendingString :movie.posterPath];
        [self configureView:imgView:url];
    }
    //UIButton* switchView= (UIButton*) [cell viewWithTag:2];
//    CGPoint point=imgView.center;
//    point.y+=(imgView.bounds.size.height/2)-50;
//    point.x+=(imgView.bounds.size.width/2)-50;
//    [switchView setFrame:CGRectMake(point.x,point.y,50,50)];
    //switchView.imageView.image=[UIImage imageNamed:@"favIcon"];
    //switchView.segmentedControlStyle=UISegmentedControlStyleBar;
    //[switchView setImage:[UIImage imageNamed:@"favIcon.png"] forState:UIControlStateNormal ];
    //[switchView setImage:[UIImage imageNamed:@"off.png"] forSegmentAtIndex:1];
    
    //[switchView addTarget:self action:@selector(checkOnOffState:event:) forControlEvents:UIControlEventTouchUpInside];
    //UIImage *img=[UIImage imageNamed:@"favIcon"] ;
    //[switchView setImage:img forState:UIControlStateNormal ];
    //[imgView addSubview:switchView];
    if(indexPath.row==([_movies count]/2)-1){
        
        if(self->_pageNum<=1000){
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            //Background Thread
            
            [self->_contactPresenter getContact:self->_pageNum];
        });
            
        }
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Movie* movie=_movies[indexPath.row];
    [_contactPresenter saveMovie:movie];
    MoviePageViewController* moviePage=[self.storyboard instantiateViewControllerWithIdentifier:@"moviePage"];
    [self.navigationController pushViewController:moviePage animated:YES];
}
@end

