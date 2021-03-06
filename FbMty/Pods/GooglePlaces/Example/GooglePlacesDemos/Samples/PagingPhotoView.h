#import <UIKit/UIKit.h>

/**
 * Represents a place photo, along with the attributions which are required to be displayed along
 * with it.
 */
@interface AttributedPhoto : NSObject

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, strong) NSAttributedString *attributions;

@end

/*
 * A horizontally-paging scroll view that displays a list of photo images and their attributions.
 */
@interface PagingPhotoView : UIScrollView

/**
 * An array of |AttributedPhoto| objects representing the photos to display.
 */
@property(nonatomic, copy) NSArray *photoList;

@end
