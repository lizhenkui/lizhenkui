#/bin/bash
echo "汕头常规接口拨测"
url="https://st-ztn-data.gdgov.cn:443"
path="/GatewayMsg/http/api/proxy/invoke"
passid="C90-44000695"
token="0e52522e5fb1489f88a8a5f724db3795"
serviceid="C1629767174867"
nonce="$RANDOM"
echo nonce:$nonce
currentTime=`date "+%Y-%m-%d %H:%M:%S"`
currentTimestap=`date -d "$currentTime" +%s`
echo currentTimestap=$currentTimestap
sign="$currentTimestap$token$nonce$currentTimestap"
signsha=`echo -n "$sign"|sha256sum|awk '{print toupper($1)}'`
echo signsha=$signsha
#echo "currentTime:$currentTime,currentTimestap:$currentTimestap"
#echo "sign:$sign,signsha:$signsha"
curl -i -w "状态码：%{http_code} 响应时间(s):%{time_total}" "$url$path" -H "Content-Type:application/json" -H "x-tif-timestamp:$currentTimestap" -H "x-tif-paasid:$passid"  -H "x-tif-nonce:$nonce" -H "x-tif-serviceId:$serviceid"  -H "x-tif-signature:$signsha" -X POST -d'{
    "system_id": "C90-44000695",
    "vender_id": "11440500553696992R",
    "department_id": "911101027393543171",
    "query_timestamp": "1",
    "UID": "12345678",
    "query": {
        "XMZJ": "efdadd644d270f99ac9031c4a8b335c2",
        "SJDWDM": "91440507192781592B"
    },
    "audit_info": {
        "operator_id": "X",
        "operator_name": "X",
        "query_object_id": "无",
        "query_object_id_type": "无",
        "item_id": "无",
        "item_code": "无",
        "terminal_info": "172.26.142.20",
        "query_timestamp": "1"
    }
}'
echo ""

