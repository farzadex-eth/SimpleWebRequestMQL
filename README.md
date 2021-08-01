# SimpleWebRequestMQL
Simple GET/POST Requests for MQL4 using wininet

*No need to add the URLs in MetaTrader 4 settings*

## Usage
* Copy the mqh file to "MetaTrader4 DataFolder/MQL4/Include/"
* *(Optional)* Copy the example script file to "MetaTrader4 DataFolder/MQL4/Script/"

## GET Method
```string getRequest(string url, string headers = "", string protocol = "https", int port = 0)```
* Type the url without "https://" or "http://" and you can specify the protocol in the input parameters (default is https)
* If you leave the port number as 0, it will use port 443 for https and 80 for http
* You can also specify the headers

## POST Method
```string postRequest(string url, string data, string headers = "Content-Type: application/x-www-form-urlencoded", string protocol = "https", int port = 0)```
* Type the url without "https://" or "http://" and you can specify the protocol in the input parameters (default is https)
* If you leave the port number as 0, it will use port 443 for https and 80 for http
* default header if "Content-Type: application/x-www-form-urlencoded", you can change it based on your data string or other circumstances
* data must be a string. If you want to send json data, you have to serialize it as a string.

## Response
* Responses are string and you can parse it. 
* This is a really good and complete json parser if you need it : https://github.com/femtotrader/rabbit4mt4/blob/master/emit/MQL4/Include/json.mqh

