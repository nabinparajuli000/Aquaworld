package com.finandscale.controller;

import com.finandscale.dao.ProductDAO;
import com.finandscale.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("") // Map to the root path of the application
public class HomeServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Fetch featured products
        int numberOfFeaturedProducts = 4; // Or get from a config
        List<Product> featuredProducts = productDAO.getFeaturedProducts(numberOfFeaturedProducts);
        req.setAttribute("featuredProducts", featuredProducts);

        // You could fetch other data for the home page here too:
        // - Banners from a database
        // - Special offers

        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}