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
		// Jsoup�� �̿��ؼ� http://www.cgv.co.kr/movies/ ũ�Ѹ�
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		//URL�� �±����� �޾ƿ���
String url = request.getParameter("url");
String tag = request.getParameter("tag");

		out.println(tag);
        // �Ľ��� ����Ʈ�� �����ش�(�ش� ����Ʈ�� ���� �±׸� �� �ܾ��)
 	Document doc2 = Jsoup.connect("http://www.playdb.co.kr/magazine/magazine_temp.asp?Page=1&kindno=2&sReqList=&stext=&sort=1").get();
        //System.out.println(doc2.data());

        //System.out.println(doc2.body());

        

        // list �Ӽ��ȿ� li ��� �����͵��� �ܾ�´�

        Elements posts = doc2.body().getElementsByClass("list");

        //System.out.println(doc2.getElementsByClass("list"));

        Elements file = posts.select("li");

        // System.out.println(posts.select("li"));

        

        // li ��� �����͵� �ݺ������� ����(li ��� ���������� ��, li������ŭ �ݺ���)

        // select() : select()�� ���� �� �������� �����Ϳ� ����

        // �������.text() : ������� ���� ��ȯ(�±״� ���Ե��� ����)

        // �������.attr("�Ӽ��̸�") : ������ҿ� "�Ӽ��̸�"�� ���� ���� ��ȯ

        for(Element e : file){

        	System.out.println("Title : " + e.select(".tit a").text());

        	System.out.println("Link : " + e.select(".tit a").attr("href"));

                // ����Ʈ ��ũ�� �̻��ϰ� �ö��ִ� ����� ���ڿ��� �ٵ��� �Ѵ�

                // substring�� ����� ���ϴ� ���ڿ���ŭ �ڸ��� �տ� �ּҺκ��� �ٿ��ָ� ��

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
