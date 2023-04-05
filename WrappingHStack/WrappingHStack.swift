//
//  WrappingHStack.swift
//  WrappingHStack
//
//  Created by Aleksy Krolczyk on 05/04/2023.
//

import SwiftUI

struct WrappingHStack: Layout {
    let viewsPerRow: Int
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat
    
    init(viewsPerRow: Int, horizontalSpacing: CGFloat = 0, verticalSpacing: CGFloat = 0) {
        self.viewsPerRow = viewsPerRow
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let width = bounds.size.width
        let height = bounds.size.height
        
        let rowsCount = subviews.count / viewsPerRow
        
        let widthPerView = (width - horizontalSpacing * (viewsPerRow - 1)) / viewsPerRow
        let heightPerView = (height - verticalSpacing * (rowsCount - 1)) / rowsCount
        
        let m = min(widthPerView, heightPerView)
        let myProposal = ProposedViewSize(width: m, height: m)
        
        for (index, subview) in subviews.enumerated() {
            let x = index % viewsPerRow
            let y = index / viewsPerRow
            
            let xOffset = widthPerView / 2 + (widthPerView + horizontalSpacing) * x
            let yOffset = heightPerView / 2 + (heightPerView + verticalSpacing) * y
            
            let point = CGPoint(x: bounds.minX + xOffset, y: bounds.minY + yOffset)
            subview.place(at: point, anchor: .center, proposal: myProposal)
        }
    }
}

extension CGFloat {
    static func - (lhs: CGFloat, rhs: Int) -> CGFloat {
        lhs - CGFloat(rhs)
    }
    
    static func * (lhs: CGFloat, rhs: Int) -> CGFloat {
        lhs * CGFloat(rhs)
    }
    
    static func / (lhs: CGFloat, rhs: Int) -> CGFloat {
        lhs / CGFloat(rhs)
    }
}

extension CGSize {
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}
