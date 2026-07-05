require("dotenv").config();

const express = require("express");
const cors = require("cors");
const jwt = require("jsonwebtoken");
const admin = require("./firebase");
const productRoutes = require("./routes/productRoutes");

const app = express();

app.use(cors());
app.use(express.json());
app.use("/products", productRoutes);

// TEST
app.get("/", (req, res) => {
  res.json({ message: "Backend Ready" });
});

// LOGIN + VERIFY + JWT
app.post("/login", async (req, res) => {
  try {
    const { token } = req.body;

    if (!token) {
      return res.status(400).json({ message: "Firebase token required" });
    }

    // VERIFY FIREBASE TOKEN
    const decoded = await admin.auth().verifyIdToken(token);

    // CREATE JWT
    const jwtToken = jwt.sign(
      {
        uid: decoded.uid,
        email: decoded.email,
      },
      process.env.JWT_SECRET,
      { expiresIn: "1d" }
    );

    return res.json({
      message: "Login success",
      jwt: jwtToken,
      user: {
        uid: decoded.uid,
        email: decoded.email,
      },
    });
  } catch (error) {
    return res.status(401).json({
      message: "Unauthorized",
      error: error.message,
    });
  }
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});