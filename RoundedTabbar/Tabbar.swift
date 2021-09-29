import UIKit

class Tabbar: UITabBar {
    
    private var centerWidth: CGFloat = 64
    private var shapeLayer: CALayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        addShape()
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()

        shapeLayer.path = createPath()
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.shadowColor = UIColor(named: "tabbarShadow")!.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -1)
        shapeLayer.shadowOpacity = 1.0
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: 0).cgPath
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let rect = self.bounds.insetBy(dx: 0, dy: 0)
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: rect.minX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX / 2 - (centerWidth / 2) - 12, y: rect.minY))
        
        bezierPath.addCurve(to: CGPoint(x: rect.maxX / 2 - (centerWidth / 2) - 4, y: rect.minY + 6),
                            controlPoint1: CGPoint(x: rect.maxX / 2 - (centerWidth / 2) - 4, y: rect.minY + 1),
                            controlPoint2: CGPoint(x: rect.maxX / 2 - (centerWidth / 2) - 4, y: rect.minY + 6))
        bezierPath.addCurve(to: CGPoint(x: rect.maxX / 2 + (centerWidth / 2) + 4, y: rect.minY + 6),
                            controlPoint1: CGPoint(x: rect.maxX / 2 - (centerWidth / 2) + 4, y: rect.minY + (centerWidth - 20)),
                            controlPoint2: CGPoint(x: rect.maxX / 2 + (centerWidth / 2) - 4, y: rect.minY + (centerWidth - 20)))
        bezierPath.addCurve(to: CGPoint(x: rect.maxX / 2 + (centerWidth / 2) + 12, y: rect.minY),
                            controlPoint1: CGPoint(x: rect.maxX / 2 + (centerWidth / 2) + 4, y: rect.minY + 6),
                            controlPoint2: CGPoint(x: rect.maxX / 2 + (centerWidth / 2) + 4, y: rect.minY + 1))
        
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        bezierPath.close()
        bezierPath.lineWidth = 2
        
        return bezierPath.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        self.layer.cornerRadius = 20
    }
    
}
