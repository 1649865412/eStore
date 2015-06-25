<%
	//Nochex Response Page 
	//CreateTime:2006-07-25
%>
<%@page import="java.util.*,java.io.*,java.net.*,javax.net.ssl.*" 
	contentType="text/html; charset=UTF-8" 
	errorPage="/error.jsp"
%>
<%
	String mode=request.getParameter("mode");
	
	//response to current page when come back from paymentgateway,and
	//send the data here from nochex payment gateway.
	if(mode.equalsIgnoreCase("responder")){ 		
		Map paramMap=request.getParameterMap();
		StringBuilder sb=new StringBuilder();
		Iterator i=paramMap.entrySet().iterator();

		if(i.hasNext()){
			Map.Entry en=(Map.Entry)i.next();
			sb.append(en.getKey()+"="+((String[])en.getValue())[0]);
		}
		while(i.hasNext()){
			Map.Entry en=(Map.Entry)i.next();
			sb.append("&" + en.getKey()+"="+((String[])en.getValue())[0]);
		}
		
		String responseText=getResponseFromHttpsUrl("https://www.nochex.com:443/nochex.dll/apc/apc",sb.toString());
		if(responseText.equalsIgnoreCase("AUTHORISED")){//authorised by NOCHEX server (APC system) 
			//TODO update the order system
			
		}else{//Rejected by NOCHEX server (APC system)
			
		}
	}else if(mode.equalsIgnoreCase("complete")){

	}else{

	}
%>
<%!	
	 public String getResponseFromHttpsUrl(String httpsUrl,String params){
        HttpsURLConnection conn=null;
        StringBuffer sb = new StringBuffer();
        try{
            URL url = new URL(httpsUrl);
            conn = (HttpsURLConnection) url.openConnection();
            
			//String dataTemp="amount=0.33&transaction_date=25/07/2006 08:10:20&to_email=test1@nochex.com&mode=responder&status=test&custom=&order_id=034&security_key=L4238681175280-96628915&from_email=man1900@126.com&transaction_id=32308&orderNo=034";
			
			conn.setRequestMethod("POST");            
            conn.setDoInput(true); 
            conn.setDoOutput(true); 
            //request paramters
            OutputStream out = conn.getOutputStream();
            out.write(params.getBytes());
            out.flush();
            
            InputStream in = conn.getInputStream();
            
            BufferedReader reader = new BufferedReader(new InputStreamReader(in));
            
            String line=reader.readLine();
			while(line!=null){ 
				sb.append(line);
				line=reader.readLine();
			} 
        }catch (MalformedURLException e){
            System.out.println("HTTPS_URL  MalformedURLException:" + e);
        }catch (IOException e) {
            System.out.println("HTTPS_URL  IOException:" + e);
        }
        finally{
          if(conn!=null)conn.disconnect(); 
        }
        //System.out.println("content:[" + sb.toString() + "]");
        return sb.toString();
    }
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>