//+------------------------------------------------------------------+
//|                                                   testwebreq.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Farzad Zoghi"
#property link      "email:f.zoghi@outlook.com"
#property version   "1.00"
#property strict

#include <webrequest.mqh>
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {

//GET METHOD
   Alert(getRequest("jsonplaceholder.typicode.com/posts/1"));

//POST METHOD
   string data = "userId=1&title=test&body=helloworld";
   string headers = "Content-Type: application/x-www-form-urlencoded";
   Alert(postRequest("jsonplaceholder.typicode.com/posts", data, headers, "https"));

  }
//+------------------------------------------------------------------+
