//
//  ClassificationViewModel.swift
//  diabeats
//
//  Created by Lyan Alwakeel on 11/03/2023.
//


import Foundation
import SwiftUI

class ClassificationViewModel : ObservableObject {
        
static var instance : ClassificationViewModel? = nil
private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
    private var crud : CRUDViewModel = CRUDViewModel ()


static func getInstance() -> ClassificationViewModel {
if instance == nil
{ instance = ClassificationViewModel() }
return instance! }
        
init() {
// init
}


func classifyDiabeats(x : String) -> String {
    guard let diabeats = crud.getDiabeatsByPK(val: x)
else {
return "Please selsect valid id"
}

guard let result = self.modelParser?.runModel(
input0: Float((diabeats.pregnancies - 0) / (17 - 0)),
input1: Float((diabeats.glucose - 0) / (199 - 0)),
input2: Float((diabeats.bloodPressure - 0) / (122 - 0)),
input3: Float((diabeats.skinThickness - 0) / (99 - 0)),
input4: Float((diabeats.insulin - 0) / (846 - 0)),
input5: Float((diabeats.bmi - 0) / (67.1 - 0)),
input6: Float((diabeats.diabetesPedigreeFunction - 0.78) / (2.42 - 0.78)),
input7: Float((diabeats.age - 21) / (81 - 21))
) else{
return "Error"
}

diabeats.outcome = result
    crud.persistDiabeats(x: diabeats)

return result
}

func cancelClassifyDiabeats() {
//cancel function
}

}
