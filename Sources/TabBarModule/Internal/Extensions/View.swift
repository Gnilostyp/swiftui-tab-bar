//
//  Created by Vlad Gnilozub on 21.02.24.
//

import SwiftUI

extension View {
    func hide(_ hide: Bool) -> some View {
        HideableView(isHidden: .constant(hide), view: self)
    }

    func hide(_ isHidden: Binding<Bool>) -> some View {
        HideableView(isHidden: isHidden, view: self)
    }
}
