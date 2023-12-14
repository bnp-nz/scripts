add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
$TLSProtocols = [System.Net.SecurityProtocolType]'Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $TLSProtocols
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$ArcTargets = New-Object System.Collections.Generic.List[Object]
$ArcTargets.Add("https://wdcp.microsoft.com")
$ArcTargets.Add("https://ae-gas-cses-1c.australiaeast.cloudapp.azure.com")
$ArcTargets.Add("https://ae.guestagentsvc-prod.trafficmanager.net")
$ArcTargets.Add("https://ae.his.arc.azure.com")
$ArcTargets.Add("https://agentserviceapi.guestconfiguration.azure.com")
$ArcTargets.Add("https://agentserviceapi.privatelink.guestconfiguration.azure.com")
$ArcTargets.Add("https://agentserviceapi.trafficmanager.net")
$ArcTargets.Add("https://aka.ms")
$ArcTargets.Add("https://apt-geofence-parent.trafficmanager.net")
$ArcTargets.Add("https://arm-fdweb.australiaeast.cloudapp.azure.com")
$ArcTargets.Add("https://arm-frontdoor-australiaeast.trafficmanager.net")
$ArcTargets.Add("https://arm-frontdoor-edge-geo.trafficmanager.net")
$ArcTargets.Add("https://ase-gas-cses-1a.australiasoutheast.cloudapp.azure.com")
$ArcTargets.Add("https://australiaeast-gas.guestconfiguration.azure.com")
$ArcTargets.Add("https://australiaeast-gas.privatelink.guestconfiguration.azure.com")
$ArcTargets.Add("https://australiaeast.management.azure.com")
$ArcTargets.Add("https://australiaeast.web.management.azure.com")
$ArcTargets.Add("https://australiasoutheast-gas.guestconfiguration.azure.com")
$ArcTargets.Add("https://azgn-australiaeast-public-1p-seasg3-007.servicebus.windows.net")
$ArcTargets.Add("https://azgnsaustraliaeast.australiaeast.cloudapp.azure.com")
$ArcTargets.Add("https://azgnstm.trafficmanager.net")
$ArcTargets.Add("https://csd-apt-sea-d-1.southeastasia.cloudapp.azure.com")
$ArcTargets.Add("https://csd-apt-sea-d-2.southeastasia.cloudapp.azure.com")
$ArcTargets.Add("https://csd-apt-sea-d-3.southeastasia.cloudapp.azure.com")
$ArcTargets.Add("https://csd-apt-sea-d-4.southeastasia.cloudapp.azure.com")
$ArcTargets.Add("https://dc.services.visualstudio.com")
$ArcTargets.Add("https://download.microsoft.com")
$ArcTargets.Add("https://gbl.his.arc.azure.com")
$ArcTargets.Add("https://gbl.his.hybridcompute.trafficmanager.net")
$ArcTargets.Add("https://gbl.privatelink.his.arc.azure.com")
$ArcTargets.Add("https://guestnotificationservice.azure.com")
$ArcTargets.Add("https://login.microsoft.com")
$ArcTargets.Add("https://login.microsoftonline.com")
$ArcTargets.Add("https://login.windows.net")
$ArcTargets.Add("https://management.azure.com")
$ArcTargets.Add("https://management.privatelink.azure.com")
$ArcTargets.Add("https://packages.microsoft.com")
$ArcTargets.Add("https://pas.windows.net")
$ArcTargets.Add("https://umsaqql1kvls4mgpd5r3.blob.core.windows.net")
$ArcTargets.Add("https://www.tm.f.prd.aadg.trafficmanager.net")
$ArcResults = New-Object System.Collections.Generic.List[Object]

$AMATargets = New-Object System.Collections.Generic.List[Object]
$AMATargets.Add("https://global.handler.control.monitor.azure.com")
$AMATargets.Add("https://australiaeast.handler.control.monitor.azure.com")
$AMATargets.Add("https://australiasoutheast.handler.control.monitor.azure.com")
$AMATargets.Add("https://11c98a34-add2-4c78-a273-1da29286bab6.ods.opinsights.azure.com")
$AMATargets.Add("https://australiaeast.monitoring.azure.com")
$AMATargets.Add("https://australiasoutheast.monitoring.azure.com")
$AMAResults = New-Object System.Collections.Generic.List[Object]

$MDETargets = New-Object System.Collections.Generic.List[Object]
$MDETargets.Add("https://global.endpoint.security.microsoft.com")
$MDETargets.Add("https://x.cp.wd.microsoft.com")
$MDETargets.Add("https://cdn.x.cp.wd.microsoft.com")
$MDETargets.Add("https://unitedstates.x.cp.wd.microsoft.com/api/report")
$MDETargets.Add("https://australia.x.cp.wd.microsoft.com")
$MDETargets.Add("https://winatp-gw-cus.microsoft.com")
$MDETargets.Add("https://sevillecloudgateway-cus-prd.trafficmanager.net")
$MDETargets.Add("https://mps-mde-prd-cus-14.centralus.cloudapp.azure.com")
$MDETargets.Add("https://winatp-gw-eus.microsoft.com")
$MDETargets.Add("https://sevillecloudgateway-eus-prd.trafficmanager.net")
$MDETargets.Add("https://mps-mde-prd-eus2-14.eastus2.cloudapp.azure.com")
$MDETargets.Add("https://unitedstates.smartscreen.microsoft.com//api/network/mac")
$MDETargets.Add("https://wd-prod-ss-us.trafficmanager.net")
$MDETargets.Add("https://wd-prod-ss-us-east-2-fe.eastus.cloudapp.azure.com")
$MDETargets.Add("https://nf.smartscreen.microsoft.com")
$MDETargets.Add("https://nav-edge.smartscreen.microsoft.com")
$MDETargets.Add("https://unitedstates.smartscreen-prod.microsoft.com//api/network/mac")
$MDETargets.Add("https://go.microsoft.com")
$MDETargets.Add("https://go.microsoft.com.edgekey.net")
$MDETargets.Add("https://e11290.dspg.akamaiedge.net")
$MDETargets.Add("https://discovery.dm.microsoft.com/enrollmentConfiguration/discovery/atp")
$MDETargets.Add("https://us-v20.events.data.microsoft.com/ping")
$MDETargets.Add("https://v10.events.data.microsoft.com")
$MDEResults = New-Object System.Collections.Generic.List[Object]

$PKIetcTargets = New-Object System.Collections.Generic.List[Object]
$PKIetcTargets.Add("http://www.microsoft.com")
$PKIetcTargets.Add("http://crl3.digicert.com")
$PKIetcTargets.Add("http://crl4.digicert.com")
$PKIetcTargets.Add("http://ocsp.digicert.com")
$PKIetcTargets.Add("http://cacerts.digicert.com")
$PKIetcResults = New-Object System.Collections.Generic.List[Object]

Write-Output("** TESTING URLs for Azure Arc **")
$ArcTargets | ForEach-Object {
[URI]$target = $_
$req = [system.Net.WebRequest]::Create($target)
$req.method = "HEAD"

try {
    $result = $req.GetResponse()
} 
catch [System.Net.WebException] {
    $result = $_.Exception.Response
}

[int]$resultcode = $result.StatusCode
$output = $target.AbsoluteUri
$output += "   "
$output += $resultcode
$output
if ($resultcode -eq 0) {
	Write-Output("  ^^^^^^^^ Connection to this target failed, and _may_ be problematic ^^^^^^^^")
}

}
Write-Output("")

Write-Output("** TESTING URLs for Azure Monitor Agent **")
$AMATargets | ForEach-Object {
[URI]$target = $_
$req = [system.Net.WebRequest]::Create($target)
$req.method = "HEAD"

try {
    $result = $req.GetResponse()
} 
catch [System.Net.WebException] {
    $result = $_.Exception.Response
}

[int]$resultcode = $result.StatusCode
$output = $target.AbsoluteUri
$output += "   "
$output += $resultcode
$output
if ($resultcode -eq 0) {
	Write-Output("  ^^^^^^^^ Connection to this target failed, and _may_ be problematic ^^^^^^^^")
}

}
Write-Output("")

Write-Output("** TESTING URLs for Defender for Endpoint **")
$MDETargets | ForEach-Object {
[URI]$target = $_
$req = [system.Net.WebRequest]::Create($target)
$req.method = "HEAD"

try {
    $result = $req.GetResponse()
} 
catch [System.Net.WebException] {
    $result = $_.Exception.Response
}

[int]$resultcode = $result.StatusCode
$output = $target.AbsoluteUri
$output += "   "
$output += $resultcode
$output
if ($resultcode -eq 0) {
	Write-Output("  ^^^^^^^^ Connection to this target failed, and _may_ be problematic ^^^^^^^^")
}

}
Write-Output("")

Write-Output("** TESTING URLs for PKI etc **")
$PKIetcTargets | ForEach-Object {
[URI]$target = $_
$req = [system.Net.WebRequest]::Create($target)
$req.method = "HEAD"

try {
    $result = $req.GetResponse()
} 
catch [System.Net.WebException] {
    $result = $_.Exception.Response
}

[int]$resultcode = $result.StatusCode
$output = $target.AbsoluteUri
$output += "   "
$output += $resultcode
$output
if ($resultcode -eq 0) {
	Write-Output("  ^^^^^^^^ Connection to this target failed, and _may_ be problematic ^^^^^^^^")
}

}
Write-Output("")