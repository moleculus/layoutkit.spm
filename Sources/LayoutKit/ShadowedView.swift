import UIKit

open class ShadowedView: UIView {

    // MARK: - UI Properties.
    
    open lazy var shadowView = UIView(frame: .zero).then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = false
    }
    
    open lazy var clippedContentView = UIView(frame: .zero).then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
    }
    
    // MARK: - Observed Properties.
    
    public var shadow: Shadow? {
        didSet {
            guard let shadow = shadow else {
                return
            }
            
            shadowView.layer.shadowColor = shadow.color.cgColor
            shadowView.layer.shadowOffset = shadow.offset
            shadowView.layer.shadowOpacity = shadow.opacity
            shadowView.layer.shadowRadius = shadow.radius
        }
    }
    
    public var clipping: Clipping? {
        didSet {
            guard let clipping = clipping else {
                return
            }
            
            clippedContentView.layer.cornerRadius = clipping.cornerRadius
            clippedContentView.layer.cornerCurve = clipping.cornerCurve
        }
    }
    
    // MARK: - Initialization.
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        backgroundColor = .clear
        
        addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        shadowView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            
        addSubview(clippedContentView)
        clippedContentView.translatesAutoresizingMaskIntoConstraints = false
        clippedContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        clippedContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        clippedContentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        clippedContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle.
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if let shadow = shadow {
            shadowView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: shadow.cornerRadius).cgPath
        }
    }
    
    // MARK: - Public Methods.
    
    public func setShadow(_ shadow: Shadow) {
        self.shadow = shadow
    }
    
    public override func addSubview(_ view: UIView) {
        if view == shadowView || view == clippedContentView {
            super.addSubview(view)
        }
        else {
            clippedContentView.addSubview(view)
        }
    }
    
}
