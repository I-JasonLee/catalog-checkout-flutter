const express = require("express");

const authMiddleware = require("../middleware/authMiddleware");

const router = express.Router();


// PAYMENT TRANSACTION
router.post("/", authMiddleware, async (req, res) => {

    try {

        const {
            transactionId,
            amount
        } = req.body;



        // validasi input

        if (!transactionId || !amount) {

            return res.status(400).json({

                success: false,

                message:
                "Data transaksi tidak lengkap",

            });

        }



        // user dari JWT middleware

        const user = req.user;



        console.log(
            "PAYMENT USER:",
            user.email
        );


        console.log(
            "TRANSACTION ID:",
            transactionId
        );


        console.log(
            "AMOUNT:",
            amount
        );



        /*
            TODO:
            Nanti bagian ini digunakan untuk:
            - simpan transaksi ke database
            - update saldo user
            - generate invoice
        */



        return res.status(200).json({

            success: true,

            message:
            "Payment success",


            transaction: {

                transactionId,

                amount,

                status:
                "success",

                user: {

                    uid:
                    user.uid,

                    email:
                    user.email,

                }

            }

        });



    } catch (error) {


        return res.status(500).json({

            success:false,

            message:
            error.message,

        });


    }

});


module.exports = router;