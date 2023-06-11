	                  
import Foundation
import SwiftUI


func instanceFromJSON(typeName: String, json: String) -> AnyObject?
	{ let jdata = json.data(using: .utf8)!
	  let decoder = JSONDecoder()
	  if typeName == "String"
	  { let x = try? decoder.decode(String.self, from: jdata)
	      return x as AnyObject
	  }
  return nil
	}

class CRUDViewModel : ObservableObject {
		                      
	static var instance : CRUDViewModel? = nil
	var db : DB?
		
	// path of document directory for SQLite database (absolute path of db)
	let dbpath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> CRUDViewModel {
		if instance == nil
	     { instance = CRUDViewModel()
         }
	    return instance! }
	                          
	init() { 
		// init
		db = DB.obtainDatabase(path: "\(dbpath)/myDatabase.sqlite3")
		loadDiabeats()
	}
	      
	@Published var currentDiabeats : DiabeatsVO? = DiabeatsVO.defaultDiabeatsVO()
	@Published var currentDiabeatss : [DiabeatsVO] = [DiabeatsVO]()

	func createDiabeats(x : DiabeatsVO) {
		let res : Diabeats = createByPKDiabeats(key: x.id)
			res.id = x.id
		res.pregnancies = x.pregnancies
		res.glucose = x.glucose
		res.bloodPressure = x.bloodPressure
		res.skinThickness = x.skinThickness
		res.insulin = x.insulin
		res.bmi = x.bmi
		res.diabetesPedigreeFunction = x.diabetesPedigreeFunction
		res.age = x.age
		res.outcome = x.outcome
	    currentDiabeats = x

	    do { try db?.createDiabeats(diabeatsvo: x) }
	    catch { print("Error creating Diabeats") }
	}
	
	func cancelCreateDiabeats() {
		//cancel function
	}

	func loadDiabeats() {
		let res : [DiabeatsVO] = listDiabeats()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKDiabeats(key: x.id)
	        obj.id = x.getId()
        obj.pregnancies = x.getPregnancies()
        obj.glucose = x.getGlucose()
        obj.bloodPressure = x.getBloodPressure()
        obj.skinThickness = x.getSkinThickness()
        obj.insulin = x.getInsulin()
        obj.bmi = x.getBmi()
        obj.diabetesPedigreeFunction = x.getDiabetesPedigreeFunction()
        obj.age = x.getAge()
        obj.outcome = x.getOutcome()
			}
		 currentDiabeats = res.first
		 currentDiabeatss = res
		}
		
  		func listDiabeats() -> [DiabeatsVO] {
			if db != nil
			{ currentDiabeatss = (db?.listDiabeats())!
			  return currentDiabeatss
			}
			currentDiabeatss = [DiabeatsVO]()
			let list : [Diabeats] = diabeatsAllInstances
			for (_,x) in list.enumerated()
			{ currentDiabeatss.append(DiabeatsVO(x: x)) }
			return currentDiabeatss
		}
				
		func stringListDiabeats() -> [String] { 
			currentDiabeatss = listDiabeats()
			var res : [String] = [String]()
			for (_,obj) in currentDiabeatss.enumerated()
			{ res.append(obj.toString()) }
			return res
		}
				
		func getDiabeatsByPK(val: String) -> Diabeats? {
			var res : Diabeats? = Diabeats.getByPKDiabeats(index: val)
			if res == nil && db != nil
			{ let list = db!.searchByDiabeatsid(val: val)
			if list.count > 0
			{ res = createByPKDiabeats(key: val)
			}
		  }
		  return res
		}
				
		func retrieveDiabeats(val: String) -> Diabeats? {
			let res : Diabeats? = getDiabeatsByPK(val: val)
			return res 
		}
				
		func allDiabeatsids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentDiabeatss.enumerated()
			{ res.append(item.id + "") }
			return res
		}
				
		func setSelectedDiabeats(x : DiabeatsVO)
			{ currentDiabeats = x }
				
		func setSelectedDiabeats(i : Int) {
			if 0 <= i && i < currentDiabeatss.count
			{ currentDiabeats = currentDiabeatss[i] }
		}
				
		func getSelectedDiabeats() -> DiabeatsVO?
			{ return currentDiabeats }
				
		func persistDiabeats(x : Diabeats) {
			let vo : DiabeatsVO = DiabeatsVO(x: x)
			editDiabeats(x: vo)
		}
			
		func editDiabeats(x : DiabeatsVO) {
			let val : String = x.id
			let res : Diabeats? = Diabeats.getByPKDiabeats(index: val)
			if res != nil {
			res!.id = x.id
		res!.pregnancies = x.pregnancies
		res!.glucose = x.glucose
		res!.bloodPressure = x.bloodPressure
		res!.skinThickness = x.skinThickness
		res!.insulin = x.insulin
		res!.bmi = x.bmi
		res!.diabetesPedigreeFunction = x.diabetesPedigreeFunction
		res!.age = x.age
		res!.outcome = x.outcome
		}
		currentDiabeats = x
			if db != nil
			 { db!.editDiabeats(diabeatsvo: x) }
		 }
			
	    func cancelDiabeatsEdit() {
	    	//cancel function
	    }
	}
