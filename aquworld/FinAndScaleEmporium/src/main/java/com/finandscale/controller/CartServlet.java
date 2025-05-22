package com.finandscale.controller;

import com.finandscale.dao.ProductDAO;
import com.finandscale.model.Cart;
import com.finandscale.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cart/*") // Using path info for actions like /cart/add, /cart/remove
public class CartServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // For simply viewing the cart
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = req.getPathInfo(); // Gets the part after /cart, e.g., /add
        if (action == null) {
            action = "/view"; // Default action if none specified
        }

        try {
            switch (action) {
                case "/add":
                    handleAdd(req, cart);
                    resp.sendRedirect(req.getContextPath() + "/cart.jsp"); // Redirect to cart page
                    // Or redirect back to product page: resp.sendRedirect(req.getHeader("Referer"));
                    break;
                case "/update":
                    handleUpdate(req, cart);
                    resp.sendRedirect(req.getContextPath() + "/cart.jsp");
                    break;
                case "/remove":
                    handleRemove(req, cart);
                    resp.sendRedirect(req.getContextPath() + "/cart.jsp");
                    break;
                default:
                    req.getRequestDispatcher("/cart.jsp").forward(req, resp);
            }
        } catch (NumberFormatException e) {
            // Handle invalid ID or quantity format
            req.setAttribute("cartError", "Invalid input for cart operation.");
            req.getRequestDispatcher("/cart.jsp").forward(req, resp);
        }
    }

    private void handleAdd(HttpServletRequest req, Cart cart) {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        Product product = productDAO.getProductById(productId);
        if (product != null && product.getStockQuantity() >= quantity) {
            cart.addItem(product, quantity);
            // Optionally, set a success message
            // req.getSession().setAttribute("cartMessage", product.getName() + " added to cart!");
        } else if (product != null && product.getStockQuantity() < quantity) {
             req.getSession().setAttribute("cartError", "Not enough stock for " + product.getName());
        }
        else {
            // Product not found or other error
            req.getSession().setAttribute("cartError", "Could not add product to cart.");
        }
    }

    private void handleUpdate(HttpServletRequest req, Cart cart) {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        cart.updateItemQuantity(productId, quantity);
    }

    private void handleRemove(HttpServletRequest req, Cart cart) {
        int productId = Integer.parseInt(req.getParameter("productId"));
        cart.removeItem(productId);
    }
}