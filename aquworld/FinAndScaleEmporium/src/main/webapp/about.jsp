<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>About Us - Fin & Scale Emporium</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #0056b3;
            margin-bottom: 30px;
        }

        section {
            margin-bottom: 40px;
        }

        h2 {
            color: #333;
            margin-bottom: 15px;
            border-left: 5px solid #007bff;
            padding-left: 10px;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        ul li {
            margin-bottom: 10px;
            padding-left: 25px;
            position: relative;
        }

        ul li::before {
            content: "✓";
            color: #28a745;
            font-weight: bold;
            position: absolute;
            left: 0;
            top: 0;
        }

        .team-member {
            display: flex;
            align-items: flex-start;
            margin-bottom: 30px;
            border: 1px solid #e0e0e0;
            padding: 15px;
            border-radius: 8px;
            background-color: #fdfdfd;
            transition: box-shadow 0.3s ease;
        }

        .team-member:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .team-photo {
            flex-shrink: 0;
            width: 100px;
            height: 100px;
            background-color: #ccc;
            border-radius: 50%;
            margin-right: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #555;
            font-size: 0.9em;
        }

        .team-details h3 {
            margin: 0 0 5px;
            color: #007bff;
        }

        .team-details p {
            margin: 0;
        }

        @media (max-width: 600px) {
            .team-member {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }

            .team-photo {
                margin: 0 0 15px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="_navbar.jsp" />

    <div class="container">
        <h1>About Fin & Scale Emporium</h1>

        <section>
            <h2>Our Story</h2>
            <p>
                Welcome to Fin & Scale Emporium, your one-stop shop for all things aquatic! Founded in <strong>[Year]</strong>
                by a group of passionate fishkeepers, our mission has always been to provide the highest
                quality fish, plants, and equipment, along with expert advice to help you create and
                maintain the aquarium of your dreams.
            </p>
            <p>
                We believe that fishkeeping is more than just a hobby; it's a way to bring a piece of
                the natural world into your home, offering tranquility and endless fascination.
                Whether you're a seasoned aquarist or just starting out, we're here to support you
                every step of the way.
            </p>
        </section>

        <section>
            <h2>Our Values</h2>
            <ul>
                <li><strong>Quality:</strong> We source only healthy, vibrant livestock and reliable, durable equipment.</li>
                <li><strong>Expertise:</strong> Our team is knowledgeable and always ready to share their passion and advice.</li>
                <li><strong>Community:</strong> We strive to build a supportive community of fellow aquatic enthusiasts.</li>
                <li><strong>Sustainability:</strong> We are committed to responsible sourcing and promoting ethical fishkeeping practices.</li>
            </ul>
        </section>

        <section>
            <h2>Meet Our Team</h2>
            <div class="team-member">
                <%-- Replace with actual image if available --%>
                <div class="team-photo">Photo</div>
                <div class="team-details">
                    <h3>Jane Doe - Founder & Head Ichthyologist</h3>
                    <p>Jane has over 20 years of experience in aquatic biology and is the heart of our livestock selection and care.</p>
                </div>
            </div>
            <div class="team-member">
                <div class="team-photo">Photo</div>
                <div class="team-details">
                    <h3>John Smith - Equipment Specialist</h3>
                    <p>John knows everything about filters, heaters, and lighting. If you have a technical question, he's your guy!</p>
                </div>
            </div>
        </section>
    </div>

    <jsp:include page="_footer.jsp" />
</body>
</html>
