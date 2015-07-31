 <%@ page language="java" contentType="image/jpeg" pageEncoding="UTF-8"
     import="java.io.*,
          java.util.*,
          com.sun.image.codec.jpeg.*,
          java.awt.*,
          java.awt.image.*,
          com.swetake.util.Qrcode"
%>


<%@ page  import="java.io.*,
          java.util.*,
          com.sun.image.codec.jpeg.*,
          java.awt.*,
          java.awt.image.*,
          com.swetake.util.Qrcode"
%>
  <div class="">
<%
	try
	{
		//String content =request.getRequestURL().toString();
		//String content =  request.getHeader("Referer");
		String content = "http://baidu.com";
		Qrcode handler = new Qrcode();
		handler.setQrcodeErrorCorrect('M');
		handler.setQrcodeEncodeMode('B');
		handler.setQrcodeVersion(7);
		byte[] contentBytes = content.getBytes("UTF-8");
		
		BufferedImage bufImg = new BufferedImage(141, 141, BufferedImage.TYPE_INT_RGB);
		Graphics2D gs = bufImg.createGraphics();
		
		gs.setBackground(Color.WHITE);
		gs.clearRect(0, 0, 200, 200);
		
		//设定图像颜色：BLACK  
		gs.setColor(Color.BLACK);
		
		//设置偏移量  不设置肯能导致解析出错  
		int pixoff = 2;
		//输出内容：二维码  
		if (contentBytes.length > 0 && contentBytes.length < 124)
		{
			boolean[][] codeOut = handler.calQrcode(contentBytes);
			for (int i2 = 0; i2 < codeOut.length; i2++)
			{
				for (int j = 0; j < codeOut.length; j++)
				{
					if (codeOut[j][i2])
					{
						gs.fillRect(j * 3 + pixoff, i2 * 3 + pixoff, 3, 3);
					}
				}
			}
		}
		gs.dispose();
		bufImg.flush();
		OutputStream toClient = response.getOutputStream();
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(toClient);
		encoder.encode(bufImg);
		toClient.close();
		out.clear();
		out = pageContext.pushBody();
		
	}
	catch (Exception e)
	{
		e.printStackTrace();
	}
%></div>
      
