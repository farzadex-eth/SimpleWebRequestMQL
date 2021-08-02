//+------------------------------------------------------------------+
// (C) 2021 Farzad Zoghi (f.zoghi@outlook.com) ----------------------+
//+------------------------------------------------------------------+

// Send Web Requests using Windows inet DLL

#property copyright "Copyright 2021, Farzad Zoghi"
#property link      "email:f.zoghi@outlook.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
#define LPDWORD DWORD&
#define DWORD uint
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
#import  "Wininet.dll"
   int InternetOpenW(string, int, string, string, int);
   int InternetConnectW(int, string, int, string, string, int, int, int); 
   int InternetOpenUrlW(int, string, string, int, int, int);
   int InternetReadFile(int, uchar &sBuffer[], int, int& OneInt);
   int InternetCloseHandle(int); 
   int HttpOpenRequestW(int, string, string, string, string, string& AcceptTypes[], int, int);
   int HttpSendRequestW(int hRequest,string &lpszHeaders,int dwHeadersLength,uchar &lpOptional[],int dwOptionalLength);
   bool InternetGetConnectedState(LPDWORD lpdwFlags, DWORD dwReserved);
#import

//+------------------------------------------------------------------+
//| GET Request                                                     |
//+------------------------------------------------------------------+
string getRequest(string url, string params = "", string headers = "", string protocol = "https", int port = 0) {

   string urlSplit[];
   char body[];

   int portNum = (protocol == "https") ? (443) : (80);
   portNum = (0 == port) ? (portNum) : (port);
   
   StringSplit(url, '/', urlSplit);
   string serverName = urlSplit[0];
   string path = StringSubstr(url, StringFind(url, "/")) + "?" + params;
   
   string acceptTypes[1] = {"*/*"};
   
   int HttpOpen = InternetOpenW(NULL, 0, " ", " ", 0);  
   if( HttpOpen <= 0) {
      Alert("Check your Internet Connection and Try Again");
   }  
   int HttpConnect = InternetConnectW(HttpOpen, serverName, portNum, "", "", 3, 0, 0); 
   int HttpRequest = HttpOpenRequestW(HttpConnect, "GET", path, "", "", acceptTypes, 0x00800000, 0);   
   bool result = HttpSendRequestW(HttpRequest, headers, StringLen(headers), body, ArraySize(body)-1);
   
   uchar ch[500];
   string toStr="";
   int dwBytes;
   string response = "";
   while(InternetReadFile(HttpRequest,ch,500,dwBytes))
   {
      if(dwBytes<=0) break;
      toStr += CharArrayToString(ch,0,dwBytes);
   }
   
   response=toStr; 
   
   response=toStr; 
   
   InternetCloseHandle(HttpOpen);
   InternetCloseHandle(HttpRequest);
   
   return response;
}


//+------------------------------------------------------------------+
//| POST Request                                                     |
//+------------------------------------------------------------------+
string postRequest(string url, string data, string headers = "Content-Type: application/x-www-form-urlencoded", string protocol = "https", int port = 0) {

   string urlSplit[];

   int portNum = (protocol == "https") ? (443) : (80);
   portNum = (0 == port) ? (portNum) : (port);
   
   StringSplit(url, '/', urlSplit);
   string serverName = urlSplit[0];
   string path = StringSubstr(url, StringFind(url, "/"));
   
   //---request body
   char body[];
   ArrayResize(body, StringLen(data));
   StringToCharArray(data, body);
   
   string acceptTypes[1] = {"*/*"};
   
   int HttpOpen = InternetOpenW(NULL, 0, " ", " ", 0);  
   if( HttpOpen <= 0) {
      Alert("Check your Internet Connection and Try Again");
   }  
   int HttpConnect = InternetConnectW(HttpOpen, serverName, portNum, "", "", 3, 0, 0); 
   int HttpRequest = HttpOpenRequestW(HttpConnect, "POST", path, "", "", acceptTypes, 0x00800000, 0);   
   bool result = HttpSendRequestW(HttpRequest, headers, StringLen(headers), body, ArraySize(body)-1);
   
   uchar ch[500];
   string toStr="";
   int dwBytes;
   string response = "";
   while(InternetReadFile(HttpRequest,ch,500,dwBytes))
   {
      if(dwBytes<=0) break;
      toStr += CharArrayToString(ch,0,dwBytes);
   }
   
   response=toStr; 
   
   response=toStr; 
   
   InternetCloseHandle(HttpOpen);
   InternetCloseHandle(HttpRequest);
   
   return response;
}