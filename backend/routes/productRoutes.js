const express = require("express");
const router = express.Router();

const authMiddleware = require("../middleware/authMiddleware");

// 📦 DUMMY DATA PRODUK
const products = [
  {
    id: 1,
    name: "Laptop Gaming",
    price: 15000000,
  },
  {
    id: 2,
    name: "Keyboard Mechanical",
    price: 800000,
  },
  {
    id: 3,
    name: "Mouse Wireless",
    price: 300000,
  },
];

// 🔒 PROTECTED ROUTE
router.get("/", authMiddleware, (req, res) => {
  res.json({
    message: "Success",
    user: req.user,
    data: products,
  });
});

module.exports = router;