package com.finandscale.controller;

import com.finandscale.dao.ProductDAO;
import com.finandscale.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/product") // e.g., /product?id=1
public class ProductDetailServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null) {
            try {
                int productId = Integer.parseInt(idParam);
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    req.setAttribute("product", product);
                    req.getRequestDispatcher("productDetail.jsp").forward(req, resp);
                } else {
                    // Product not found, send 404 or redirect to error page
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
            }
        } else {
            // No ID provided
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required");
        }
    }
}