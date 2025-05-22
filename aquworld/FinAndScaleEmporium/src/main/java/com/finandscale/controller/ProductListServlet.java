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

@WebServlet("/shop") // Or /products
public class ProductListServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

   
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get filter parameters from request
        String category = req.getParameter("category");
        String searchTerm = req.getParameter("searchTerm");
        String sortBy = req.getParameter("sortBy"); // For future use
        String priceMin = req.getParameter("priceMin"); // For future use
        String priceMax = req.getParameter("priceMax"); // For future use

        // Fetch products based on filters
        // List<Product> products = productDAO.getAllProducts(); // Old way
        List<Product> products = productDAO.getFilteredProducts(category, searchTerm, sortBy, priceMin, priceMax);
        List<String> categories = productDAO.getDistinctCategories(); // For the filter dropdown

        req.setAttribute("products", products);
        req.setAttribute("categories", categories);

        // Set current filter values back to the request to pre-fill the form
        req.setAttribute("selectedCategory", category);
        req.setAttribute("currentSearchTerm", searchTerm);
        req.setAttribute("selectedSortBy", sortBy);
        req.setAttribute("currentPriceMin", priceMin);
        req.setAttribute("currentPriceMax", priceMax);


        req.getRequestDispatcher("products.jsp").forward(req, resp);
    }
}