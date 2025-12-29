<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("index.html");
        return;
    }
    String username = (String) session.getAttribute("username");
    String quote = (String) session.getAttribute("quote");
    String profilePic = (String) session.getAttribute("profilePic");
    if (profilePic == null || profilePic.isEmpty()) {
        profilePic = "default.png";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emotion Music Player</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Rajdhani', sans-serif; background: #0a0e27; color: #fff; overflow-x: hidden; }
        .bg-animation { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 0; overflow: hidden; }
        .particle { position: absolute; background: radial-gradient(circle, rgba(100, 200, 255, 0.6), transparent); border-radius: 50%; animation: float-particle 25s infinite ease-in-out; }
        .particle:nth-child(1) { width: 100px; height: 100px; top: 5%; left: 15%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 80px; height: 80px; top: 70%; left: 85%; animation-delay: 4s; }
        .particle:nth-child(3) { width: 120px; height: 120px; top: 85%; left: 5%; animation-delay: 8s; }
        @keyframes float-particle { 0%, 100% { transform: translate(0, 0) scale(1); opacity: 0.2; } 50% { transform: translate(-40px, 40px) scale(0.7); opacity: 0.3; } }
        .grid-bg { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-image: linear-gradient(rgba(0, 245, 255, 0.03) 1px, transparent 1px), linear-gradient(90deg, rgba(0, 245, 255, 0.03) 1px, transparent 1px); background-size: 50px 50px; z-index: 0; }
        .main-wrapper { position: relative; z-index: 1; min-height: 100vh; }
        .cyber-nav { background: rgba(10, 14, 39, 0.95); backdrop-filter: blur(20px); border-bottom: 2px solid rgba(0, 245, 255, 0.3); padding: 15px 30px; position: sticky; top: 0; z-index: 100; box-shadow: 0 4px 20px rgba(0, 245, 255, 0.2); }
        .nav-content { display: flex; justify-content: space-between; align-items: center; max-width: 1400px; margin: 0 auto; }
        .nav-logo { font-family: 'Orbitron', sans-serif; font-size: 1.5rem; font-weight: 900; background: linear-gradient(90deg, #00f5ff, #ff00ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; display: flex; align-items: center; gap: 10px; }
        .nav-logo i { color: #00f5ff; animation: pulse-icon 2s ease-in-out infinite; }
        @keyframes pulse-icon { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.2); } }
        .profile-section { position: relative; }
        .profile-trigger { display: flex; align-items: center; gap: 12px; cursor: pointer; padding: 8px 15px; border: 2px solid rgba(0, 245, 255, 0.3); border-radius: 30px; transition: all 0.3s ease; background: rgba(255, 255, 255, 0.05); }
        .profile-trigger:hover { border-color: #00f5ff; box-shadow: 0 0 15px rgba(0, 245, 255, 0.4); }
        .profile-pic-nav { width: 40px; height: 40px; border-radius: 50%; border: 2px solid #00f5ff; object-fit: cover; }
        .profile-name { font-weight: 600; color: #00f5ff; }
        .profile-dropdown { position: absolute; top: 60px; right: 0; width: 280px; background: rgba(10, 14, 39, 0.98); backdrop-filter: blur(20px); border: 2px solid rgba(0, 245, 255, 0.3); border-radius: 20px; padding: 25px; display: none; box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5); }
        .profile-dropdown.active { display: block; }
        .dropdown-pic { width: 80px; height: 80px; border-radius: 50%; border: 3px solid #00f5ff; object-fit: cover; margin-bottom: 10px; }
        .dropdown-username { font-size: 1.2rem; font-weight: 700; color: #00f5ff; }
        .dropdown-btn { width: 100%; padding: 12px; margin: 8px 0; border: 2px solid rgba(0, 245, 255, 0.3); background: rgba(255, 255, 255, 0.05); color: #00f5ff; border-radius: 10px; text-decoration: none; display: block; text-align: center; font-weight: 600; transition: all 0.3s ease; }
        .dropdown-btn:hover { border-color: #00f5ff; background: rgba(0, 245, 255, 0.1); color: #fff; }
        .dropdown-btn.logout { border-color: rgba(255, 0, 255, 0.3); color: #ff00ff; }
        .content-container { max-width: 1400px; margin: 0 auto; padding: 30px 20px; }
        .cyber-card { background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(20px); border: 2px solid rgba(0, 245, 255, 0.2); border-radius: 20px; padding: 20px; margin-bottom: 20px; position: relative; overflow: hidden; transition: all 0.3s ease; }
        .cyber-card:hover { border-color: rgba(0, 245, 255, 0.5); box-shadow: 0 10px 40px rgba(0, 245, 255, 0.2); }
        .video-container { position: relative; border-radius: 15px; overflow: hidden; border: 3px solid rgba(0, 245, 255, 0.3); box-shadow: 0 0 30px rgba(0, 245, 255, 0.2); max-width: 350px; margin: 0 auto; }
        #video { width: 100%; display: block; border-radius: 12px; }
        .video-overlay { position: absolute; top: 10px; left: 10px; background: rgba(0, 0, 0, 0.7); padding: 5px 10px; border-radius: 15px; border: 1px solid rgba(0, 245, 255, 0.5); font-size: 0.75rem; color: #00f5ff; }
        .emotion-display { text-align: center; padding: 12px; margin: 12px 0; background: rgba(0, 245, 255, 0.05); border-radius: 10px; border: 2px solid rgba(0, 245, 255, 0.2); }
        .emotion-label { font-size: 0.7rem; color: rgba(255, 255, 255, 0.6); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px; }
        .emotion-value { font-family: 'Orbitron', sans-serif; font-size: 1.3rem; font-weight: 900; background: linear-gradient(90deg, #00f5ff, #ff00ff, #00ff00); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .action-buttons { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin: 12px 0; }
        .cyber-action-btn { padding: 8px 12px; font-size: 0.8rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; border: 2px solid; background: transparent; border-radius: 8px; transition: all 0.3s ease; cursor: pointer; }
        .cyber-action-btn.primary { border-color: #00f5ff; color: #00f5ff; }
        .cyber-action-btn.primary:hover { background: rgba(0, 245, 255, 0.1); box-shadow: 0 0 12px rgba(0, 245, 255, 0.5); }
        .cyber-action-btn.secondary { padding: 8px 12px; border-color: #ff00ff; color: #ff00ff; }
        .cyber-action-btn.secondary:hover { background: rgba(255, 0, 255, 0.1); box-shadow: 0 0 12px rgba(255, 0, 255, 0.5); }
        .cyber-action-btn:disabled { opacity: 0.5; cursor: not-allowed; }
        .quote-section { text-align: center; padding: 12px; background: rgba(255, 0, 255, 0.05); border-radius: 10px; border: 2px solid rgba(255, 0, 255, 0.2); margin-top: 12px; }
        .quote-label { font-size: 0.7rem; color: rgba(255, 255, 255, 0.6); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px; }
        .quote-text { font-size: 0.85rem; font-style: italic; color: #ff00ff; line-height: 1.3; }
        .section-header { display: flex; justify-content: space-between; align-items: center; margin: 20px 0 15px 0; }
        .section-header h3 { font-family: 'Orbitron', sans-serif; font-size: 1.2rem; background: linear-gradient(90deg, #00f5ff, #ff00ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .section-header a { color: #00f5ff; text-decoration: none; font-size: 0.85rem; }
        .carousel-container { position: relative; padding: 0 35px; }
        .playlist-row { display: flex; gap: 12px; overflow-x: auto; scroll-behavior: smooth; scrollbar-width: thin; scrollbar-color: rgba(0, 245, 255, 0.5) rgba(255, 255, 255, 0.05); padding: 10px 0; }
        .playlist-row::-webkit-scrollbar { height: 6px; }
        .playlist-row::-webkit-scrollbar-track { background: rgba(255, 255, 255, 0.05); border-radius: 10px; }
        .playlist-row::-webkit-scrollbar-thumb { background: rgba(0, 245, 255, 0.5); border-radius: 10px; }
        .playlist-card { min-width: 160px; background: rgba(255, 255, 255, 0.05); border: 2px solid rgba(0, 245, 255, 0.2); border-radius: 12px; padding: 12px; transition: all 0.3s ease; cursor: pointer; }
        .playlist-card:hover { transform: translateY(-5px); border-color: #00f5ff; box-shadow: 0 5px 15px rgba(0, 245, 255, 0.3); }
        .playlist-card img { width: 100%; height: 140px; object-fit: cover; border-radius: 8px; margin-bottom: 8px; }
        .playlist-card h5 { font-size: 0.9rem; font-weight: 700; color: #00f5ff; margin-bottom: 4px; }
        .playlist-card p { font-size: 0.75rem; color: rgba(255, 255, 255, 0.6); line-height: 1.2; }
        .carousel-nav { position: absolute; top: 50%; transform: translateY(-50%); width: 30px; height: 30px; background: rgba(0, 245, 255, 0.2); border: 2px solid rgba(0, 245, 255, 0.5); border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.3s ease; z-index: 10; }
        .carousel-nav:hover { background: rgba(0, 245, 255, 0.4); }
        .carousel-nav.prev { left: 0; }
        .carousel-nav.next { right: 0; }
        .spotify-header, .live-video-header, .chatbot-header { padding: 12px; text-align: center; font-size: 1rem; font-weight: 700; border-radius: 15px 15px 0 0; }
        .spotify-header { background: linear-gradient(135deg, rgba(30, 215, 96, 0.2), rgba(0, 245, 255, 0.2)); border-bottom: 2px solid rgba(30, 215, 96, 0.3); }
        .live-video-header { background: linear-gradient(135deg, rgba(255, 0, 255, 0.2), rgba(0, 245, 255, 0.2)); border-bottom: 2px solid rgba(255, 0, 255, 0.3); }
        .chatbot-header { background: linear-gradient(135deg, rgba(0, 245, 255, 0.2), rgba(255, 0, 255, 0.2)); border-bottom: 2px solid rgba(0, 245, 255, 0.3); }
        .spotify-body, .live-video-body { padding: 12px; background: rgba(0, 0, 0, 0.3); border-radius: 0 0 15px 15px; }
        #spotifyPlayer { border-radius: 10px; height: 380px; border: 2px solid rgba(30, 215, 96, 0.3); }
        .live-video-container { position: relative; border-radius: 10px; overflow: hidden; border: 2px solid rgba(255, 0, 255, 0.3); }
        .live-video-container iframe { width: 100%; height: 180px; border: none; }
        .live-badge { position: absolute; top: 8px; left: 8px; background: rgba(255, 0, 0, 0.8); color: #fff; padding: 4px 10px; border-radius: 15px; font-size: 0.7rem; font-weight: 700; }
        .chat-body { height: 280px; overflow-y: auto; padding: 12px; background: rgba(0, 0, 0, 0.3); }
        .chat-body::-webkit-scrollbar { width: 5px; }
        .chat-body::-webkit-scrollbar-thumb { background: rgba(0, 245, 255, 0.5); border-radius: 10px; }
        .chat-message { margin-bottom: 10px; padding: 8px 12px; border-radius: 10px; max-width: 85%; font-size: 0.85rem; }
        .bot { background: rgba(0, 245, 255, 0.1); border: 1px solid rgba(0, 245, 255, 0.3); color: #00f5ff; margin-right: auto; }
        .user { background: rgba(255, 0, 255, 0.1); border: 1px solid rgba(255, 0, 255, 0.3); color: #ff00ff; margin-left: auto; text-align: right; }
        .chat-input-section { display: flex; gap: 8px; padding: 12px; background: rgba(0, 0, 0, 0.3); border-radius: 0 0 15px 15px; }
        .chat-input { flex: 1; padding: 8px 12px; background: rgba(255, 255, 255, 0.05); border: 2px solid rgba(0, 245, 255, 0.3); border-radius: 18px; color: #fff; outline: none; font-size: 0.85rem; }
        .chat-send-btn { padding: 8px 16px; background: linear-gradient(135deg, #00f5ff, #ff00ff); border: none; border-radius: 18px; color: #fff; font-weight: 700; cursor: pointer; font-size: 0.85rem; }
        
        .right-panel { display: flex; flex-direction: column; gap: 20px; }
        .spotify-card, .live-video-card { flex: 1; }
        
        @media (min-width: 992px) {
            .right-panel { position: sticky; top: 90px; align-self: flex-start; }
        }
        
        @media (max-width: 992px) { 
            .profile-name { display: none; } 
            .video-container { max-width: 100%; } 
        }
    </style>
</head>
<body>
    <div class="bg-animation">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>
    <div class="grid-bg"></div>
    
    <div class="main-wrapper">
        <nav class="cyber-nav">
            <div class="nav-content">
                <div class="nav-logo">
                    <i class="fas fa-brain"></i>
                    <span>EMOTION MUSIC PLAYER</span>
                </div>
                <div class="profile-section">
                    <div class="profile-trigger" onclick="toggleProfile()">
                        <img src="uploads/<%= profilePic %>" class="profile-pic-nav" alt="Profile" onerror="this.src='https://ui-avatars.com/api/?name=<%= username %>&size=100&background=00f5ff&color=0a0e27'">
                        <span class="profile-name"><%= username %></span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div id="profileBox" class="profile-dropdown">
                        <div class="text-center mb-3">
                            <img src="uploads/<%= profilePic %>" class="dropdown-pic" alt="Profile">
                            <div class="dropdown-username"><%= username %></div>
                        </div>
                        <a href="profile.jsp" class="dropdown-btn"><i class="fas fa-user me-2"></i>View Profile</a>
                        <a href="logout" class="dropdown-btn logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                    </div>
                </div>
            </div>
        </nav>
        
        <div class="content-container">
            <div class="row">
                <!-- Left Column - Camera and Detection -->
                <div class="col-lg-8">
                    <div class="cyber-card">
                        <div class="video-container">
                            <div class="video-overlay"><i class="fas fa-video me-1"></i>Live Detection</div>
                            <video id="video" autoplay muted></video>
                        </div>
                        
                        <div class="emotion-display">
                            <div class="emotion-label"><i class="fas fa-smile me-1"></i>Detected Emotion</div>
                            <div class="emotion-value" id="emotion">Detecting...</div>
                        </div>
                        
                        <div class="action-buttons">

                            <button id="detectAgainBtn" class="cyber-action-btn secondary" disabled>
                                <i class="fas fa-redo me-2"></i>Detect Again
                            </button>
                        </div>
                        
                        <div class="quote-section">
                            <div class="quote-label"><i class="fas fa-quote-left me-1"></i>Motivational Quote</div>
                            <div class="quote-text" id="emotionQuote">Detecting quote...</div>
                        </div>
                    </div>
                    
                    <!-- Playlists Section -->
                    <div class="cyber-card">
                        <div class="section-header">
                            <h3>Playlists from our Editors</h3>
                     
                        </div>
                        <div class="carousel-container">
                            <div class="carousel-nav prev" onclick="scrollCarousel('left')"><i class="fas fa-chevron-left"></i></div>
                 <div class="playlist-row" id="playlistRow">

<a href="https://open.spotify.com/search/hot%20hits%20hindi" target="_blank" class="text-decoration-none">
<div class="playlist-card">
  <img src="images/ab67706f00000002d5b8f67e837e87478e83e398.jpg">
   
    <h5>Hot Hits Hindi</h5>
    <p>Hottest Hindi music India is listening to</p>
</div>
</a>

<a href="https://open.spotify.com/search/punjabi%20hits" target="_blank" class="text-decoration-none">
<div class="playlist-card">
 <img src="images/ab67706f00000002d87817e1e9c0c37a37cef564.jpg">
    
    <h5>Hot Hits Punjabi</h5>
    <p>Catch the hottest Punjabi tracks</p>
</div>
</a>

<a href="https://open.spotify.com/search/malayalam%20trending" target="_blank" class="text-decoration-none">
<div class="playlist-card">
 <img src="images/ab67706f00000002a32eff2bc6ebc6f591d2839a.jpg">

    <h5>Trending Malayalam</h5>
    <p>Every song that's trending now</p>
</div>
</a>

<a href="https://open.spotify.com/search/telugu%20hits" target="_blank" class="text-decoration-none">
<div class="playlist-card">
 <img src="images/ab67706f000000022efd8cdf341d21c2ac13afca.jpg">
   
    <h5>Hot Hits Telugu</h5>
    <p>Top Telugu movie & album songs</p>
</div>
</a>

<a href="https://open.spotify.com/search/tamil%20dance" target="_blank" class="text-decoration-none">
<div class="playlist-card">
<img src="images/ab67706f0000000247982d69a06c09c99ef8ad6e.jpg">
   
    <h5>Latest Dance Tamil</h5>
    <p>Best Tamil dance tracks songs</p>
</div>
</a>

<a href="https://open.spotify.com/search/chill%20vibes" target="_blank" class="text-decoration-none">
<div class="playlist-card">
      <img src="images/chill.jpg">
    <h5>Chill Vibes</h5>
    <p>Relax with these smooth tracks</p>
</div>
</a>

<a href="https://open.spotify.com/search/workout%20music" target="_blank" class="text-decoration-none">
<div class="playlist-card">
 <img src="images/workout.jpg">
   
    <h5>Workout Mix</h5>
    <p>High energy songs for fitness</p>
</div>
</a>

</div>

                            <div class="carousel-nav next" onclick="scrollCarousel('right')"><i class="fas fa-chevron-right"></i></div>
                      </div>
                    </div>
                    
                    <!-- Chatbot Section -->
                    <div class="cyber-card chatbot-card">
                        <div class="chatbot-header"><i class="fas fa-robot me-2"></i>EMOTION ASSISTANT</div>
                        <div class="chat-body" id="chatBody">
                            <div class="chat-message bot">
                                <i class="fas fa-robot me-1"></i>Hello <%= username %>! 👋 I am your emotion assistant.
                            </div>
                        </div>
                        <div class="chat-input-section">
                            <input type="text" id="userMsg" class="chat-input" placeholder="Type your message..." onkeydown="handleEnter(event)">
                            <button class="chat-send-btn" onclick="sendMessage()">➤</button>
                        </div>
                    </div>
                </div>
                
                <!-- Right Column - Spotify Player and Live Video -->
                <div class="col-lg-4 right-panel">
                    <!-- Emotion Playlist -->
                    <div class="cyber-card spotify-card">
                        <div class="spotify-header">
                            <i class="fab fa-spotify me-2"></i>EMOTION PLAYLIST
                        </div>
                        <div class="spotify-body">
                            <iframe
                                id="spotifyPlayer"
                                src=""
                                width="100%"
                                height="380"
                                frameBorder="0"
                                allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture"
                                loading="lazy">
                            </iframe>
                        </div>
                    </div>

                    <!-- Live Video -->
                    <div class="cyber-card live-video-card">
                        <div class="live-video-header">
                            <i class="fas fa-play-circle me-2"></i>LIVE VIDEO PLAYER
                        </div>
                        <div class="live-video-body">
                            <div class="live-video-container">
                                <div class="live-badge">● LIVE</div>
                                <iframe 
                                    src="https://www.youtube.com/embed/QVxv3q_OVb8?autoplay=1&mute=1"
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture">
                                </iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function toggleProfile() {
            document.getElementById('profileBox').classList.toggle('active');
        }
        
        document.addEventListener('click', function(event) {
            const profileSection = document.querySelector('.profile-section');
            if (!profileSection.contains(event.target)) {
                document.getElementById('profileBox').classList.remove('active');
            }
        });
        
        function scrollCarousel(direction) {
            const row = document.getElementById('playlistRow');
            const scrollAmount = 300;
            if (direction === 'left') {
                row.scrollLeft -= scrollAmount;
            } else {
                row.scrollLeft += scrollAmount;
            }
        }
        
        function handleEnter(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        }
        
        function sendMessage() {
            const input = document.getElementById('userMsg');
            const message = input.value.trim();
            if (message) {
                const chatBody = document.getElementById('chatBody');
                chatBody.innerHTML += `<div class="chat-message user">${message}</div>`;
                input.value = '';
                chatBody.scrollTop = chatBody.scrollHeight;
                
                setTimeout(() => {
                    chatBody.innerHTML += `<div class="chat-message bot"><i class="fas fa-robot me-1"></i>I understand your emotion. How can I help you feel better?</div>`;
                    chatBody.scrollTop = chatBody.scrollHeight;
                }, 1000);
            }
        }
    </script>
    
    <script src="js/chatbot.js"></script>
    <script src="https://unpkg.com/face-api.js@0.22.2/dist/face-api.min.js"></script>
    <script src="js/emotion.js"></script>
</body>
</html>