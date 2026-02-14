<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Be My Valentine 💘</title>

<style>
body {
  margin: 0;
  height: 100vh;
  background: linear-gradient(135deg, #ff758c, #ff7eb3);
  display: flex;
  justify-content: center;
  align-items: center;
  font-family: 'Segoe UI', sans-serif;
  overflow: hidden;
}

.card {
  background: white;
  padding: 30px;
  border-radius: 25px;
  box-shadow: 0 15px 40px rgba(0,0,0,0.3);
  width: 330px;
  text-align: center;
  z-index: 2;
}

h1 {
  color: #ff2f68;
}

p {
  font-size: 18px;
  color: #444;
}

.yes {
  background: #ff2f68;
  color: white;
  border: none;
  padding: 16px 35px;
  font-size: 22px;
  border-radius: 40px;
  cursor: pointer;
  width: 85%;
}

.no {
  background: #eee;
  color: #666;
  border: none;
  padding: 8px 14px;
  font-size: 12px;
  border-radius: 20px;
  cursor: pointer;
  position: absolute;
}

.hidden { display: none; }

/* Hearts */
.heart, .emoji {
  position: absolute;
  bottom: -20px;
  font-size: 22px;
  animation: floatUp 6s infinite;
}

@keyframes floatUp {
  0% { transform: translateY(0); opacity: 0; }
  50% { opacity: 1; }
  100% { transform: translateY(-120vh); opacity: 0; }
}

/* Fireworks */
.firework {
  position: absolute;
  width: 6px;
  height: 6px;
  background: gold;
  border-radius: 50%;
  animation: boom 1s ease-out forwards;
}

@keyframes boom {
  to {
    transform: scale(25);
    opacity: 0;
  }
}
</style>
</head>

<body>

<!-- 🎶 MUSIC -->
<audio id="music" loop>
  <source src="https://cdn.pixabay.com/audio/2023/02/14/audio_99c1bba0b3.mp3" type="audio/mp3">
</audio>

<!-- 💌 QUESTION -->
<div class="card" id="question">
  <h1>Hey my love 💕</h1>
  <p>Will you be my Valentine, <span id="name"></span>? 💌🥰</p>
  <br>
  <button class="yes" onclick="yesClicked()">YES 💖</button>
</div>

<button class="no" id="noBtn">No 🙈</button>

<!-- 💖 FINAL -->
<div class="card hidden" id="happy">
  <h1>Happy Valentine’s Day 💘</h1>
  <p>
    My Sanu 🥰💖🌹<br><br>
    You are my heart,<br>
    my smile, my forever ❤️
  </p>
</div>

<script>
/* TYPE NAME */
const nameText = "Sanu";
let i = 0;
setInterval(() => {
  if (i < nameText.length) {
    document.getElementById("name").innerHTML += nameText[i];
    i++;
  }
}, 300);

/* YES */
function yesClicked() {
  document.getElementById("question").classList.add("hidden");
  document.getElementById("noBtn").classList.add("hidden");
  document.getElementById("happy").classList.remove("hidden");
  document.getElementById("music").play();

  // Fireworks
  for (let i = 0; i < 15; i++) {
    const fw = document.createElement("div");
    fw.className = "firework";
    fw.style.left = Math.random() * 100 + "vw";
    fw.style.top = Math.random() * 100 + "vh";
    document.body.appendChild(fw);
    setTimeout(() => fw.remove(), 1000);
  }
}

/* NO RUN */
const noBtn = document.getElementById("noBtn");
noBtn.addEventListener("mouseover", () => {
  noBtn.style.left = Math.random() * (window.innerWidth - 80) + "px";
  noBtn.style.top = Math.random() * (window.innerHeight - 40) + "px";
});

/* HEARTS + EMOJIS */
setInterval(() => {
  const el = document.createElement("div");
  el.className = Math.random() > 0.5 ? "heart" : "emoji";
  el.innerHTML = Math.random() > 0.5 ? "💗" : "😘🤗";
  el.style.left = Math.random() * 100 + "vw";
  document.body.appendChild(el);
  setTimeout(() => el.remove(), 6000);
}, 250);
</script>

</body>
</html>
