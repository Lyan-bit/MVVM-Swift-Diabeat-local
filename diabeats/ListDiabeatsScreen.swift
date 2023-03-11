
import SwiftUI

struct ListDiabeatsScreen: View {
    @ObservedObject var model : CRUDViewModel = CRUDViewModel.getInstance()

     var body: some View
     { List(model.currentDiabeatss){ instance in 
     	ListDiabeatsRowScreen(instance: instance) }
       .onAppear(perform: { model.listDiabeats() })
     }
    
}

struct ListDiabeatsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListDiabeatsScreen(model: CRUDViewModel.getInstance())
    }
}

