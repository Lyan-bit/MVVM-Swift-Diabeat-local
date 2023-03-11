              
              
import SwiftUI

@main 
struct diabeatsMain : App {

	var body: some Scene {
	        WindowGroup {
                ContentView(model: CRUDViewModel.getInstance(), classification: ClassificationViewModel.getInstance())
	        }
	    }
	} 
