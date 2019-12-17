<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  JSP에서 jsoup을 사용하기 위해 import -->
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>


<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
<%!
public static String getDomainName(String url) throws MalformedURLException{
    if(!url.startsWith("http") && !url.startsWith("https")){
         url = "http://" + url;
    }        
    URL netUrl = new URL(url);
    String host = netUrl.getHost();
    if(host.startsWith("www")){
        host = host.substring("www".length()+1);
    }
    return host;
}%>

<%


		//URL과 태그정보 받아오기
String url = request.getParameter("url");
String tag = request.getParameter("tag");
String tag2 = request.getParameter("tag2");
HashMap<String,String> map = new HashMap<String,String>();
map.put("url",url);
map.put("tag",tag);
map.put("tag2",tag2);
String domain=getDomainName(map.get("url"));

%>
  	url : :<%=map.get("url")%><br>

	  tag ::<%=map.get("tag")%><br>
	  
	  tag2 ::<%=map.get("tag2") %><br>
	  
	  Domain: :<%=getDomainName(map.get("url")) %><br>
	 
<%
		
        // 파싱할 사이트를 적어준다(해당 사이트에 대한 태그를 다 긁어옴)
 		Document doc2 = Jsoup.connect(map.get("url")).get();

        String tag_tag=map.get("tag");
		Elements posts = doc2.select(tag_tag);


        Elements file = posts.select(map.get("tag2"));

		String bb;
        Elements select = file.select("a");
        for(Element e : select){
        	String absUrl = e.absUrl("href");
        	e.attr("href",absUrl);
        }
        select = file.select("img");
        for (Element e : select){
            e.attr("src", e.absUrl("src"));
        }
        for(Element e : file){

        	bb=e.select("a").attr("abs:href"); //절대주소
        	String aa;
        	aa=e.select("a").attr("href").replaceAll(";","&");
        	aa=e.outerHtml().replace(aa,e.select("a").attr("abs:href"));
        	out.println(aa+"<br>");
	       	System.out.println();

        }

%>
</body>

</html>