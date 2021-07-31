package com.app.thought_factory.shop_owner

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import com.app.thought_factory.shop_owner.remote.ApiInterface
import com.app.thought_factory.shop_owner.request_response.request_payment.Authorization
import com.app.thought_factory.shop_owner.request_response.request_payment.DetailsRequest
import com.shatech.customerdetailapp.response.DetailsResponse
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.*


class PaymentApiCallingActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_payment_api_calling)
        callApiPayment()
    }

    private fun callApiPayment() {
        val retrofit: Retrofit = Retrofit.Builder()
                //.client(client)
                .baseUrl("https://demo-ipg.ctdev.comtrust.ae:2443")
                .addConverterFactory(GsonConverterFactory.create())
                .build()


        fun obj(): DetailsRequest {
            return DetailsRequest(
                    Authorization(
                            Amount = "28.90",
                            CardNumber = "4111111111111111",
                            Channel = "W",
                            Currency = "AED",
                            Customer = "Demo Merchant",
                            ExpiryMonth = "12",
                            ExpiryYear = "2021",
                            Language = "en",
                            OrderID = "000000575",
                            OrderName = "Parle Kreams Gold - ",
                            Password = "Comtrust@20182018",
                            TransactionHint = "CPT:Y;",
                            UserName = "Demo_fY9c",
                            VerifyCode = "123"
                    )
            )
        }


        val request = retrofit.create(ApiInterface::class.java)

        request.apiPaymentCall(obj()).enqueue(object : Callback<DetailsResponse?> {
            override fun onResponse(
                    call: Call<DetailsResponse?>,
                    response: Response<DetailsResponse?>
            ) {
                println("Response Success---->${response.body()}")
                if (response.isSuccessful) {
                    print("Payment Success")
                    response.body().let {
                        if (it != null) {
                            if (it.Transaction.ResponseClassDescription.equals("Success")) {
                                val returnIntent = Intent()
                                returnIntent.putExtra("flag", true)
                                returnIntent.putExtra("message", it.Transaction.ResponseDescription)
                                setResult(RESULT_OK, returnIntent)
                                finish()
                            } else if (it.Transaction.ResponseClassDescription.equals("Error")) {
                                val returnIntent = Intent()
                                returnIntent.putExtra("flag", false)
                                returnIntent.putExtra("message", it.Transaction.ResponseDescription)
                                setResult(RESULT_OK, returnIntent)
                                finish()
                            }else {
                                val returnIntent = Intent()
                                setResult(RESULT_CANCELED, returnIntent)
                                finish()
                                Toast.makeText(
                                        applicationContext,
                                        it.Transaction.ResponseDescription,
                                        Toast.LENGTH_LONG
                                ).show()
                            }
                        } else {
                            val returnIntent = Intent()
                            setResult(RESULT_CANCELED, returnIntent)
                            finish()
                        }
                    }
                }
            }

            override fun onFailure(call: Call<DetailsResponse?>, t: Throwable) {
                println("Response Failure---->${t}")
            }
        })

    }
}