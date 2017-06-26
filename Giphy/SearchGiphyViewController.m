//
//  SearchGiphyViewController.m
//  Giphy
//
//  Created by Oleg Halasa on 24.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import "SearchGiphyViewController.h"
#import "APIClientManager.h"
#import "GiphyCollectionViewCell.h"
#import "UIImage+animatedGIF.h"
#import "Giphy.h"
#import "DetailViewController.h"


@interface SearchGiphyViewController ()
@property(strong,nonatomic)NSMutableArray *giphyArray;
@property(strong,nonatomic)NSString *searchText;
@property (strong, nonatomic)UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorFooter;
@property (strong,nonatomic)GiphyCollectionViewLayout *layout;

@end
static NSInteger countLimit = 25;
@implementation SearchGiphyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _giphyArray=[[NSMutableArray alloc]init];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _searchTextField.delegate = self;
    
    _refreshControl = [[UIRefreshControl alloc]init];
    _refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Load"];
    [_refreshControl addTarget:self action:@selector(refreshCollection) forControlEvents:UIControlEventValueChanged];
    [_collectionView addSubview:_refreshControl];
    [self getSearch:_searchText];
    _layout = [[GiphyCollectionViewLayout alloc]initWithCoder:nil];
    _layout.totalColumns = 2;
    _collectionView.collectionViewLayout = _layout;
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDeviceOrientation:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)refreshCollection{
    [[APIClientManager sharedManager]getSearch:_searchText withOffset:_giphyArray.count count:countLimit onSuccess:^(NSArray *responseArray) {
        for (NSDictionary *dictionary in responseArray) {
            Giphy *giphyObject = [[Giphy alloc]initWithDictionary:dictionary];
            [_giphyArray addObject:giphyObject];
        }
        [_refreshControl endRefreshing];
        NSMutableArray *indexPatchArray = [[NSMutableArray alloc]init];
        for (NSInteger i = _giphyArray.count - responseArray.count ; i < _giphyArray.count; i++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [indexPatchArray addObject:indexPath];
        }
        [_collectionView insertItemsAtIndexPaths:indexPatchArray];
        [_collectionView layoutSubviews];
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    // [_refreshControl ]
}
-(void)getSearch:(NSString *)searchText{
    [[APIClientManager sharedManager]getSearch:searchText withOffset:_giphyArray.count count:15 onSuccess:^(NSArray *responseArray) {
        for (NSDictionary *dictionary in responseArray) {
            Giphy *giphyObject = [[Giphy alloc]initWithDictionary:dictionary];
            [_giphyArray addObject:giphyObject];
        }
        [_collectionView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _giphyArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GiphyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"giphyCell" forIndexPath:indexPath];
    Giphy *giphy = _giphyArray[indexPath.row];
    NSURL *url = giphy.smallImage;
    cell.giphyImageView.image = nil;
    
    __weak GiphyCollectionViewCell *weakCell = cell;
    
    
    weakCell.giphyImageView.image = nil;
    [[APIClientManager sharedManager]loadAnimatedImageWithURL:url completion:^(UIImage *animatedImage) {
        weakCell.giphyImageView.image = animatedImage;
    }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegat
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        _indicatorFooter = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_collectionView.frame), 44)];
        [_indicatorFooter setColor:[UIColor blackColor]];
        [_indicatorFooter startAnimating];
        [footerView addSubview:_indicatorFooter];
        return footerView;
    }else{
        return nil;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == _giphyArray.count - 1){
        [self refreshCollection];
        
    }
}
#pragma mark - UITextFieldDelegat
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    [[NSURLSession sharedSession]getAllTasksWithCompletionHandler:^(NSArray<__kindof NSURLSessionTask *> * _Nonnull tasks) {
        for (NSURLSessionTask *task in tasks){
            [task cancel];
        }
    }];
    NSString *text = textField.text;
    _searchText = [text stringByReplacingCharactersInRange:range withString:string];
    if([_searchText isEqualToString:@""]){
        _searchText = nil;
    }
    _giphyArray = [[NSMutableArray alloc]init];

    [self getSearch:_searchText];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - NSNotificationCenter
-(void)keyboardWillHide:(NSNotification *)notification{
        [self getSearch:_searchText];
    
}
-(void)changeDeviceOrientation:(NSNotification *)notification{
    if (notification){
        UIDevice *dev = (UIDevice *)notification.object;
        if ([dev orientation] == UIInterfaceOrientationLandscapeRight)
        {
            _layout.totalColumns = 4;
            [_collectionView reloadData];
        }
        else if ([dev orientation] == UIInterfaceOrientationPortrait)
        {
            _layout.totalColumns = 2;

          [_collectionView reloadData];
        }
        else if ([dev orientation] == UIInterfaceOrientationPortraitUpsideDown)
        {  _layout.totalColumns = 4;
       
           [_collectionView reloadData];
        }
        else if ([dev orientation] == UIInterfaceOrientationLandscapeLeft)
        {
          _layout.totalColumns = 4;
           [_collectionView reloadData];
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if ([segue.identifier isEqualToString:@"showDetail"]) {
            DetailViewController *detailVC = segue.destinationViewController;
            NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
            detailVC.giphy = _giphyArray[indexPath.row];
            
            
        }
}

@end
