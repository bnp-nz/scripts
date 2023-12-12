#!/bin/bash
#
# A basic script to check endpoint connectivity for Azure Arc, Azure Monitor Agent, and Microsoft Defender for Endpoint
# Requires curl
#
# Version 1.0 13/12/2023 - tested using my own tenancy endpoints, so that MS docs requiring
#                          "allow *.subdomain.microsoft.com" actually have useful targets
#
# Note that as of 13/12/2023, azgnsaustraliaeast.australiaeast.cloudapp.azure.com is tested even though it doesn't resolve
# which looks like a misconfig in MS CNAMEs for one of their services
# So this will show as problematic, but it's not a connectivity issue
#
if command -v curl &> /dev/null; then
  echo "Using curl for testing"
else
  echo "Curl not found, exiting";
  exit 1
fi

declare -a ArcTargets=("https://ae-gas-cses-1c.australiaeast.cloudapp.azure.com"
"https://ae.guestagentsvc-prod.trafficmanager.net"
"https://ae.his.arc.azure.com"
"https://agentserviceapi.guestconfiguration.azure.com"
"https://agentserviceapi.privatelink.guestconfiguration.azure.com"
"https://agentserviceapi.trafficmanager.net"
"https://aka.ms"
"https://apt-geofence-parent.trafficmanager.net"
"https://arm-fdweb.australiaeast.cloudapp.azure.com"
"https://arm-frontdoor-australiaeast.trafficmanager.net"
"https://arm-frontdoor-edge-geo.trafficmanager.net"
"https://ase-gas-cses-1a.australiasoutheast.cloudapp.azure.com"
"https://australiaeast-gas.guestconfiguration.azure.com"
"https://australiaeast-gas.privatelink.guestconfiguration.azure.com"
"https://australiaeast.management.azure.com"
"https://australiaeast.web.management.azure.com"
"https://australiasoutheast-gas.guestconfiguration.azure.com"
"https://azgn-australiaeast-public-1p-seasg3-007.servicebus.windows.net"
"https://azgnsaustraliaeast.australiaeast.cloudapp.azure.com"
"https://azgnstm.trafficmanager.net"
"https://csd-apt-sea-d-1.southeastasia.cloudapp.azure.com"
"https://csd-apt-sea-d-2.southeastasia.cloudapp.azure.com"
"https://csd-apt-sea-d-3.southeastasia.cloudapp.azure.com"
"https://csd-apt-sea-d-4.southeastasia.cloudapp.azure.com"
"https://dc.services.visualstudio.com"
"https://download.microsoft.com"
"https://gbl.his.arc.azure.com"
"https://gbl.his.hybridcompute.trafficmanager.net"
"https://gbl.privatelink.his.arc.azure.com"
"https://guestnotificationservice.azure.com"
"https://login.microsoft.com"
"https://login.microsoftonline.com"
"https://login.windows.net"
"https://management.azure.com"
"https://management.privatelink.azure.com"
"https://packages.microsoft.com"
"https://pas.windows.net"
"https://umsaqql1kvls4mgpd5r3.blob.core.windows.net"
"https://www.tm.f.prd.aadg.trafficmanager.net"
)

declare -a AMATargets=("https://global.handler.control.monitor.azure.com"
"https://australiaeast.handler.control.monitor.azure.com"
"https://australiasoutheast.handler.control.monitor.azure.com"
"https://11c98a34-add2-4c78-a273-1da29286bab6.ods.opinsights.azure.com"
"https://australiaeast.monitoring.azure.com"
"https://australiasoutheast.monitoring.azure.com"
)

declare -a MDETargets=("https://global.endpoint.security.microsoft.com"
"https://x.cp.wd.microsoft.com"
"https://cdn.x.cp.wd.microsoft.com"
"https://unitedstates.x.cp.wd.microsoft.com/api/report"
"https://australia.x.cp.wd.microsoft.com"
"https://winatp-gw-cus.microsoft.com"
"https://sevillecloudgateway-cus-prd.trafficmanager.net"
"https://mps-mde-prd-cus-14.centralus.cloudapp.azure.com"
"https://winatp-gw-eus.microsoft.com"
"https://sevillecloudgateway-eus-prd.trafficmanager.net"
"https://mps-mde-prd-eus2-14.eastus2.cloudapp.azure.com"
"https://unitedstates.smartscreen.microsoft.com//api/network/mac"
"https://wd-prod-ss-us.trafficmanager.net"
"https://wd-prod-ss-us-east-2-fe.eastus.cloudapp.azure.com"
"https://nf.smartscreen.microsoft.com"
"https://nav-edge.smartscreen.microsoft.com"
"https://unitedstates.smartscreen-prod.microsoft.com//api/network/mac"
"https://go.microsoft.com"
"https://go.microsoft.com.edgekey.net"
"https://e11290.dspg.akamaiedge.net"
"https://discovery.dm.microsoft.com/enrollmentConfiguration/discovery/atp"
"https://us-v20.events.data.microsoft.com/ping"
"https://v10.events.data.microsoft.com"
)

declare -a PKIetc=("http://www.microsoft.com"
"http://crl3.digicert.com"
"http://crl4.digicert.com"
"http://ocsp.digicert.com"
"http://cacerts.digicert.com"
)

echo "** TESTING URLs for Azure Arc **"
for i in ${ArcTargets[@]}; do
  echo -n "Testing $i   ";
#  curl -w ' %{url_effective}\n' $i
  code=$(curl -k -s -o /dev/null --connect-timeout 30 -w "%{http_code}" $i);
  echo $code;
  if [ "$code" = "000" ]; then
    echo "  ^^^^^^^^ Connection to this target failed, and _may_ be problematic ^^^^^^^^"
  fi
#  echo;
done
echo

echo "** TESTING URLs for Azure Monitor Agent **"
for i in ${AMATargets[@]}; do
  echo -n "Testing $i   ";
  code=$(curl -k -s -o /dev/null --connect-timeout 30 -w "%{http_code}" $i);
  echo $code;
  if [ "$code" = "000" ]; then
    echo "  ^^^^^^^^ Connection to this target failed, and _may_ be problematic ^^^^^^^^"
  fi
done
echo

echo "** TESTING URLs for Defender for Endpoint **"
for i in ${MDETargets[@]}; do
  echo -n "Testing $i   ";
  code=$(curl -k -s -o /dev/null --connect-timeout 30 -w "%{http_code}" $i);
  echo $code;
  if [ "$code" = "000" ]; then
    echo "  ^^^^^^^^ Connection to this target failed, and _may_ be problematic ^^^^^^^^"
  fi
done
echo

echo "** TESTING URLs for PKI etc **"
for i in ${PKIetc[@]}; do
  echo -n "Testing $i   ";
  code=$(curl -k -s -o /dev/null --connect-timeout 30 -w "%{http_code}" $i);
  echo $code;
  if [ "$code" = "000" ]; then
    echo "  ^^^^^^^^ Connection to this target failed, and _may_ be problematic ^^^^^^^^"
  fi
done
