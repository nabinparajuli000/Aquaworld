<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Contact Us - Fin & Scale Emporium</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; color: #333; }
        .container { width: 80%; max-width:900px; margin: 20px auto; background-color: #fff; padding: 20px; box-shadow: 0 0 10px rgba(0,0,0,0.1); border-radius: 8px;}
        h1, h2 { color: #333; text-align: center; margin-bottom: 20px;}
        .contact-flex-container { display: flex; flex-wrap: wrap; gap: 30px; }
        .contact-form-section { flex: 2; min-width: 300px; }
        .contact-info-section { flex: 1; min-width: 250px; background-color: #f9f9f9; padding: 20px; border-radius: 5px; }

        .contact-form div { margin-bottom: 15px; }
        .contact-form label { display: block; margin-bottom: 5px; font-weight: bold; }
        .contact-form input[type="text"],
        .contact-form input[type="email"],
        .contact-form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* Makes padding and border part of the element's total width and height */
        }
        .contact-form textarea { height: 150px; resize: vertical; }
        .contact-form button {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .contact-form button:hover { background-color: #0056b3; }

        .contact-info-section p { margin-bottom: 12px; line-height: 1.6; }
        .contact-info-section strong { color: #555; }

        /* Message Styling (for form submission feedback) */
        .message {
            padding: 10px 15px;
            margin: 0 auto 20px auto; /* Centered message */
            max-width: 560px; /* Match form width approx */
            border-radius: 4px;
            text-align: center;
            border: 1px solid transparent;
        }
        .message.success { background-color: #d4edda; color: #155724; border-color: #c3e6cb; }
        .message.error   { background-color: #f8d7da; color: #721c24; border-color: #f5c6cb; }
    </style>
</head>
<body>
    <jsp:include page="_navbar.jsp" /> <%-- Assumes _navbar.jsp handles toast display for flash messages --%>

    <div class="container">
        <h1>Contact Us</h1>

        <%-- Display inline message if set by servlet after form submission (forward) --%>
        <c:if test="${not empty requestScope.formMessage}">
            <p class="message ${requestScope.formStatus == 'success' ? 'success' : 'error'}">
                <c:out value="${requestScope.formMessage}"/>
            </p>
        </c:if>

        <div class="contact-flex-container">
            <div class="contact-form-section">
                <h2>Send Us a Message</h2>
                <form class="contact-form" action="${pageContext.request.contextPath}/contact" method="post">
                    <div>
                        <label for="name">Your Name:</label>
                        <input type="text" id="name" name="name" value="<c:out value='${param.name}'/>" required>
                    </div>
                    <div>
                        <label for="email">Your Email:</label>
                        <input type="email" id="email" name="email" value="<c:out value='${param.email}'/>" required>
                    </div>
                    <div>
                        <label for="subject">Subject:</label>
                        <input type="text" id="subject" name="subject" value="<c:out value='${param.subject}'/>" required>
                    </div>
                    <div>
                        <label for="message">Message:</label>
                        <textarea id="message" name="message" required><c:out value='${param.message}'/></textarea>
                    </div>
                    <div>
                        <button type="submit">Send Message</button>
                    </div>
                </form>
            </div>

            <div class="contact-info-section">
                <h2>Our Contact Information</h2>
                <p><strong>Address:</strong><br>123 Aquarium Lane,<br>Fishville, FS 54321</p>
                <p><strong>Phone:</strong><br>(555) 123-4567</p>
                <p><strong>Email:</strong><br><a href="mailto:info@finandscale.com">info@finandscale.com</a></p>
                <p><strong>Store Hours:</strong><br>
                    Monday - Saturday: 10 AM - 7 PM<br>
                    Sunday: 12 PM - 5 PM
                </p>
            </div>
        </div>
    </div>

    <jsp:include page="_footer.jsp" />
</body>
</html>