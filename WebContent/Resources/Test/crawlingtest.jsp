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
String url = "http://www.seoultech.ac.kr/service/info/notice/";
String tag = "tr";
HashMap<String,String> map = new HashMap<String,String>();
map.put("url",url);
map.put("tag",tag);
String domain=getDomainName(map.get("url"));

%>
  	url : :<%=map.get("url")%><br>

	  tag ::<%=map.get("tag")%><br>
	  
	  
	  Domain: :<%=getDomainName(map.get("url")) %><br>
	 
<%
		
        // 파싱할 사이트를 적어준다(해당 사이트에 대한 태그를 다 긁어옴)
 		Document doc2 = Jsoup.connect(map.get("url")).get();
		
        //System.out.println(doc2.data());

      //  System.out.println(doc2.body());

        

        // list 속성안에 li 요소 데이터들을 긁어온다

        Elements posts = doc2.body().getElementsByClass(map.get("tag"));


        //System.out.println(doc2.getElementsByClass("list"));

        Elements file = posts.select(map.get("tag2"));
		
        // System.out.println(posts.select("li"));
        

        // li 요소 데이터들 반복적으로 츨력(li 요소 끝날때까지 즉, li개수만큼 반복문)

        // select() : select()를 통해 더 구석구석 데이터에 접근

        // 구성요소.text() : 구성요소 값을 반환(태그는 포함되지 않음)

        // 구성요소.attr("속성이름") : 구성요소에 "속성이름"에 대한 값을 반환
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

       		//out.println("relative address:"+e.select("a").attr("href")+"<br>"); //상대주소
       		//out.println("relative address:"+cc+"<br>"); //상대주소
        	bb=e.select("a").attr("abs:href"); //절대주소
        	String aa;
       		//out.println(e.html()+"<br>");
        	aa=e.select("a").attr("href").replaceAll(";","&");
        	//System.out.println("HEY!"+aa);
        	aa=e.html().replace(aa,e.select("a").attr("abs:href"));
        	//aa=e.html().replace(e.select("a").attr("href"),e.select("a").attr("abs:href"));
        	out.println(aa+"<br>");

        	//out.println(aa);
        	//System.out.println(aa);
        	//out.println("Title : " + e.html().replace(e.select("a").attr("href"),e.select("a").attr("abs:href"))+"<br>");
        	//out.println("test: "+e.html().replace("a href=\"*\"", "a href="+e.attr("abs:href"))+"<br>");
        	//out.println("Title : " + e.html().replace(e.select("a[href]").attr("href"), e.select("a").attr("abs:href"))+"<br>");

        	//out.println("Link : " + e.select(".tit a").attr("href"));

                // 사이트 링크가 이상하게 올라가있는 관계로 문자열을 다듬어야 한다

                // substring을 사용해 원하는 문자열만큼 자르고 앞에 주소부분을 붙여주면 끝

               // System.out.println("Link : http://www.playdb.co.kr/magazine/" + e.select(".tit a").attr("href").substring(2, 70));

        	//out.println("Image : " + e.select(".thumb img").attr("src"));

        	//out.println("text : " + e.select(".txt").text());

        	System.out.println();

        }

%>
</body>

</html>