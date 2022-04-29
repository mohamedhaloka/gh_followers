
import UIKit


struct UIHelper{
    static func createThreeColumnFlowLayout(in view : UIView) -> UICollectionViewFlowLayout {
        let width                   = view.bounds.width
        let padding : CGFloat       = 12
        let itemSpacing : CGFloat   = 10
        let avialableWidth          = width - (padding * 2) - (itemSpacing * 2)
        let itemWidth               = avialableWidth / 3
        
        let collectionFlow = UICollectionViewFlowLayout()
        collectionFlow.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        collectionFlow.itemSize = CGSize(width: itemWidth, height: itemWidth+40)
        
        
        return collectionFlow
    }
}
