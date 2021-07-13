package control;

import java.io.File;
import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.DAO;
import entity.Product;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024
		* 100)
@WebServlet("/Add")
public class Add extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	public Add() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Integer id = 0;
		String name = "";
		Integer price = 0;
		String image = "";
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
				for (FileItem item : items) {
					if (item.isFormField()) {
						// Process regular form field (input type="text|radio|checkbox|etc", select,
						// etc).
						if (item.getFieldName().equalsIgnoreCase("id")) {
							id = Integer.parseInt(item.getString());
						}
						if (item.getFieldName().equalsIgnoreCase("name")) {
							name = item.getString();
						}
						if (item.getFieldName().equalsIgnoreCase("price")) {
							price = Integer.parseInt(item.getString());
						}
						
						
					} else {
						// Process form file field (input type="file").
						String fname = new File(item.getName()).getName();
						image = fname;
						String ima = getServletContext().getRealPath("/") + "images\\" + fname;
						File savedFile = new File(ima);
						item.write(savedFile);
						

					}
				}
			} catch (FileUploadException e) {
				throw new ServletException("Cannot parse multipart request.", e);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}

		Product p = new Product(id, name, price, image);
		DAO pdao = new DAO();
		try {
			if (pdao.addProduct(p)) {
				// request.getRequestDispatcher("/home.jsp").forward(request, response);
				response.sendRedirect("home.jsp");
			} else {
				response.sendRedirect("error.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
