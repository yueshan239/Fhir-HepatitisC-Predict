Class Demo.Operation.Fhir
{

/// Initialization
ClassMethod Initialization(pRequest As %String, Output pResponse As %String) As %Status
{
	Set status = $$$OK,pResponse=""
	Set ResponseTool = ##class(Demo.Util.ResponseTool).%New()
	Set Util = ##class(Demo.FHIRTools).%New()
	Try{
		Set Object = ##class(%DynamicObject).%New()
		Set file="/usr/local/src/HepatitisCdata.csv"
		Set Outpath="/usr/local/src/josn"
		Set data=Util.CSVToJson(file)
		set status=Util.JsonToFhir(data,Outpath)
		set webApplication="/fhir/r4"
		Set sc=##class(HS.FHIRServer.Tools.DataLoader).SubmitResourceFiles(Outpath,"FHIRSERVER",webApplication)
		Set pResponse =ResponseTool.Response("T",Object,"Operation successful")
	}Catch e {
		Set status =e.DisplayString()
		Set pResponse =ResponseTool.Response("F",,"operation failed")
	}
	Quit status
}

/// Predictive
ClassMethod PredictiveInfo(pRequest As %String, Output pResponse As %String) As %Status
{
	Set status = $$$OK,pResponse="",GHCodeText=""
	Set ResponseTool = ##class(Demo.Util.ResponseTool).%New()
	Set Util = ##class(Demo.FHIRTools).%New()
	Try{
		Set Object = ##class(%DynamicObject).%New()
		#Dim json As %DynamicObject =##class(%DynamicObject).%FromJSON(pRequest)			
		Set fhirOBj=Util.JsonObjToFhir(json)
		Set body=fhirOBj.%ToJSON()
		Set tSC=..HTTPSend("127.0.0.1","52773","/fhir/r4/",body,.Out)
		Set sql="SELECT top 1 PREDICT(Hepatitis) GHCodeText FROM T2.HepatitisData order by id desc "
		Set tStatement = ##class(%SQL.Statement).%New()
	    Set Status = tStatement.%Prepare(sql)
	    Set rset = tStatement.%Execute()
	    while rset.%Next(){
		   Set GHCodeText =rset.%Get("GHCodeText")
		}
	    if GHCodeText ="0=Blood Donor"{ Set Object.GHCodeText="Low Risk"}
	    elseif GHCodeText="0s=suspect Blood Donor"{ Set Object.GHCodeText="Medium Risk"}
	    else{ Set Object.GHCodeText="High Risk"}

	    
		Set pResponse =ResponseTool.Response("T",Object,"Operation successful")
	}Catch e {
		Set status =e.DisplayString()
		Set pResponse =ResponseTool.Response("F",,"operation failed")
	}
	Quit status
}

ClassMethod HTTPSend(IPAddress As %String, Port As %String, Url As %String, Body As %String, Output HttpResponse As %String(MAXLEN=256000)) As %Status
{
	
	Set httpRequest=##class(%Net.HttpRequest).%New()
	Do httpRequest.SetHeader("Content-Type","application/json+fhir")
	Do httpRequest.SetHeader("Accept","*/*")
    Set httpRequest.Port=Port
    Set httpRequest.Server=IPAddress
    Set httpRequest.Https=0
    Set httpRequest.Timeout=600
    Set httpRequest.ContentCharset="UTF-8"
    Set httpRequest.ContentEncoding="UTF-8"
    d httpRequest.EntityBody.Write(Body)
    Set status=httpRequest.Post(Url)
    IF 'status {
	    Set HttpResponse = "Connection failed, call exception"
	    return "Connection failed, call exception："_$SYSTEM.Status.GetErrorText(status)
	}
    Set response = httpRequest.HttpResponse
    Set ResponseData = response.Data
    Set HttpResponse=""
    while 'ResponseData.AtEnd{
	    Set HttpResponse=HttpResponse_ResponseData.Read()
    }

    return $$$OK
}

}

