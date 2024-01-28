Class Demo.Rest.API Extends %CSP.REST
{

Parameter HandleCorsRequest = "true";

Parameter CHARSET As %String = "UTF-8";

Parameter DefaultContentType As %String = "application/json+fhir";

XData UrlMap
{
<Routes>
<Route Url="/*" Method="OPTIONS" Call="GetStatus"/>
<Route Url="/Initialization" Method="POST" Call="Initialization"/>
<Route Url="/PredictiveInfo" Method="POST" Call="PredictiveInfo"/>
</Routes>
}

ClassMethod GetStatus(ser As %String) As %Status
{
     Quit $$$OK
}

ClassMethod PredictiveInfo() As %String
{
	Do %response.SetHeader("Content-Type", "application/json+fhir;charset=UTF-8")
	Set:$L(%request.Content)'=0 content=$zcvt(%request.Content.Read(),"I","UTF8")
	Set tsc = ##class(Demo.Operation.Fhir).PredictiveInfo(content,.out)
	w out
    Quit $$$OK
}

ClassMethod Initialization() As %String
{
	Do %response.SetHeader("Content-Type", "application/json+fhir;charset=UTF-8")
	Set:$L(%request.Content)'=0 content=$zcvt(%request.Content.Read(),"I","UTF8")
	Set tsc = ##class(Demo.Operation.Fhir).Initialization(content,.out)
	w out
    Quit $$$OK
}

}

