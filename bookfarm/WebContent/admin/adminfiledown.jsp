<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	AdminVO adminVO = (AdminVO)session.getAttribute("adminVO");
	String fileName = request.getParameter("file_name");
	String savePath = "boardUpload";
	
	String sDownloadPath = application.getRealPath(savePath);
	String sFilePath = sDownloadPath + "\\" + fileName;
	byte b[] = new byte[4096];
	FileInputStream in = new FileInputStream(sFilePath);
	String sMimeType = getServletContext().getMimeType(sFilePath);
	System.out.println("sMimeType>>>" + sMimeType);
	
	if (sMimeType == null)
		sMimeType = "application/octet-stream";
	
	response.setContentType(sMimeType);
	String agent = request.getHeader("User-Agent");
	
	boolean ieBrowser = (agent.indexOf("MSIE") > -1) || (agent.indexOf("Trident") > -1);
	
	if (ieBrowser) {
		fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
	} else {
		fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
	}
	
	response.setHeader("Content-Disposition", "attachment; filename= " + fileName);
	
	//IllegalStateException
	out.clear();
	out=pageContext.pushBody();	
	
	
	ServletOutputStream out2 = response.getOutputStream();
	int numRead;
	
	while ((numRead = in.read(b, 0, b.length)) != -1) {
		out2.write(b, 0, numRead);
	}
	out2.flush();
	out2.close();
	in.close();
%>
