Class Demo.FHIRTools Extends %RegisteredObject
{

/// d ##Class(Demo.FHIRTools).CSVToFhir()
ClassMethod CSVToJson(FilePath) As %DynamicObject
{
	;Set FilePath = "C:\code\HepatitisCdata.csv"
	Set File = ##class(%Stream.FileCharacter).%New()
	Set tSC = File.LinkToFile(FilePath)
	Set j=0,title="",tName="",data=##class(%DynamicArray).%New()
	While 'File.AtEnd{
		S j=j+1
		Set tLine=File.ReadLine()
		if j=1{
			s title = tLine 
			Set T1=$LISTFROMSTRING(title,",")
			For i=1:1:($LISTLENGTH(T1)){
				Set tName(i) =$ZSTRIP(($LISTGET(T1,i)),"<>W")
			}
			;zw tName
		}
		else{
		// Analyze content
			Set T2=$LISTFROMSTRING(tLine,",")
			Set Object={}
			For i=1:1:($LISTLENGTH(T2)){
				Set content(i) =$ZSTRIP(($LISTGET(T2,i)),"<>W")
				Set Object=Object.%Set(tName(i),content(i))
				
			}
			d data.%Push(Object)
		}

	}
	Quit data
}

ClassMethod JsonToFhir(DyArr As %DynamicArray, Path As %String) As %Status
{
	try{
	d ..TypeByCode()
	Set status =$$$YES
	Set iter= DyArr.%GetIterator()	
	while iter.%GetNext(.key , .value )	
	{ 
		Set json ={
			"resourceType": "Bundle",
			"type": "transaction",
			"entry": []
		}
		Set Age = value.Age
		set birthDate =$ZDATE($H-(365*value.Age),3)
	    Set Patient =..Patient(value.Sex,birthDate,.uuid)
	    d json.entry.%Push(Patient)
		Set Viter= value.%GetIterator()	
		while Viter.%GetNext(.Vkey , .Vvalue ){
			
			if ((Vkey = "ALB")!(Vkey = "ALP")!(Vkey = "ALT")!(Vkey = "AST")!(Vkey = "BIL")!(Vkey = "CHE")
				!(Vkey = "CHOL")!(Vkey = "CREA")!(Vkey = "GGT")!(Vkey = "PROT")!(Vkey = "Category")){
				Set Observation =..Observation(Vkey,uuid,Vvalue)
			    d json.entry.%Push(Observation)
			}
#;			//	General health
#;			if Vkey="Category"{
#;			
#;			}
		
		}
	// 	Export as a josn file
		d ..FhirExport(uuid,json,Path)
	}
	}catch e{
		Set status=$$$NO			
	Set err =e.DisplayString()
		zw err
	}
	Quit status
}

ClassMethod JsonObjToFhir(value As %DynamicObject) As %DynamicObject
{
	try{
		d ..TypeByCode()
		Set status =$$$YES
		Set json ={
			"resourceType": "Bundle",
			"type": "transaction",
			"entry": []
		}
		Set Age = value.Age
		set birthDate =$ZDATE($H-(365*value.Age),3)
	    Set Patient =..Patient(value.Sex,birthDate,.uuid)
	    d json.entry.%Push(Patient)
		Set Viter= value.%GetIterator()	
		while Viter.%GetNext(.Vkey , .Vvalue ){
			
			if ((Vkey = "ALB")!(Vkey = "ALP")!(Vkey = "ALT")!(Vkey = "AST")!(Vkey = "BIL")!(Vkey = "CHE")
				!(Vkey = "CHOL")!(Vkey = "CREA")!(Vkey = "GGT")!(Vkey = "PROT")!(Vkey = "Category")){
				Set Observation =..Observation(Vkey,uuid,Vvalue)
			    d json.entry.%Push(Observation)
			}
		}
	}catch e{
		Set status=$$$NO
		set json={}			
		Set json.err =e.DisplayString()
		;zw json
	}
	Quit json
}

/// Export as a josn file
ClassMethod FhirExport(uid, json, Path) As %Status
{
	Set jsonContent = json.%ToJSON()
	if '(##class(%File).DirectoryExists(Path)){
		 Set status= ##class(%File).CreateDirectoryChain(Path)
	}
	Set fileName=Path_uid_".json"
	Set stream=##class(%FileCharacterStream).%New()
	Set stream.Filename=fileName
	do stream.MoveToEnd()
	do stream.WriteLine(jsonContent)
	do stream.SaveStream()
	Quit $$$YES
}

/// d ##Class(Demo.FHIRTools).Observation("m",12314,1412)
/// Creat Patient Info
ClassMethod Patient(gender As %String, birthDate As %String, Output uuid As %String) As %DynamicObject
{
	Set Object ={},uuid=$zcvt(##class(%SYSTEM.Util).CreateGUID(),"L")
	Set request = {"method": "POST","url": "Patient"}
	Set fullUrl ="urn:uuid:"_uuid
	Set resource={
        "resourceType": "Patient",
        "id": "",
        "name": [],
        "gender": "male",
        "birthDate": "1990-05-15",
        "address": [
          {
            "use": "home",
            "line": [
              "123 Main St"
            ],
            "city": "New York",
            "state": "NY",
            "postalCode": "10001",
            "country": "USA"
          }
        ],
        "identifier": []}
        
	// Simulate patient information
	Set nameObj={},name="Mike"_$R(100),givenArr=[],nameArr=[]
	d givenArr.%Push(name)
	Set nameObj.given=givenArr
	d nameArr.%Push(nameObj)
	Set resource.name = nameArr
	Set resource.id = uuid
	Set resource.birthDate=birthDate
	Set:gender="m" resource.gender="male"
	Set:gender="f" resource.gender="female"
	Set identifierObj={"system": "http://example.com/patient", "value": ""}
	Set identifierObj.value=uuid
	d resource.identifier.%Push(identifierObj)
	set Object.request = request
	set Object.fullUrl = fullUrl
	set Object.resource = resource
#;	zw Object
	Quit Object
}

/// d ##Class(Demo.FHIRTools).Observation("ALP",12314,1412)
/// Creat Observation
ClassMethod Observation(type, Pid, value)
{
	Set Object ={},uuid=$zcvt(##class(%SYSTEM.Util).CreateGUID(),"L")
	Set request = {"method": "POST","url": "Observation"}
	Set fullUrl ="urn:uuid:"_uuid
	Set resource ={
        "resourceType": "Observation",
        "id": "",
        "status": "final",
        "code": {},
        "subject": {
          "reference": ""
        },
        "effectiveDateTime": ""
       
      }
	Set Object.fullUrl=fullUrl
	Set resource.id=uuid
	Set resource.effectiveDateTime=$replace($zdt($now(),3)_"+00:00"," ","T")
	Set code={}
	Set codarr=[],coding={}
    Set coding.system="http://loinc.org"
    Set coding.code=^loinc(type,"cCode")
    Set coding.display=type
    Set:type="Category" coding.display="General health"
	Set code.text=type
	Set code.coding=[].%Push(coding)

	if type '="Category"{
		// valueQuantity
		Set valueQuantity ={
	          "code": "",
	          "system": "http://unitsofmeasure.org",
	          "value": null,
	          "unit": ""
	        }
	  	Set valueQuantity.code= ^loinc(type,"vCode")   
	  	Set valueQuantity.unit= ^loinc(type,"vUnit")   
	  	Set valueQuantity.value= value+0
	  	Set resource.valueQuantity = valueQuantity	
	}else{
		if (value = "0=Blood Donor")!(value = "0s=suspect Blood Donor"){
			d resource.%Set("valueBoolean",1,"boolean")
		}else{
			d resource.%Set("valueBoolean",0,"boolean")
		}
		Set code.text=value
		
	}
	Set resource.code=code
	// subject
	Set resource.subject.reference=Pid
  	Set Object.request=request
  	Set Object.resource=resource
  	Quit Object
}

/// d ##Class(Demo.FHIRTools).TypeByCode()
/// Create Code Type 
ClassMethod TypeByCode() As %DynamicObject
{
	// 
	Set ^loinc("ALB")="ALB"
	Set ^loinc("ALB","cCode")="1751-7"
	Set ^loinc("ALB","vCode")="g/L"
	Set ^loinc("ALB","vUnit")="grams/liter"
	
	Set ^loinc("ALP")="ALP"
	Set ^loinc("ALP","cCode")="6768-6"
	Set ^loinc("ALP","vCode")="U/L"
	Set ^loinc("ALP","vUnit")="units/liter"
	
	Set ^loinc("ALT")="ALT"
	Set ^loinc("ALT","cCode")="29463-7"
	Set ^loinc("ALT","vCode")="U/L"
	Set ^loinc("ALT","vUnit")="units/liter"

	Set ^loinc("AST")="AST"
	Set ^loinc("AST","cCode")="2345-7"
	Set ^loinc("AST","vCode")="U/L"
	Set ^loinc("AST","vUnit")="units/liter"
	
	Set ^loinc("BIL")="BIL"
	Set ^loinc("BIL","cCode")="1975-2"
	Set ^loinc("BIL","vCode")="umol/L"
	Set ^loinc("BIL","vUnit")="micromoles/liter"
	
	Set ^loinc("CHE")="CHE"
	Set ^loinc("CHE","cCode")="1920-8"
	Set ^loinc("CHE","vCode")="U/L"
	Set ^loinc("CHE","vUnit")="units/liter"
	
	Set ^loinc("HDL-C")="HDL-C"
	Set ^loinc("HDL-C","cCode")="5737-9"
	Set ^loinc("HDL-C","vCode")="mmol/L"
	Set ^loinc("HDL-C","vUnit")="millimoles/liter"
	
	Set ^loinc("CHOL")="CHOL"
	Set ^loinc("CHOL","cCode")="2093-3"
	Set ^loinc("CHOL","vCode")="mmol/L"
	Set ^loinc("CHOL","vUnit")="millimoles/liter"
	
	Set ^loinc("CREA")="CREA"
	Set ^loinc("CREA","cCode")="2160-0"
	Set ^loinc("CREA","vCode")="mmol/L"
	Set ^loinc("CREA","vUnit")="millimoles/liter"
	
	Set ^loinc("GGT")="GGT"
	Set ^loinc("GGT","cCode")="2324-2"
	Set ^loinc("GGT","vCode")="U/L"
	Set ^loinc("GGT","vUnit")="units/liter"
	
	Set ^loinc("PROT")="PROT"
	Set ^loinc("PROT","cCode")="2885-2"
	Set ^loinc("PROT","vCode")="g/L"
	Set ^loinc("PROT","vUnit")="grams/liter"
	
	Set ^loinc("Category")="General health"
	Set ^loinc("Category","cCode")="8310-5"
}

/// d ##Class(Demo.FHIRTools).CreateRecordPython()
ClassMethod CreateRecordPython() [ Language = python ]
{
    import csv

    arr=[]
    FilePath = 'C:\code\HepatitisCdata.csv'
    with open(FilePath) as f:
     f_csv = csv.DictReader(f)
     for row in f_csv:
      arr.append(row)
     print(row)
      #print('Category',row['Category'])
     my_list = list(map(',', arr))
     str=''.join(my_list)
     print(str)
     return str
}

}

