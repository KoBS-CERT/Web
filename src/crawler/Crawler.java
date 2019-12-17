package crawler;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Iterator;
import java.io.PrintWriter;
import org.apache.catalina.connector.Response;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
/**
 * Servlet implementation class Crawler
 */

@WebServlet("/Crawler")
public class Crawler extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Crawler() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		// Jsoup를 이용해서 http://www.cgv.co.kr/movies/ 크롤링
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		//URL과 태그정보 받아오기
String url = request.getParameter("url");
String tag = request.getParameter("tag");

		out.println(tag);
        // 파싱할 사이트를 적어준다(해당 사이트에 대한 태그를 다 긁어옴)
 	Document doc2 = Jsoup.connect("http://www.playdb.co.kr/magazine/magazine_temp.asp?Page=1&kindno=2&sReqList=&stext=&sort=1").get();
        //System.out.println(doc2.data());

        //System.out.println(doc2.body());

        

        // list 속성안에 li 요소 데이터들을 긁어온다

        Elements posts = doc2.body().getElementsByClass("list");

        //System.out.println(doc2.getElementsByClass("list"));

        Elements file = posts.select("li");

        // System.out.println(posts.select("li"));

        

        // li 요소 데이터들 반복적으로 츨력(li 요소 끝날때까지 즉, li개수만큼 반복문)

        // select() : select()를 통해 더 구석구석 데이터에 접근

        // 구성요소.text() : 구성요소 값을 반환(태그는 포함되지 않음)

        // 구성요소.attr("속성이름") : 구성요소에 "속성이름"에 대한 값을 반환

        for(Element e : file){

        	System.out.println("Title : " + e.select(".tit a").text());

        	System.out.println("Link : " + e.select(".tit a").attr("href"));

                // 사이트 링크가 이상하게 올라가있는 관계로 문자열을 다듬어야 한다

                // substring을 사용해 원하는 문자열만큼 자르고 앞에 주소부분을 붙여주면 끝

               // System.out.println("Link : http://www.playdb.co.kr/magazine/" + e.select(".tit a").attr("href").substring(2, 70));

        	System.out.println("Image : " + e.select(".thumb img").attr("src"));

        	System.out.println("text : " + e.select(".txt").text());

        	System.out.println(" ");

        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
