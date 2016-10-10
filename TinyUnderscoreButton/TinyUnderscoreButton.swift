
import UIKit

/**
	A UIButton subclass that adds undersocere to its text.
*/
public class TinyUnderscoreButton: UIButton {

	private weak var _lineView: UIView!	// A view to represent the underscore.

	override init(frame: CGRect) {
		super.init(frame: frame)

		_initializeInternally()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		_initializeInternally()
	}

	private func _initializeInternally() {
		let lineView = UIView(frame: CGRect.zero)
		lineView.backgroundColor = self.titleColorForState(.Normal)
		self.addSubview(lineView)
		_lineView = lineView

		self.setNeedsLayout()
	}

	public override func layoutSubviews() {
		super.layoutSubviews()

		let text = self.titleLabel!.text!
		let font = self.titleLabel!.font
		let attributes = [ NSFontAttributeName: font ]
		let textSize = text.sizeWithAttributes(attributes)

		// Calculate the horizontal position and the width of the underscore.
		let horzMargin: CGFloat = (self.frame.width - textSize.width) / 2
		var rect = CGRect(origin: CGPoint.zero, size: self.frame.size)
		rect.size.height = 1
		rect.origin.x = horzMargin
		rect.size.width = self.frame.width - (horzMargin * 2)

		// Calculate the vertical position of the underscore.
		// The value of 'font.descender(negative value)' is added to position the undersocore
		// just below the text.
		// The last value '-1' is a tweak.
		let bottomMargin = ((self.frame.height - font.lineHeight) / 2) + (-font.descender) - 1
		rect.origin.y = self.frame.height - bottomMargin

		_lineView.frame = rect
	}

	public override func setTitleColor(color: UIColor?, forState state: UIControlState) {
		super.setTitleColor(color, forState: state)

		if (state == .Normal) {
			_lineView.backgroundColor = color
		}
	}
}

