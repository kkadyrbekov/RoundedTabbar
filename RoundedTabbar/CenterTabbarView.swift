import UIKit

final class CenterTabbarView: UIView {

    lazy var centerTitleLabel = makeTitleLabel()
    lazy var centerButton = makeCenterButton()
    
    private var centerButtonWidthHeight: CGFloat = 52
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews() {
        addSubview(centerTitleLabel)
        addSubview(centerButton)
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
    }
    
    func setConstraints() {
        centerButton.anchor(
            .top(topAnchor),
            .width(centerButtonWidthHeight),
            .height(centerButtonWidthHeight),
            .centerX(centerXAnchor)
        )
        
        centerTitleLabel.anchor(
            .centerX(centerButton.centerXAnchor),
            .bottom(bottomAnchor, constant: 4),
            .leading(leadingAnchor),
            .trailing(trailingAnchor)
        )
    }
    
    func setProperties() {
        backgroundColor = .clear
    }
    
    @objc func centerButtonTapped() {
        print(#function)
    }
}

private extension CenterTabbarView {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Record"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textAlignment = .center
        return label
    }
    
    func makeCenterButton() -> CenterTabbarButton {
        let button = CenterTabbarButton()
        button.setImage(UIImage(named: "call"), for: .normal)
        button.setImage(UIImage(named: "call_highlited"), for: .highlighted)
        button.backgroundColor = UIColor(named: "accent200")
        button.cornerRadius = centerButtonWidthHeight / 2
        button.layer.shadowColor = UIColor(named: "accent200")?.withAlphaComponent(0.5).cgColor
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 6
        return button
    }
}

class CenterTabbarButton: UIButton {
    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.15) {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 0.92, y: 0.92)
                }
            } else {
                UIView.animate(withDuration: 0.15) {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                }
            }
        }
    }
}
