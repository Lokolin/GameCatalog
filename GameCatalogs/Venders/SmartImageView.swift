

import UIKit
import Kingfisher

class SmartImageView: UIImageView, UIGestureRecognizerDelegate {
    
    private var task: RetrieveImageTask?
    typealias BlockWithView = (_ view: SmartImageView) -> ()
    typealias BlockWithImage = (_ view: UIImage, _ view: SmartImageView) -> ()
    typealias BlockWithImageReturnedImage = (_ view: UIImage, _ view: SmartImageView) -> UIImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }
    
    init (placeHolderImage: UIImage?) {
        super.init(image: nil)
        self.placeHolderImage = placeHolderImage
        construct()
    }
    
    var placeHolderImage: UIImage?
    var activityIndicatorViewStyle: UIActivityIndicatorView.Style = .gray
    var activityIndicatorColor: UIColor = .blue
    var showActivityIndicator:Bool = true
    
    private func construct() {
        isUserInteractionEnabled = true
        clipsToBounds = true
        contentMode = .scaleAspectFill
        kf.indicatorType = showActivityIndicator ? .activity : .none
        (kf.indicator?.view as! UIActivityIndicatorView).color = activityIndicatorColor
        (kf.indicator?.view as! UIActivityIndicatorView).style = activityIndicatorViewStyle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionTap(_:)))
        tap.delegate = self
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
        return tap
        }()
    
    private(set) lazy var doubleTapGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionDoubleTap(_:)))
        tap.delegate = self
        tap.numberOfTapsRequired = 2
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
        self.tapGestureRecognizer.require(toFail: tap)
        return tap
        }()
    
    @discardableResult
    func tap(block: BlockWithView?) -> SmartImageView {
        tapBlock = block; return self
    }
    private var tapBlock: BlockWithView? { didSet { let _ = tapGestureRecognizer } }
    
    @discardableResult
    func doubleTap(block: BlockWithView?) -> SmartImageView {
        doubleTapBlock = block; return self
    }
    private var doubleTapBlock: BlockWithView? { didSet { let _ = doubleTapGestureRecognizer } }
    
    @discardableResult
    func completion(block: BlockWithImage?) -> SmartImageView {
        completion = block; return self
    }
    var completion: BlockWithImage?
    
    @discardableResult
    func completionBeforeSet(block: BlockWithImageReturnedImage?) -> SmartImageView {
        completionBeforeSet = block; return self
    }
    private var completionBeforeSet: BlockWithImageReturnedImage?
    
    @objc private func actionTap(_ tap: UITapGestureRecognizer) { tapBlock?(self) }
    
    @objc private func actionDoubleTap(_ tap: UITapGestureRecognizer) { doubleTapBlock?(self) }
    
    var imageURI: String? = "" {
        didSet {
            guard let urlString = imageURI
                else { return }
            if let url = URL.init(string: urlString) {
                let resource = ImageResource(downloadURL: url)
                let options: KingfisherOptionsInfo = [
                    .transition(.fade(0.33)),
                    .scaleFactor(UIScreen.main.scale)
                ]
                task = kf.setImage(with: resource, placeholder: placeHolderImage, options: options, progressBlock: nil, completionHandler: completion)
            }
        }
    }
    
    private func completion(_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) {
        guard let image = image else { return }
        var finalImage = image
        if let returnedImage = completionBeforeSet?(image, self) { finalImage = returnedImage }
        if imageURL?.absoluteString == imageURI { self.image = finalImage }
        completion?(finalImage, self)
    }
    
}
