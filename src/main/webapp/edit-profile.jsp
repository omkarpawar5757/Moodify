<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Futuristic</title>
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

        /* Main Wrapper */
        .edit-wrapper {
            position: relative;
            z-index: 1;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .edit-container {
            max-width: 700px;
            width: 100%;
            perspective: 1000px;
        }

        /* Glass Morphism Form Card */
        .edit-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 30px;
            padding: 50px 40px;
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

        /* Holographic Border */
        .edit-card::before {
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

        .edit-card:hover::before {
            opacity: 0.6;
        }

        @keyframes holographic {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Scan Line */
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

        /* Form Title */
        .form-title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(90deg, #00f5ff, #ff00ff, #00ff00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 15px;
            animation: title-appear 0.8s ease-out 0.3s both;
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

        .form-subtitle {
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 40px;
            animation: fade-in 0.8s ease-out 0.5s both;
        }

        @keyframes fade-in {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Form Groups */
        .form-group-cyber {
            margin-bottom: 30px;
            position: relative;
            animation: slide-in 0.6s ease-out both;
        }

        .form-group-cyber:nth-child(1) { animation-delay: 0.7s; }
        .form-group-cyber:nth-child(2) { animation-delay: 0.9s; }
        .form-group-cyber:nth-child(3) { animation-delay: 1.1s; }

        @keyframes slide-in {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Labels */
        .cyber-label {
            display: block;
            color: #00f5ff;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
            position: relative;
            padding-left: 30px;
        }

        .cyber-label i {
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
            animation: icon-pulse 2s ease-in-out infinite;
        }

        @keyframes icon-pulse {
            0%, 100% { transform: translateY(-50%) scale(1); }
            50% { transform: translateY(-50%) scale(1.2); }
        }

        /* Input Fields */
        .cyber-input {
            width: 100%;
            padding: 15px 20px;
            background: rgba(255, 255, 255, 0.05);
            border: 2px solid rgba(0, 245, 255, 0.3);
            border-radius: 12px;
            color: #fff;
            font-size: 1rem;
            transition: all 0.3s ease;
            outline: none;
        }

        .cyber-input:focus {
            border-color: #00f5ff;
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 20px rgba(0, 245, 255, 0.3), inset 0 0 10px rgba(0, 245, 255, 0.1);
            transform: translateY(-2px);
        }

        .cyber-input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }

        /* File Upload Styling */
        .file-upload-wrapper {
            position: relative;
            overflow: hidden;
        }

        .cyber-file-input {
            width: 100%;
            padding: 15px 20px;
            background: rgba(255, 255, 255, 0.05);
            border: 2px dashed rgba(0, 245, 255, 0.3);
            border-radius: 12px;
            color: #fff;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .cyber-file-input::-webkit-file-upload-button {
            background: linear-gradient(135deg, #00f5ff, #ff00ff);
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            margin-right: 15px;
            transition: all 0.3s ease;
        }

        .cyber-file-input::-webkit-file-upload-button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(0, 245, 255, 0.5);
        }

        .cyber-file-input:hover {
            border-color: #00f5ff;
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 20px rgba(0, 245, 255, 0.2);
        }

        /* File Upload Info */
        .file-info {
            margin-top: 10px;
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.85rem;
            display: flex;
            align-items: center;
        }

        .file-info i {
            margin-right: 8px;
            color: #00f5ff;
        }

        /* Button Section */
        .button-section {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            animation: fade-in 0.8s ease-out 1.3s both;
        }

        .cyber-btn {
            flex: 1;
            position: relative;
            padding: 18px 40px;
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
            cursor: pointer;
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

        .cyber-btn.secondary::before {
            background: linear-gradient(90deg, transparent, rgba(255, 0, 255, 0.4), transparent);
        }

        .cyber-btn.secondary:hover {
            box-shadow: 0 0 20px rgba(255, 0, 255, 0.6), inset 0 0 20px rgba(255, 0, 255, 0.2);
        }

        .cyber-btn span {
            position: relative;
            z-index: 1;
        }

        /* Current Image Preview */
        .current-image-wrapper {
            text-align: center;
            margin-bottom: 30px;
            animation: fade-in 0.8s ease-out 0.5s both;
        }

        .current-image-label {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.9rem;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .hexagon-preview {
            width: 120px;
            height: 120px;
            margin: 0 auto;
            position: relative;
        }

        .hexagon-preview-shape {
            width: 100%;
            height: 100%;
            clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
            background: linear-gradient(135deg, #00f5ff, #ff00ff);
            padding: 3px;
            animation: hexagon-glow 2s ease-in-out infinite alternate;
        }

        @keyframes hexagon-glow {
            from { filter: drop-shadow(0 0 10px rgba(0, 245, 255, 0.5)); }
            to { filter: drop-shadow(0 0 20px rgba(255, 0, 255, 0.8)); }
        }

        .hexagon-preview-inner {
            width: 100%;
            height: 100%;
            clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
            background: #0a0e27;
            overflow: hidden;
        }

        .preview-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .edit-card {
                padding: 40px 25px;
            }

            .form-title {
                font-size: 2rem;
            }

            .button-section {
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

    <div class="edit-wrapper">
        <div class="container edit-container">
            <div class="edit-card">
                <div class="scan-line"></div>

                <h1 class="form-title">EDIT PROFILE</h1>
                <p class="form-subtitle">Update your information</p>

                <!-- Current Profile Image Preview -->
                <div class="current-image-wrapper">
                    <div class="current-image-label">Current Profile Photo</div>
                    <div class="hexagon-preview">
                        <div class="hexagon-preview-shape">
                            <div class="hexagon-preview-inner">
                                <img src="uploads/<%= session.getAttribute("profilePic") %>" 
                                     alt="Current Profile" 
                                     class="preview-img"
                                     onerror="this.src='https://ui-avatars.com/api/?name=<%= session.getAttribute("username") %>&size=150&background=0a0e27&color=00f5ff&bold=true'">
                            </div>
                        </div>
                    </div>
                </div>

                <form action="updateProfile" method="post" enctype="multipart/form-data">
                    
                    <!-- Username Field -->
                    <div class="form-group-cyber">
                        <label class="cyber-label">
                            <i class="fas fa-user-astronaut"></i>
                            Username
                        </label>
                        <input type="text" 
                               name="username" 
                               class="cyber-input"
                               value="<%= session.getAttribute("username") %>" 
                               placeholder="Enter your username"
                               required>
                    </div>

                    <!-- Profile Photo Upload -->
                    <div class="form-group-cyber">
                        <label class="cyber-label">
                            <i class="fas fa-camera"></i>
                            Profile Photo
                        </label>
                        <div class="file-upload-wrapper">
                            <input type="file" 
                                   name="profilePic" 
                                   class="cyber-file-input"
                                   accept="image/*">
                        </div>
                        <div class="file-info">
                            <i class="fas fa-info-circle"></i>
                            Supported formats: JPG, PNG, GIF (Max 5MB)
                        </div>
                    </div>

                    <!-- Mobile Number Field -->
                    <div class="form-group-cyber">
                        <label class="cyber-label">
                            <i class="fas fa-satellite-dish"></i>
                            Mobile Contact
                        </label>
                        <input type="text" 
                               name="phone" 
                               class="cyber-input"
                               value="<%= session.getAttribute("phone") %>" 
                               placeholder="Enter your mobile number"
                               required>
                    </div>

                    <!-- Action Buttons -->
                    <div class="button-section">
                        <button type="submit" class="cyber-btn">
                            <span><i class="fas fa-save me-2"></i>Save Changes</span>
                        </button>
                        <a href="profile.jsp" class="cyber-btn secondary">
                            <span><i class="fas fa-times me-2"></i>Cancel</span>
                        </a>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>