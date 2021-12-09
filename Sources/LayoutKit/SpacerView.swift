import UIKit

public class SpacerView: UIView {
    
    // MARK: - Injected Properties.
    
    private let width: CGFloat?
    private let height: CGFloat?
    
    // MARK: - Computed Properties.
    
    public override var intrinsicContentSize: CGSize {
        if let width = width, let height = height {
            return CGSize(width: width, height: height)
        }
        else if let width = width {
            return CGSize(width: width, height: UIView.noIntrinsicMetric)
        }
        else if let height = height {
            return CGSize(width: UIView.noIntrinsicMetric, height: height)
        }
        else {
            return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
        }
    }
    
    // MARK: - Initialization.
    
    public init(w: CGFloat? = nil, h: CGFloat? = nil, then completion: ((SpacerView) -> Void)? = nil) {
        self.width = w
        self.height = h
        super.init(frame: .zero)
        completion?(self)
    }
    
    public override init(frame: CGRect) {
        self.width = frame.width
        self.height = frame.height
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
