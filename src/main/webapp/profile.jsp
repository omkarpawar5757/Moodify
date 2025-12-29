<%@ page contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Futuristic Design</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #0a0e27;
            font-family: 'Segoe UI', sans-serif;
            overflow-x: hidden;
            position: relative;
            min-height: 100vh;
        }

        /* Animated Background */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            overflow: hidden;
        }

        .particle {
            position: absolute;
            background: radial-gradient(circle, rgba(100, 200, 255, 0.8), transparent);
            border-radius: 50%;
            animation: float-particle 20s infinite ease-in-out;
        }

        .particle:nth-child(1) { width: 80px; height: 80px; top: 10%; left: 20%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 60px; height: 60px; top: 60%; left: 80%; animation-delay: 3s; }
        .particle:nth-child(3) { width: 100px; height: 100px; top: 80%; left: 10%; animation-delay: 6s; }
        .particle:nth-child(4) { width: 50px; height: 50px; top: 30%; left: 70%; animation-delay: 9s; }
        .particle:nth-child(5) { width: 70px; height: 70px; top: 50%; left: 40%; animation-delay: 12s; }

        @keyframes float-particle {
            0%, 100% { transform: translate(0, 0) scale(1); opacity: 0.3; }
            25% { transform: translate(50px, -50px) scale(1.2); opacity: 0.6; }
            50% { transform: translate(-30px, 30px) scale(0.8); opacity: 0.4; }
            75% { transform: translate(40px, 60px) scale(1.1); opacity: 0.5; }
        }

        /* Main Container */
        .profile-wrapper {
            position: relative;
            z-index: 1;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .profile-container {
            max-width: 1100px;
            width: 100%;
            perspective: 1000px;
        }

        /* Glass Morphism Card */
        .profile-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 30px;
            padding: 0;
            position: relative;
            overflow: hidden;
            animation: card-entrance 1s ease-out;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        @keyframes card-entrance {
            from {
                opacity: 0;
                transform: rotateY(-20deg) translateY(50px);
            }
            to {
                opacity: 1;
                transform: rotateY(0) translateY(0);
            }
        }

        /* Holographic Border Effect */
        .profile-card::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #00f5ff, #ff00ff, #00ff00, #ffff00);
            border-radius: 30px;
            z-index: -1;
            opacity: 0;
            animation: holographic 3s linear infinite;
            transition: opacity 0.3s;
        }

        .profile-card:hover::before {
            opacity: 0.6;
        }

        @keyframes holographic {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Profile Header Section */
        .profile-header {
            background: linear-gradient(135deg, rgba(0, 245, 255, 0.2), rgba(255, 0, 255, 0.2));
            padding: 60px 40px;
            position: relative;
            overflow: hidden;
        }

        .header-glow {
            position: absolute;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(0, 245, 255, 0.3), transparent);
            border-radius: 50%;
            top: -150px;
            right: -150px;
            animation: glow-pulse 4s ease-in-out infinite;
        }

        @keyframes glow-pulse {
            0%, 100% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.3); opacity: 0.8; }
        }

        /* Profile Image with Hexagon Shape */
        .profile-image-section {
            display: flex;
            justify-content: center;
            margin-top: -80px;
            position: relative;
            z-index: 2;
        }

        .hexagon-wrapper {
            width: 200px;
            height: 200px;
            position: relative;
            animation: hexagon-spin 20s linear infinite;
        }

        @keyframes hexagon-spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .hexagon {
            width: 100%;
            height: 100%;
            clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
            background: linear-gradient(135deg, #00f5ff, #ff00ff);
            padding: 5px;
            animation: hexagon-glow 2s ease-in-out infinite alternate;
        }

        @keyframes hexagon-glow {
            from { filter: drop-shadow(0 0 10px rgba(0, 245, 255, 0.5)); }
            to { filter: drop-shadow(0 0 30px rgba(255, 0, 255, 0.8)); }
        }

        .hexagon-inner {
            width: 100%;
            height: 100%;
            clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
            background: #0a0e27;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            animation: counter-spin 20s linear infinite;
        }

        @keyframes counter-spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(-360deg); }
        }

        .profile-img {
            width: 180px;
            height: 180px;
            object-fit: cover;
            clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
        }

        /* Profile Info Section */
        .profile-body {
            padding: 40px;
            position: relative;
        }

        .profile-title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(90deg, #00f5ff, #ff00ff, #00ff00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
            animation: title-appear 0.8s ease-out 0.5s both;
        }

        @keyframes title-appear {
            from {
                opacity: 0;
                letter-spacing: 10px;
            }
            to {
                opacity: 1;
                letter-spacing: 2px;
            }
        }

        .profile-subtitle {
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 40px;
            animation: fade-in 0.8s ease-out 0.7s both;
        }

        @keyframes fade-in {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Neon Info Cards */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .neon-card {
            background: rgba(255, 255, 255, 0.03);
            border: 2px solid rgba(0, 245, 255, 0.3);
            border-radius: 20px;
            padding: 30px;
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
            animation: card-slide-in 0.6s ease-out both;
        }

        .neon-card:nth-child(1) { animation-delay: 0.9s; }
        .neon-card:nth-child(2) { animation-delay: 1.1s; }

        @keyframes card-slide-in {
            from {
                opacity: 0;
                transform: translateX(-50px) rotateY(-10deg);
            }
            to {
                opacity: 1;
                transform: translateX(0) rotateY(0);
            }
        }

        .neon-card:hover {
            transform: translateY(-10px);
            border-color: rgba(0, 245, 255, 0.8);
            box-shadow: 0 0 30px rgba(0, 245, 255, 0.4);
        }

        .neon-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(0, 245, 255, 0.1), transparent);
            transform: rotate(45deg);
            transition: all 0.6s;
        }

        .neon-card:hover::before {
            left: 100%;
        }

        .card-icon {
            font-size: 2.5rem;
            background: linear-gradient(135deg, #00f5ff, #ff00ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 15px;
            display: inline-block;
            animation: icon-bounce 2s ease-in-out infinite;
        }

        @keyframes icon-bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .card-label {
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 8px;
        }

        .card-value {
            color: #fff;
            font-size: 1.3rem;
            font-weight: 600;
        }

        /* Futuristic Buttons */
        .action-section {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
            animation: fade-in 0.8s ease-out 1.3s both;
        }

        .cyber-btn {
            position: relative;
            padding: 15px 40px;
            font-size: 1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-decoration: none;
            color: #00f5ff;
            background: transparent;
            border: 2px solid #00f5ff;
            border-radius: 0;
            clip-path: polygon(10px 0, 100% 0, 100% calc(100% - 10px), calc(100% - 10px) 100%, 0 100%, 0 10px);
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .cyber-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 245, 255, 0.4), transparent);
            transition: left 0.5s;
        }

        .cyber-btn:hover::before {
            left: 100%;
        }

        .cyber-btn:hover {
            color: #fff;
            box-shadow: 0 0 20px rgba(0, 245, 255, 0.6), inset 0 0 20px rgba(0, 245, 255, 0.2);
            transform: translateY(-3px);
        }

        .cyber-btn.secondary {
            color: #ff00ff;
            border-color: #ff00ff;
        }

        .cyber-btn.secondary:hover {
            box-shadow: 0 0 20px rgba(255, 0, 255, 0.6), inset 0 0 20px rgba(255, 0, 255, 0.2);
        }

        .cyber-btn span {
            position: relative;
            z-index: 1;
        }

        /* Scan Line Effect */
        .scan-line {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(0, 245, 255, 0.8), transparent);
            animation: scan 3s linear infinite;
        }

        @keyframes scan {
            from { top: 0; }
            to { top: 100%; }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .profile-title {
                font-size: 2rem;
            }

            .profile-header {
                padding: 40px 20px;
            }

            .profile-body {
                padding: 30px 20px;
            }

            .hexagon-wrapper {
                width: 150px;
                height: 150px;
            }

            .profile-img {
                width: 130px;
                height: 130px;
            }

            .action-section {
                flex-direction: column;
            }

            .cyber-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Animated Background -->
    <div class="bg-animation">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <div class="profile-wrapper">
        <div class="container profile-container">
            <div class="profile-card">
                <div class="scan-line"></div>
                
                <!-- Header Section -->
                <div class="profile-header">
                    <div class="header-glow"></div>
                </div>

                <!-- Hexagonal Profile Image -->
                <div class="profile-image-section">
                    <div class="hexagon-wrapper">
                        <div class="hexagon">
                            <div class="hexagon-inner">
                                <img src="uploads/<%= session.getAttribute("profilePic") %>" 
                                     alt="Profile" 
                                     class="profile-img"
                                     onerror="this.src='https://ui-avatars.com/api/?name=<%= session.getAttribute("username") %>&size=200&background=0a0e27&color=00f5ff&bold=true'">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Profile Body -->
                <div class="profile-body">
                    <h1 class="profile-title">MY PROFILE</h1>
                    <p class="profile-subtitle">Welcome to your futuristic dashboard</p>

                    <!-- Info Cards -->
                    <div class="info-grid">
                        <div class="neon-card">
                            <i class="fas fa-user-astronaut card-icon"></i>
                            <div class="card-label">Username</div>
                            <div class="card-value"><%= session.getAttribute("username") %></div>
                        </div>

                        <div class="neon-card">
                            <i class="fas fa-satellite-dish card-icon"></i>
                            <div class="card-label">Mobile Contact</div>
                            <div class="card-value"><%= session.getAttribute("phone") %></div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-section">
                        <a href="edit-profile.jsp" class="cyber-btn">
                            <span><i class="fas fa-edit me-2"></i>Edit Profile</span>
                        </a>
                        <a href="home.jsp" class="cyber-btn secondary">
                            <span><i class="fas fa-rocket me-2"></i>Back to Home</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>