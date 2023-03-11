              
              
              
import SwiftUI

struct ContentView : View {
	
	@ObservedObject var model : CRUDViewModel
    @ObservedObject var classification : ClassificationViewModel
	                                       
	var body: some View {
		TabView {
            CreateDiabeatsScreen (model: model).tabItem { 
                        Image(systemName: "1.square.fill")
	                    Text("+Diabeats")} 
            ListDiabeatsScreen (model: model).tabItem { 
                        Image(systemName: "2.square.fill")
	                    Text("ListDiabeats")} 
            ClassifyDiabeatsScreen (model: model, classification: classification).tabItem {
                        Image(systemName: "3.square.fill")
	                    Text("ClassifyDiabeats")} 
				}.font(.headline)
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: CRUDViewModel.getInstance(), classification: ClassificationViewModel.getInstance())
    }
}

