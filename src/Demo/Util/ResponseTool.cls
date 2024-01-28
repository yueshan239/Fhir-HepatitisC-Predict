Class Demo.Util.ResponseTool Extends %RegisteredObject
{

/// tf 		T:true  F:flase
/// data 	Return result object
/// message Return message description
ClassMethod Response(tf As %String, data As %DynamicObject, message As %String) As %String
{
	Set Object = {}
	Set success = 0
	Set Object.code=500
	if tf = "T"{
		Set success = 1
		Set Object.code=200
		Set Object.data=data
	}
	Set Object=Object.%Set("success",success,"boolean")
	Set:$L(message)'=0 Object.msg=message
	Set pResponse = Object.%ToJSON()
	Quit pResponse
}

}

