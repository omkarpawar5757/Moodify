/*********************************
 * LOAD FACE-API MODELS
 *********************************/
Promise.all([
    faceapi.nets.tinyFaceDetector.loadFromUri("/EmotionMusicProject/models"),
    faceapi.nets.faceExpressionNet.loadFromUri("/EmotionMusicProject/models")
]).then(startVideo);


/*********************************
 * START CAMERA
 *********************************/
function startVideo() {
    navigator.mediaDevices.getUserMedia({ video: true })
        .then(stream => {
            document.getElementById("video").srcObject = stream;
        })
        .catch(err => console.error("Camera error:", err));
}


/*********************************
 * QUOTES BASED ON EMOTION
 *********************************/
const emotionQuotes = {
    happy: [
        "Happiness is a direction, not a place.",
        "Smile! Your joy is contagious 😊",
        "Choose happiness every day."
    ],
    sad: [
        "This too shall pass 💙",
        "Every storm runs out of rain.",
        "You are stronger than you think."
    ],
    angry: [
        "Breathe. Calm is power.",
        "Anger doesn’t solve problems.",
        "Silence is sometimes the best response."
    ],
    fearful: [
        "Fear is temporary, regret is permanent.",
        "Courage starts with showing up.",
        "You are braver than you believe."
    ],
    neutral: [
        "Peace begins with a smile.",
        "Stay calm and centered.",
        "Balance is the key to everything."
    ],
    surprised: [
        "Life is full of beautiful surprises!",
        "Expect the unexpected.",
        "Every surprise teaches something."
    ]
};


/*********************************
 * SHOW QUOTE FUNCTION
 *********************************/
function showQuoteForEmotion(emotion) {
    const quoteBox = document.getElementById("emotionQuote");

    if (!quoteBox || !emotionQuotes[emotion]) {
        quoteBox.innerText = "Stay positive 🌱";
        return;
    }

    const quotes = emotionQuotes[emotion];
    const randomIndex = Math.floor(Math.random() * quotes.length);
    quoteBox.innerText = quotes[randomIndex];
}


/*********************************
 * STATE VARIABLES
 *********************************/
let lastEmotion = "";
let sameEmotionCount = 0;
let lockedEmotion = null;


/*********************************
 * SPOTIFY PLAYLIST LINKS
 *********************************/
const spotifyPlaylists = {
    happy: "https://open.spotify.com/embed/playlist/37i9dQZF1DWTwbZHrJRIgD",
    sad: "https://open.spotify.com/embed/playlist/37i9dQZF1DX7qK8ma5wgG1",
    angry: "https://open.spotify.com/embed/playlist/37i9dQZF1DX1tyCD9QhIWF",
    neutral: "https://open.spotify.com/embed/playlist/4gMvYj2ZGjMmF90TsOLQAt",
    surprised: "https://open.spotify.com/embed/playlist/37i9dQZF1DX4fpCWaHOned"
};



/*********************************
 * EMOJI MAP
 *********************************/
const emotionEmojis = {
    happy: "😄",
    sad: "😢",
    angry: "😠",
    neutral: "🙂",
    surprised: "😲",
    fearful: "😨"
};


/*********************************
 * DETECTION LOOP
 *********************************/
document.getElementById("video").addEventListener("play", () => {

    setInterval(async () => {

        if (lockedEmotion) return;

        const detection = await faceapi
            .detectSingleFace(
                document.getElementById("video"),
                new faceapi.TinyFaceDetectorOptions()
            )
            .withFaceExpressions();

        if (!detection) return;

        const expressions = detection.expressions;

        let emotion = "neutral";
        let maxValue = 0;

        for (let exp in expressions) {
            if (expressions[exp] > maxValue) {
                maxValue = expressions[exp];
                emotion = exp;
            }
        }

        document.getElementById("emotion").innerText =
            "Detecting: " + emotionEmojis[emotion] + " " + emotion;

        if (emotion === lastEmotion) {
            sameEmotionCount++;
        } else {
            lastEmotion = emotion;
            sameEmotionCount = 1;
        }

        if (sameEmotionCount >= 3) {
            lockEmotion(emotion);
        }

    }, 1000);
});


/*********************************
 * LOCK EMOTION
 *********************************/
function lockEmotion(emotion) {
    lockedEmotion = emotion;

    document.getElementById("emotion").innerText =
        "LOCKED: " + emotionEmojis[emotion] + " " + emotion.toUpperCase();

    showQuoteForEmotion(emotion);

    // 🎧 UPDATE EMBED PLAYER
    const player = document.getElementById("spotifyPlayer");
    if (player && spotifyPlaylists[emotion]) {
        player.src = spotifyPlaylists[emotion];
    }

    document.getElementById("detectAgainBtn").disabled = false;

	if (typeof updateEmotionForChatbot === "function") {
	    updateEmotionForChatbot(emotion);
	}

	showQuoteForEmotion(emotion);

}



/*********************************
 * OPEN SPOTIFY PLAYLIST
 *********************************/

document.getElementById("openPlaylistBtn").addEventListener("click", () => {
    if (!lockedEmotion) return;

    const url = spotifyPlaylists[lockedEmotion] || spotifyPlaylists.neutral;
    window.open(url, "_blank");
});


/*********************************
 * RESET / DETECT AGAIN
 *********************************/
document.getElementById("detectAgainBtn").addEventListener("click", () => {
    lockedEmotion = null;
    lastEmotion = "";
    sameEmotionCount = 0;

    document.getElementById("emotion").innerText = "Detecting...";
    document.getElementById("emotionQuote").innerText = "Detecting quote...";
    document.getElementById("spotifyPlayer").src = "";

    document.getElementById("detectAgainBtn").disabled = true;
});
