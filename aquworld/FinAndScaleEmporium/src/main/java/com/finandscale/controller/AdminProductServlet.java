package com.finandscale.controller;

import com.finandscale.dao.ProductDAO;
import com.finandscale.model.Product;
import com.finandscale.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/products/*")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,                // 10MB
        maxRequestSize = 1024 * 1024 * 50)             // 50MB
public class AdminProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private static final String UPLOAD_DIRECTORY = "images";

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
                !"admin".equals(((User) session.getAttribute("user")).getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getPathInfo();
        if (action == null || action.equals("/")) {
            List<Product> products = productDAO.getAllProducts();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/admin/manageProducts.jsp").forward(req, resp);
        } else if (action.equals("/add")) {
            req.getRequestDispatcher("/admin/addProduct.jsp").forward(req, resp);
        } else if (action.equals("/edit")) {
            String idParam = req.getParameter("id");
            if (idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    Product product = productDAO.getProductById(id);
                    if (product != null) {
                        req.setAttribute("product", product);
                        req.getRequestDispatcher("/admin/editProduct.jsp").forward(req, resp);
                        return;
                    }
                } catch (NumberFormatException e) {
                    req.setAttribute("error", "Invalid product ID.");
                }
            }
            req.setAttribute("message", "Product not found.");
            List<Product> products = productDAO.getAllProducts();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/admin/manageProducts.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
                !"admin".equals(((User) session.getAttribute("user")).getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getPathInfo();
        if (action != null) {
            switch (action) {
                case "/add":
                    handleAddProduct(req, resp);
                    break;
                case "/edit":
                    handleEditProduct(req, resp);
                    break;
                case "/delete":
                    handleDeleteProduct(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
            }
        }
    }

    private void handleAddProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            BigDecimal price = new BigDecimal(req.getParameter("price"));
            String category = req.getParameter("category");
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            Part filePart = req.getPart("imageFile");
            String imageUrl = handleImageUpload(filePart);

            Product newProduct = new Product();
            newProduct.setName(name);
            newProduct.setDescription(description);
            newProduct.setPrice(price);
            newProduct.setCategory(category);
            newProduct.setQuantity(quantity);
            newProduct.setImageUrl(imageUrl);

            if (productDAO.addProduct(newProduct)) {
                req.getSession().setAttribute("flashMessage", "Product '" + newProduct.getName() + "' added successfully!");
                req.getSession().setAttribute("flashMessageType", "success");
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            } else {
                req.setAttribute("error", "Failed to add product.");
                req.getRequestDispatcher("/admin/addProduct.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("/admin/addProduct.jsp").forward(req, resp);
        }
    }

    private void handleEditProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            BigDecimal price = new BigDecimal(req.getParameter("price"));
            String category = req.getParameter("category");
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            Product existingProduct = productDAO.getProductById(id);
            if (existingProduct == null) {
                req.setAttribute("error", "Product not found.");
                req.getRequestDispatcher("/admin/manageProducts.jsp").forward(req, resp);
                return;
            }

            Part filePart = req.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String imageUrl = handleImageUpload(filePart);
                existingProduct.setImageUrl(imageUrl);
            }

            existingProduct.setName(name);
            existingProduct.setDescription(description);
            existingProduct.setPrice(price);
            existingProduct.setCategory(category);
            existingProduct.setQuantity(quantity);

            if (productDAO.updateProduct(existingProduct)) {
                req.getSession().setAttribute("flashMessage", "Product updated successfully!");
                req.getSession().setAttribute("flashMessageType", "success");
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            } else {
                req.setAttribute("error", "Failed to update product.");
                req.setAttribute("product", existingProduct);
                req.getRequestDispatcher("/admin/editProduct.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("/admin/editProduct.jsp").forward(req, resp);
        }
    }

    private void handleDeleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                if (productDAO.deleteProduct(id)) {
                    req.getSession().setAttribute("flashMessage", "Product deleted successfully!");
                    req.getSession().setAttribute("flashMessageType", "success");
                } else {
                    req.getSession().setAttribute("flashMessage", "Failed to delete product.");
                    req.getSession().setAttribute("flashMessageType", "error");
                }
            } catch (NumberFormatException e) {
                req.getSession().setAttribute("flashMessage", "Invalid product ID.");
                req.getSession().setAttribute("flashMessageType", "error");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private String handleImageUpload(Part filePart) throws IOException {
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String extension = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".")) : "";
            String uniqueFileName = UUID.randomUUID().toString() + extension;

            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            filePart.write(uploadPath + File.separator + uniqueFileName);
            return UPLOAD_DIRECTORY + "/" + uniqueFileName;
        }
        return null;
    }
}
